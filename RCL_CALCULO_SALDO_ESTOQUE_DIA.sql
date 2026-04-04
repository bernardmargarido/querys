ALTER PROC [dbo].[CORP_CALCSALDO]    
    @DATAINI VARCHAR(10),
    @DATAFIM VARCHAR(10),
    @FILIAL  VARCHAR(4),
    @LOCAL   VARCHAR(2)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Entradas SD1 (Notas de Entrada)
    ;WITH CTE_SD1 AS (
        SELECT 
            SD1.D1_COD AS PRODUTO,
            SUM(SD1.D1_QUANT) AS QTD_ENTRADA
        FROM SD1010 SD1 WITH (NOLOCK)
        INNER JOIN SF4010 SF4 WITH (NOLOCK)
            ON SF4.F4_CODIGO = SD1.D1_TES
           AND SF4.F4_ESTOQUE = 'S'
           AND SF4.D_E_L_E_T_ = ' '
        WHERE SD1.D1_FILIAL = @FILIAL
          AND SD1.D1_LOCAL  = @LOCAL
          AND SD1.D1_DTDIGIT BETWEEN @DATAINI AND @DATAFIM
          AND SD1.D1_ORIGLAN <> 'LF'
          AND SD1.D_E_L_E_T_ = ''
        GROUP BY SD1.D1_COD
    ),

    -- 2. Entradas SD3 (Movimentações internas)
    CTE_SD3_ENT AS (
        SELECT 
            D3_COD AS PRODUTO,
            SUM(D3_QUANT) AS QTD_ENTRADA
        FROM SD3010 WITH (NOLOCK)
        WHERE D3_FILIAL = @FILIAL
          AND D3_LOCAL  = @LOCAL
          AND D3_EMISSAO BETWEEN @DATAINI AND @DATAFIM
          AND D3_TM <= '499'
          AND D3_ESTORNO <> 'S'
          AND D_E_L_E_T_ = ''
        GROUP BY D3_COD
    ),

    -- 3. Saídas SD2 (Notas de Saída)
    CTE_SD2 AS (
        SELECT 
            SD2.D2_COD AS PRODUTO,
            SUM(SD2.D2_QUANT) AS QTD_SAIDA
        FROM SD2010 SD2 WITH (NOLOCK)
        INNER JOIN SF4010 SF4 WITH (NOLOCK)
            ON SF4.F4_CODIGO = SD2.D2_TES
           AND SF4.F4_ESTOQUE = 'S'
           AND SF4.D_E_L_E_T_ = ' '
        WHERE SD2.D2_FILIAL = @FILIAL
          AND SD2.D2_LOCAL  = @LOCAL
          AND SD2.D2_EMISSAO BETWEEN @DATAINI AND @DATAFIM
          AND SD2.D2_ORIGLAN <> 'LF'
          AND SD2.D_E_L_E_T_ = ''
        GROUP BY SD2.D2_COD
    ),

    -- 4. Saídas SD3 (Movimentações internas)
    CTE_SD3_SAI AS (
        SELECT 
            D3_COD AS PRODUTO,
            SUM(D3_QUANT) AS QTD_SAIDA
        FROM SD3010 WITH (NOLOCK)
        WHERE D3_FILIAL = @FILIAL
          AND D3_LOCAL  = @LOCAL
          AND D3_EMISSAO BETWEEN @DATAINI AND @DATAFIM
          AND D3_TM > '499'
          AND D3_ESTORNO <> 'S'
          AND D_E_L_E_T_ = ''
        GROUP BY D3_COD
    )

    -- 5. Consolidação de saldos
    SELECT 
        '24996224' AS ID_Business,
        @FILIAL AS filial,
        '24996224' + RTRIM(B1.B1_COD) AS ID_SKU,
        B1.B1_COD AS produto,
        @LOCAL AS armazem,
        -- Cálculo do saldo consolidado
        SUM(ISNULL(B9.B9_QINI, 0))
        + SUM(ISNULL(S1.QTD_ENTRADA, 0))
        + SUM(ISNULL(S3E.QTD_ENTRADA, 0))
        - SUM(ISNULL(S2.QTD_SAIDA, 0))
        - SUM(ISNULL(S3S.QTD_SAIDA, 0)) AS saldo,
        0 AS valor_atual,
        ISNULL(AVG(B9.B9_CM1), 0) AS custo_medio,
        CAST(@DATAINI AS DATETIME) AS data_estoque,
		CAST(@DATAFIM AS DATETIME) AS data_calculo,
        ROW_NUMBER() OVER (ORDER BY B1.B1_COD) AS R_E_C_N_O_
    FROM SB1010 B1 WITH (NOLOCK)
    LEFT JOIN SB9010 B9 WITH (NOLOCK)
        ON B9.B9_FILIAL = @FILIAL
       AND B9.B9_LOCAL  = @LOCAL
       AND B9.B9_DATA   = @DATAINI
       AND B9.B9_COD    = B1.B1_COD
       AND B9.D_E_L_E_T_ = ''

    LEFT JOIN CTE_SD1     S1  ON S1.PRODUTO  = B1.B1_COD
    LEFT JOIN CTE_SD3_ENT S3E ON S3E.PRODUTO = B1.B1_COD
    LEFT JOIN CTE_SD2     S2  ON S2.PRODUTO  = B1.B1_COD
    LEFT JOIN CTE_SD3_SAI S3S ON S3S.PRODUTO = B1.B1_COD

    WHERE B1.D_E_L_E_T_ = ''
      AND B1.B1_TIPO = 'ME'
      AND SUBSTRING(B1.B1_COD, 1, 2) NOT IN ('AM', 'UN')

    GROUP BY 
        B1.B1_COD, 
        B1.B1_DESC, 
        B1.B1_TIPO, 
        B1.B1_UM, 
        B1.B1_GRUPO, 
        B1.B1_MSBLQL, 
        B1.B1_POSIPI

    ORDER BY B1.B1_COD;
END
GO

WITH base_produto AS (
    SELECT
        B1_COD,
        ZN_NOME AS familia
    FROM SB1040 B1
    INNER JOIN SZN040 ZN 
        ON ZN.ZN_COD = B1.B1_CATE
        AND ZN.D_E_L_E_T_ = ''
    WHERE 
        B1.D_E_L_E_T_ = ''
        AND ZN.ZN_COD IN ('HSP005','HSP021','HSP055','HSP056','HSP060','HSP057','HSP039','HSP033','HSP011','PRE037')
),
semana_atual AS (
    SELECT
        bp.familia                              as familia,
        DATEPART(WEEK, D2.D2_EMISSAO)           as nr_semana,
        YEAR(D2.D2_EMISSAO)                     as ano,
        SUM(D2.D2_QUANT)                        as total_quantidade,
        SUM(D2.D2_VALBRUT - D2.D2_ICMSRET - 
            D2.D2_VALIPI - D2.D2_VALISS - 
            D2.D2_DESCON - D2.D2_VALIMP5 - 
            D2.D2_VALIMP6 - D2.D2_VALICM + 
            D2.D2_DESCICM  - D2.D2_DIFAL - 
            D2.D2_ICMSCOM - D2.D2_VFCPDIF)      as total_vendido,
        SUM(D2.D2_VALBRUT - D2.D2_ICMSRET - 
            D2.D2_VALIPI - D2.D2_VALISS - 
            D2.D2_DESCON - D2.D2_VALIMP5 - 
            D2.D2_VALIMP6 - D2.D2_VALICM + 
            D2.D2_DESCICM  - D2.D2_DIFAL - 
            D2.D2_ICMSCOM - D2.D2_VFCPDIF) /
        SUM(D2.D2_QUANT)                        as preco_medio,
        SUM(D2.D2_CUSTO1) / SUM(D2.D2_QUANT)    as custo_medio,
        ( SUM(D2.D2_VALBRUT - D2.D2_ICMSRET - 
            D2.D2_VALIPI - D2.D2_VALISS - 
            D2.D2_DESCON - D2.D2_VALIMP5 - 
            D2.D2_VALIMP6 - D2.D2_VALICM + 
            D2.D2_DESCICM  - D2.D2_DIFAL - 
            D2.D2_ICMSCOM - D2.D2_VFCPDIF) -
        SUM(D2.D2_CUSTO1) ) as margem_bruta
    FROM 
        SD2040 D2
		INNER JOIN base_produto bp ON bp.B1_COD = D2.D2_COD
    WHERE
        D2.D2_FILIAL = '0404' 
        AND DATEPART(WEEK, D2.D2_EMISSAO) = DATEPART(WEEK, GETDATE())
        AND YEAR(D2.D2_EMISSAO) = YEAR(GETDATE())
	GROUP BY
        bp.familia,
        DATEPART(WEEK, D2.D2_EMISSAO),
        YEAR(D2.D2_EMISSAO)
),
semana_ano_anterior AS (
    SELECT
        bp.familia                              as familia,
        DATEPART(WEEK, D2.D2_EMISSAO)           as nr_semana,
        YEAR(D2.D2_EMISSAO)                     as ano,
        SUM(D2.D2_QUANT)                        as total_quantidade,
        SUM(D2.D2_VALBRUT - D2.D2_ICMSRET - 
            D2.D2_VALIPI - D2.D2_VALISS - 
            D2.D2_DESCON - D2.D2_VALIMP5 - 
            D2.D2_VALIMP6 - D2.D2_VALICM + 
            D2.D2_DESCICM  - D2.D2_DIFAL - 
            D2.D2_ICMSCOM - D2.D2_VFCPDIF)      as total_vendido,
        SUM(D2.D2_VALBRUT - D2.D2_ICMSRET - 
            D2.D2_VALIPI - D2.D2_VALISS - 
            D2.D2_DESCON - D2.D2_VALIMP5 - 
            D2.D2_VALIMP6 - D2.D2_VALICM + 
            D2.D2_DESCICM  - D2.D2_DIFAL - 
            D2.D2_ICMSCOM - D2.D2_VFCPDIF) /
        SUM(D2.D2_QUANT)                        as preco_medio,
        SUM(D2.D2_CUSTO1) / SUM(D2.D2_QUANT)    as custo_medio,
        ( SUM(D2.D2_VALBRUT - D2.D2_ICMSRET - 
            D2.D2_VALIPI - D2.D2_VALISS - 
            D2.D2_DESCON - D2.D2_VALIMP5 - 
            D2.D2_VALIMP6 - D2.D2_VALICM + 
            D2.D2_DESCICM  - D2.D2_DIFAL - 
            D2.D2_ICMSCOM - D2.D2_VFCPDIF) -
        SUM(D2.D2_CUSTO1) )  as margem_bruta
    FROM 
        SD2040 D2
		INNER JOIN base_produto bp ON bp.B1_COD = D2.D2_COD                             
    WHERE
        D2.D2_FILIAL = '0404' 
        AND DATEPART(WEEK, D2.D2_EMISSAO) = DATEPART(WEEK, GETDATE())
        AND YEAR(D2.D2_EMISSAO) = YEAR(GETDATE()) - 1
    GROUP BY
	    bp.familia,
        DATEPART(WEEK, D2.D2_EMISSAO),
        YEAR(D2.D2_EMISSAO)
),
-- Forecast: agrega por produto no mês correspondente à semana atual
-- e divide pelo número de semanas do mês para obter o valor semanal
forecast_semana AS (
    SELECT
        familia         AS familia,
		SUM(ZX7_FATLIQ) AS total_vendido,
        SUM(ZX7_VLRMB)  AS total_margem,
        SUM(ZX7_QUANT)  AS total_quantidade,
        -- semanas do mês
        (
            DATEPART(WEEK, EOMONTH(DATA_MES))
            - DATEPART(WEEK, DATA_MES)
            + 1
        ) AS nr_semanas_mes,
        -- TOTAL SEMANAL
        ISNULL(
            SUM(ZX7_FATLIQ) / NULLIF(
                (
                    DATEPART(WEEK, EOMONTH(DATA_MES))
                    - DATEPART(WEEK, DATA_MES)
                    + 1
                ),0)
        ,0) AS total_vendido_semana,
        ISNULL(
            SUM(ZX7_QUANT) / NULLIF(
                (
                    DATEPART(WEEK, EOMONTH(DATA_MES))
                    - DATEPART(WEEK, DATA_MES)
                    + 1
                ),0)
        ,0) AS quantidade_semana,
		ISNULL(
            SUM(ZX7_FATLIQ) 
            / NULLIF(SUM(ZX7_QUANT),0)
        ,0) AS preco_medio_previsto,
        ISNULL(
            SUM(ZX7_VLRMB) 
            / NULLIF(
                (
                    DATEPART(WEEK, EOMONTH(DATA_MES))
                    - DATEPART(WEEK, DATA_MES)
                    + 1
                ),0)
        ,0) AS margem_media_previsto
    FROM (
        SELECT
            bp.familia familia,
			ZX7_FAMPRD,
            ZX7_FATLIQ,
            ZX7_VLRMB,
            ZX7_QUANT,
            CAST(
                SUBSTRING(CAST(ZX7_DATA AS VARCHAR(8)),1,4) + '-' +
                SUBSTRING(CAST(ZX7_DATA AS VARCHAR(8)),5,2) + '-01'
            AS DATE) AS DATA_MES
        FROM 
            ZX7040
            INNER JOIN base_produto bp ON bp.B1_COD = ZX7_CODPRD
        WHERE
            ZX7_FILIAL = ''
            AND ZX7_TIPO = 'FORECAST'
            AND ZX7040.D_E_L_E_T_ <> '*'
            AND SUBSTRING(CAST(ZX7_DATA AS VARCHAR(8)),1,6) = FORMAT(GETDATE(), 'yyyyMM')
    ) X
    GROUP BY
        familia,
		ZX7_FAMPRD,
        DATA_MES
),
-- Inventário: saldo consolidado (todos os armazéns) por produto
inventario AS (
    SELECT
        bp.familia                              as familia,
        DATEPART(WEEK, data_estoque)            as nr_semana,
        SUM(saldo)                              as saldo_total,
        SUM(valor_atual)                        as valor_total_estoque,
        MAX(data_estoque)                       as data_estoque
    FROM
        [192.168.50.218].[BI_CORPBRASIL].[dbo].[Inventory]
		INNER JOIN base_produto bp ON bp.B1_COD = produto
    WHERE
		DATEPART(WEEK, data_estoque) = DATEPART(WEEK, GETDATE())
        AND YEAR(data_estoque) = YEAR(GETDATE())
    GROUP BY
        bp.familia,
        DATEPART(WEEK, data_estoque),
        YEAR(data_estoque)
),
inventario_ano_anterior AS (
    SELECT
        bp.familia                              as familia,
        DATEPART(WEEK, data_estoque)            as nr_semana,
        SUM(saldo)                              as saldo_total,
        SUM(valor_atual)                        as valor_total_estoque,
        MAX(data_estoque)                       as data_estoque
    FROM
        [192.168.50.218].[BI_CORPBRASIL].[dbo].[Inventory]
		INNER JOIN base_produto bp ON bp.B1_COD = produto	  
  
    WHERE
       DATEPART(WEEK, data_estoque) = DATEPART(WEEK, GETDATE())
        AND YEAR(data_estoque) = YEAR(GETDATE()) - 1
    GROUP BY
        bp.familia,
        DATEPART(WEEK, data_estoque),
        YEAR(data_estoque)
),
compras_semana AS (
    SELECT 
        codigoFilial,
        familia,
        SUM(quantidade) as quantidade_compra
    FROM 
    ( 
        -- ===============================
        -- IMPORTAÇÃO (SW6 + SW7)
        -- ===============================
        SELECT 	
            RTRIM(W7.W7_FILIAL) as codigoFilial,
            bp.familia AS familia,
            SUM(W7.W7_QTDE) as quantidade
        FROM 
            LABOR_PROD12..SW6040 W6 (NOLOCK)
	        INNER JOIN LABOR_PROD12..SW7040 W7 (NOLOCK) 
                ON W7.W7_FILIAL = W6.W6_FILIAL 
                AND W7.W7_HAWB = W6.W6_HAWB 
                AND W7.D_E_L_E_T_ = ''
            INNER JOIN base_produto bp ON bp.B1_COD = W7.W7_COD_I
		WHERE 	
            W6.W6_DT_ENCE = '' 
            AND W6.W6_NF_ENT = '' 
            AND W6.D_E_L_E_T_ = ''
            AND YEAR(CONVERT(DATE, W6.W6_PRVENTR)) = YEAR(GETDATE())
        GROUP BY W7.W7_FILIAL, bp.familia

        UNION ALL 

        -- ===============================
        -- SALDO DE IMPORTAÇÃO (SW3 + SW5)
        -- ===============================
        SELECT 
            RTRIM(W3.W3_FILIAL) as codigoFilial,
            bp.familia as familia,
            SUM(W5.W5_SALDO_Q) as quantidade
        FROM 
            LABOR_PROD12..SW3040 W3 (NOLOCK)
            INNER JOIN LABOR_PROD12..SW5040 W5 (NOLOCK) 
                ON W5.W5_FILIAL = W3.W3_FILIAL 
                AND W5.W5_COD_I = W3.W3_COD_I 
                AND W5.W5_PO_NUM = W3.W3_PO_NUM 
                AND W5.W5_POSICAO = W3.W3_POSICAO 
                AND W5.W5_SEQ = 0 
                AND W5.W5_SALDO_Q > 0 
                AND W5.D_E_L_E_T_ = ''
            INNER JOIN base_produto bp ON bp.B1_COD = W3.W3_COD_I 
        WHERE 
            W3.W3_SEQ = 1 
            AND W3.D_E_L_E_T_ = ''
            AND YEAR(CONVERT(DATE, W3.W3_DT_ENTR)) = YEAR(GETDATE())
        GROUP BY W3.W3_FILIAL, bp.familia

        UNION ALL 

        -- ===============================
        -- PEDIDOS NACIONAIS (SC7)
        -- ===============================
        SELECT 
            RTRIM(C7.C7_FILIAL) as codigoFilial,
            bp.familia as familia,
            SUM(C7.C7_QUANT) as quantidade
        FROM 
            LABOR_PROD12..SC7040 C7 (NOLOCK)
            INNER JOIN base_produto bp ON bp.B1_COD = C7.C7_PRODUTO
   
        WHERE 
            NOT EXISTS ( 
                SELECT 1
                FROM LABOR_PROD12..SD1040 D1  
                WHERE 
                    D1.D1_FILIAL = C7.C7_FILIAL 
                    AND D1.D1_PEDIDO = C7.C7_NUM 
                    AND D1.D_E_L_E_T_ = '' 
            )
            AND C7.C7_NUMIMP = '' 
            AND (C7.C7_QUANT - C7.C7_QUJE) > 0
            AND C7.D_E_L_E_T_ = ''
            AND YEAR(CONVERT(DATE, C7.C7_DATPRF)) = YEAR(GETDATE())
        GROUP BY C7.C7_FILIAL, bp.familia

    ) X
    GROUP BY codigoFilial, familia
)
SELECT
    DATEPART(WEEK, GETDATE())                                               as nr_semana,
    COALESCE(sa.familia, saa.familia, fc.familia, inv.familia)              as familia,
    ISNULL(sa.total_quantidade,0)                                           as volume_vendas_real,
    ISNULL(fc.quantidade_semana,0)                                          as volume_vendas_previsto,
    ISNULL(saa.total_quantidade,0)                                          as volume_vendas_anterior,
    ISNULL(sa.total_vendido, 0)                                             as valor_vendas_real,
    ISNULL(fc.total_vendido_semana,0)                                       as valor_vendas_previsto,
    ISNULL(saa.total_vendido, 0)                                            as valor_vendas_anterior,
    ISNULL(sa.preco_medio, 0)                                               as preco_medio_real,
    ISNULL(fc.preco_medio_previsto, 0)                                      as preco_medio_previsto,
    ISNULL(saa.preco_medio, 0)                                              as preco_medio_anterior,
    ISNULL(sa.custo_medio, 0)                                               as custo_medio_real,
    0                                                                       as custo_medio_previsto,
    ISNULL(saa.custo_medio, 0)                                              as custo_medio_anterior,
    ISNULL(sa.margem_bruta, 0)                                              as margem_bruta_real,
    ISNULL(fc.margem_media_previsto,0)                                      as margem_bruta_previsto,
    ISNULL(saa.margem_bruta, 0)                                             as margem_bruta_anterior,
    ISNULL(inv.saldo_total,0)                                               as nivel_estoque_real,
    0                                                                       as nivel_estoque_previsto,
    ISNULL(inva.saldo_total,0)                                              as nivel_estoque_anterior,
    ISNULL(com.quantidade_compra,0)                                         as compras_estoque_real,
    0                                                                       as compras_estoque_previsto,
    0                                                                       as compras_estoque_anterior,
    0                                                                       as custo_aquisicao_real,
    0                                                                       as custo_aquisicao_previsto,
    0                                                                       as custo_aquisicao_anterior
FROM 
    semana_atual sa
    FULL OUTER JOIN semana_ano_anterior saa
        ON sa.familia = saa.familia
    FULL OUTER JOIN forecast_semana fc
        ON COALESCE(sa.familia, saa.familia) = fc.familia
    FULL OUTER JOIN inventario inv
        ON COALESCE(sa.familia, saa.familia, fc.familia) = inv.familia
    FULL OUTER JOIN inventario_ano_anterior inva
        ON COALESCE(sa.familia, saa.familia, fc.familia, inv.familia) = inva.familia
    FULL OUTER JOIN compras_semana com
        ON COALESCE(sa.familia, saa.familia, fc.familia, inv.familia, inva.familia) = com.familia
ORDER BY
    COALESCE(sa.familia, saa.familia, fc.familia, inv.familia)
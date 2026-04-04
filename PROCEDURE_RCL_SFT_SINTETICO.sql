CREATE OR ALTER PROCEDURE dbo.chk_rcl_notas_sintetico
(
    @FilialDe   VARCHAR(4),
    @FilialAte  VARCHAR(4),
    @DataDe     CHAR(8),  -- formato AAAAMMDD
    @DataAte    CHAR(8)   -- formato AAAAMMDD
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        FT.FT_FILIAL           AS filial, 
        FT.FT_ENTRADA          AS dataEntrada, 
        FT.FT_EMISSAO          AS dataEmissao, 
        FT.FT_NFISCAL          AS nota, 
        FT.FT_SERIE            AS serie, 
        CASE 
            WHEN FT.FT_TIPOMOV = 'S' AND FT.FT_TIPO IN('','N') THEN A1.A1_CGC 
            WHEN FT.FT_TIPOMOV = 'S' AND FT.FT_TIPO IN('B','D') THEN A2.A2_CGC 
            WHEN FT.FT_TIPOMOV = 'E' AND FT.FT_TIPO IN(' ','N') THEN A2.A2_CGC 
            WHEN FT.FT_TIPOMOV = 'E' AND FT.FT_TIPO IN('B','D') THEN A1.A1_CGC 
        END AS cnpj_cpf, 
        SUM(FT.FT_VALCONT)     AS valorContabil, 
        SUM(FT.FT_BASEICM)     AS baseICMS, 
        SUM(FT.FT_VALICM)      AS valorICMS, 
        SUM(FT.FT_ISENICM)     AS valorIsentoICMS,  
        SUM(FT.FT_OUTRICM)     AS valorOutrosICMS, 
        SUM(FT.FT_BASEIPI)     AS baseIPI,  
        SUM(FT.FT_VALIPI)      AS valorIPI, 
        SUM(FT.FT_ISENIPI)     AS valorIsentoIPI, 
        SUM(FT.FT_OUTRIPI)     AS valorOutrosIPI, 
        SUM(FT.FT_BASERET)     AS baseRetencaoST, 
        SUM(FT.FT_ICMSRET)     AS valorICMSRetido, 
        FT.FT_TIPO             AS tipoNota, 
        SUM(FT.FT_ICMSCOM)     AS valorICMSComplementar, 
        SUM(FT.FT_IPIOBS)      AS valorIPIImpresso, 
        FT.FT_ESPECIE          AS especie, 
        FT.FT_TIPOMOV          AS tipoMovimentacao, 
        SUM(FT.FT_FRETE)       AS valorFrete, 
        SUM(FT.FT_SEGURO)      AS valorSeguro,  
        SUM(FT.FT_DESPESA)     AS valorDespesa, 
        SUM(FT.FT_QUANT)       AS quantidade, 
        SUM(FT.FT_DESCONT)     AS valorDesconto, 
        SUM(FT.FT_BRETPIS)     AS basePIS, 
        SUM(FT.FT_VALPIS)      AS valorPIS, 
        SUM(FT.FT_BASECOF)     AS baseCofins, 
        SUM(FT.FT_VALCOF)      AS valorCofins, 
        FT.FT_CHVNFE           AS chaveNFE, 
        SUM(FT.FT_VALFECP)     AS valorFECP, 
        SUM(FT.FT_MVALCOF)     AS valorCofinsMajorada, 
        SUM(FT.FT_DIFAL)       AS valorDifal
    FROM SFT010 FT
        LEFT JOIN SA1010 A1 ON A1.A1_FILIAL = '' AND A1.A1_COD = FT.FT_CLIEFOR AND A1.A1_LOJA = FT.FT_LOJA AND A1.D_E_L_E_T_ = ''
        LEFT JOIN SA2010 A2 ON A2.A2_FILIAL = '' AND A2.A2_COD = FT.FT_CLIEFOR AND A2.A2_LOJA = FT.FT_LOJA AND A2.D_E_L_E_T_ = ''
    WHERE 
        FT.FT_FILIAL BETWEEN @FilialDe AND @FilialAte
        AND FT.FT_ENTRADA BETWEEN @DataDe AND @DataAte
        AND FT.FT_NATOPER NOT IN ('037','018')
        AND FT.D_E_L_E_T_ = ''
    GROUP BY 
        FT.FT_FILIAL, 
        FT.FT_ENTRADA, 
        FT.FT_EMISSAO, 
        FT.FT_NFISCAL, 
        FT.FT_SERIE, 
        A1.A1_CGC,
        A2.A2_CGC,
        FT.FT_TIPO,
        FT.FT_ESPECIE, 
        FT.FT_TIPOMOV, 
        FT.FT_CHVNFE
    ORDER BY 
        FT.FT_NFISCAL, 
        FT.FT_SERIE
END
GO


--exec chk_rcl_notas_sintetico '0101','0101','20260104','20260104'
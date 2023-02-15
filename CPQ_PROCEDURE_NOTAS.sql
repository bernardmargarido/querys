USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_orcamentos]    Script Date: 25/11/2022 16:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cpq_notasaida]
	-- Add the parameters for the stored procedure here
@IDPAGESIZE int,
@IDPAGE int,
@IDCLIENTE int,
@DTA_DE varchar(10),
@DTA_ATE varchar(10),
@MES_ANO varchar(10)

AS
BEGIN
	IF @MES_ANO <> '' 
		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			nota, 
			serie
			chaveNfe,
			dataEmissao,
			idCliente,
			razaoCliente, 
			idTabela,
			tipoFrete,
			valorFrete,
			idCondicao,
			subTotal,
			valorTotal					
		 FROM 
		 ( 
			SELECT 
				ROW_NUMBER() OVER(ORDER BY F2_EMISSAO DESC) rNum, 
				RTRIM(F2.F2_FILIAL) codigoFilial, 
				RTRIM(F2.F2_DOC) nota,
				RTRIM(F2.F2_SERIE) serie,
				RTRIM(F2.F2_CHVNFE) chaveNfe,
				convert(varchar,convert(date,F2.F2_EMISSAO,101),121) dataEmissao, 
				A1.R_E_C_N_O_ idCliente,
				RTRIM(A1.A1_NOME) razaoCliente, 
				DA0.R_E_C_N_O_ idTabela,
				RTRIM(F2.F2_TPFRETE) tipoFrete,
				F2.F2_FRETE valorFrete,
				RTRIM(E4.R_E_C_N_O_) idCondicao,
				F2.F2_VALMERC subTotal,
				F2.F2_VALFAT valorTotal

			FROM 
				[LABOR-PROD12]..SF2040 F2 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '    ' AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..DA0040 DA0 WITH(NOLOCK) ON DA0.DA0_FILIAL = F2.F2_FILIAL AND DA0.DA0_CODTAB = A1.A1_TABELA AND DA0.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SE4040 E4 WITH(NOLOCK) ON E4.E4_FILIAL = '    ' AND E4.E4_CODIGO = F2.F2_COND AND E4.D_E_L_E_T_ = '' 
			WHERE 
				F2.F2_CLIENTE = A1.A1_COD AND 
				F2.F2_LOJA = A1.A1_LOJA AND 
				F2.F2_TIPO = 'N' AND 
   				SUBSTRING(F2.F2_EMISSAO,1,4) BETWEEN SUBSTRING(@MES_ANO,3,4) AND SUBSTRING(@MES_ANO,3,4) AND
				SUBSTRING(F2.F2_EMISSAO,5,2) BETWEEN SUBSTRING(@MES_ANO,1,2) AND SUBSTRING(@MES_ANO,1,2) AND
				F2.D_E_L_E_T_ = '' 
		 )NOTAS 
		 WHERE	rNum > @IDPAGESIZE * (@IDPAGE - 1) 
	ELSE IF @IDCLIENTE > 0
		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			nota, 
			serie,
			chaveNfe,
			dataEmissao,
			idCliente,
			razaoCliente, 
			idTabela,
			tipoFrete,
			valorFrete,
			idCondicao,
			subTotal,
			valorTotal				
		 FROM 
		 ( 
			SELECT 
				ROW_NUMBER() OVER(ORDER BY F2_EMISSAO DESC) rNum, 
				RTRIM(F2.F2_FILIAL) codigoFilial, 
				RTRIM(F2.F2_DOC) nota,
				RTRIM(F2.F2_SERIE) serie,
				RTRIM(F2.F2_CHVNFE) chaveNfe,
				convert(varchar,convert(date,F2.F2_EMISSAO,101),121) dataEmissao, 
				A1.R_E_C_N_O_ idCliente,
				RTRIM(A1.A1_NOME) razaoCliente, 
				DA0.R_E_C_N_O_ idTabela,
				RTRIM(F2.F2_TPFRETE) tipoFrete,
				F2.F2_FRETE valorFrete,
				RTRIM(E4.R_E_C_N_O_) idCondicao,
				F2.F2_VALMERC subTotal,
				F2.F2_VALFAT valorTotal	
			FROM 
				[LABOR-PROD12]..SF2040 F2 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '    ' AND A1.R_E_C_N_O_ = @IDCLIENTE AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..DA0040 DA0 WITH(NOLOCK) ON DA0.DA0_FILIAL = F2.F2_FILIAL AND DA0.DA0_CODTAB = A1.A1_TABELA AND DA0.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SE4040 E4 WITH(NOLOCK) ON E4.E4_FILIAL = '    ' AND E4.E4_CODIGO = F2.F2_COND AND E4.D_E_L_E_T_ = '' 
			WHERE 
				F2.F2_CLIENTE = A1.A1_COD AND 
				F2.F2_LOJA = A1.A1_LOJA AND 
				F2.F2_TIPO = 'N' AND 
   				F2.F2_EMISSAO BETWEEN @DTA_DE AND @DTA_ATE AND
				F2.D_E_L_E_T_ = '' 
		 )NOTAS 
		 WHERE	rNum > @IDPAGESIZE * (@IDPAGE - 1) 
	end
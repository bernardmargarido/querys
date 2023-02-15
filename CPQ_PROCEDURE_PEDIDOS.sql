USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_pedidos]    Script Date: 04/11/2022 19:54:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cpq_pedidos]
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
			pedido, 
			idECommerce, 
			dataEmissao, 
			razaoCliente, 
			totalPedido, 
			totalFrete, 
			totalDesconto, 
			chaveNFe, 
			statusPedido, 
			serieNota, 
			numeroNota
		 FROM 
		 ( 
			SELECT 
				ROW_NUMBER() OVER(ORDER BY C5_EMISSAO DESC) rNum, 
				RTRIM(C5.C5_FILIAL) codigoFilial, 
				RTRIM(C5.C5_NUM) pedido, 
				RTRIM(C5.C5_XNUMECL) idECommerce, 
				convert(varchar,convert(date,C5.C5_EMISSAO,101),121) dataEmissao, 
				RTRIM(A1.A1_NOME) razaoCliente, 
				CASE WHEN F2.F2_VALBRUT <> 0 THEN F2.F2_VALBRUT ELSE C5.C5_XVALOR END totalPedido, 
				CASE WHEN F2.F2_FRETE <> 0 THEN F2.F2_FRETE ELSE C5.C5_FRETE END totalFrete, 
				CASE WHEN DESCONTO_NOTA.D2_DESC <> 0 THEN DESCONTO_NOTA.D2_DESC ELSE DESCONTO_PEDIDO.C6_VALDESC END totalDesconto, 
				COALESCE(RTRIM(F2.F2_CHVNFE),'') chaveNFe, 
				COALESCE(RTRIM(STATUS_PEDIDO.Z04_DESC),'') statusPedido, 
				COALESCE(RTRIM(F2.F2_SERIE),'') serieNota, 
				COALESCE(RTRIM(F2.F2_DOC),'') numeroNota 
			FROM 
				[LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '    ' AND A1.D_E_L_E_T_ = '' 
				LEFT JOIN [LABOR-PROD12]..SA4040 A4 WITH(NOLOCK) ON A4.A4_FILIAL = '    ' AND A4.A4_COD = C5.C5_TRANSP AND A4.D_E_L_E_T_ = '' 
				LEFT JOIN [LABOR-PROD12]..SF2040 F2 WITH(NOLOCK) ON F2.F2_FILIAL = C5.C5_FILIAL AND F2.F2_DOC = C5.C5_NOTA AND F2.F2_SERIE = C5.C5_SERIE AND F2.D_E_L_E_T_ = '' 
				CROSS APPLY( 
							SELECT 
								TOP 1 
								Z04.Z04_DESC 
							FROM 
								[LABOR-PROD12]..Z05040 Z05 
   								INNER JOIN [LABOR-PROD12]..Z04040 Z04 ON Z04.Z04_FILIAL = '    ' AND Z04.Z04_COD = Z05.Z05_STATUS AND Z04.D_E_L_E_T_ = '' 
							WHERE 
								Z05.Z05_FILIAL = C5.C5_FILIAL AND 
								Z05.Z05_PEDIDO = C5.C5_NUM AND 
								Z05.D_E_L_E_T_ = '' 
							ORDER BY Z05.Z05_DATA DESC 
				)STATUS_PEDIDO 
				OUTER APPLY( 
							SELECT 
								SUM(D2.D2_DESC) D2_DESC 
							FROM 
								[LABOR-PROD12]..SD2040 D2 WITH(NOLOCK) 
							WHERE 
								D2.D2_FILIAL = F2.F2_FILIAL AND 
								D2.D2_DOC = F2.F2_DOC AND 
								D2.D2_SERIE = F2.F2_SERIE AND 
								D2.D_E_L_E_T_ = '' 
				)DESCONTO_NOTA 
				CROSS APPLY( 
							SELECT 
								SUM(C6.C6_VALDESC) C6_VALDESC 
							FROM 
								[LABOR-PROD12]..SC6040 C6 WITH(NOLOCK) 
							WHERE 
								C6.C6_FILIAL = C5.C5_FILIAL AND 
								C6.C6_NUM = C5.C5_NUM AND 
								C6.D_E_L_E_T_ = '' 
				)DESCONTO_PEDIDO 
			WHERE 
				C5.C5_CLIENTE = A1.A1_COD AND 
				C5.C5_LOJACLI = A1.A1_LOJA AND 
				C5.C5_TIPO = 'N' AND 
   				SUBSTRING(C5.C5_EMISSAO,1,4) BETWEEN SUBSTRING(@MES_ANO,3,4) AND SUBSTRING(@MES_ANO,3,4) AND
				SUBSTRING(C5.C5_EMISSAO,5,2) BETWEEN SUBSTRING(@MES_ANO,1,2) AND SUBSTRING(@MES_ANO,1,2) AND
				C5.D_E_L_E_T_ = '' 
		 )PEDIDOS 
		 WHERE	rNum > @IDPAGESIZE * (@IDPAGE - 1) 
	ELSE

		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			pedido, 
			idECommerce, 
			dataEmissao, 
			razaoCliente, 
			totalPedido, 
			totalFrete, 
			totalDesconto, 
			chaveNFe, 
			statusPedido, 
			serieNota, 
			numeroNota
		 FROM 
		 ( 
			SELECT 
				ROW_NUMBER() OVER(ORDER BY C5_EMISSAO DESC) rNum, 
				RTRIM(C5.C5_FILIAL) codigoFilial, 
				RTRIM(C5.C5_NUM) pedido, 
				RTRIM(C5.C5_XNUMECL) idECommerce, 
				convert(varchar,convert(date,C5.C5_EMISSAO,101),121) dataEmissao, 
				RTRIM(A1.A1_NOME) razaoCliente, 
				CASE WHEN F2.F2_VALBRUT <> 0 THEN F2.F2_VALBRUT ELSE C5.C5_XVALOR END totalPedido, 
				CASE WHEN F2.F2_FRETE <> 0 THEN F2.F2_FRETE ELSE C5.C5_FRETE END totalFrete, 
				CASE WHEN DESCONTO_NOTA.D2_DESC <> 0 THEN DESCONTO_NOTA.D2_DESC ELSE DESCONTO_PEDIDO.C6_VALDESC END totalDesconto, 
				COALESCE(RTRIM(F2.F2_CHVNFE),'') chaveNFe, 
				COALESCE(RTRIM(STATUS_PEDIDO.Z04_DESC),'') statusPedido, 
				COALESCE(RTRIM(F2.F2_SERIE),'') serieNota, 
				COALESCE(RTRIM(F2.F2_DOC),'') numeroNota 
			FROM 
				[LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '    ' AND A1.R_E_C_N_O_ = @IDCLIENTE AND A1.D_E_L_E_T_ = '' 
				LEFT JOIN [LABOR-PROD12]..SA4040 A4 WITH(NOLOCK) ON A4.A4_FILIAL = '    ' AND A4.A4_COD = C5.C5_TRANSP AND A4.D_E_L_E_T_ = '' 
				LEFT JOIN [LABOR-PROD12]..SF2040 F2 WITH(NOLOCK) ON F2.F2_FILIAL = C5.C5_FILIAL AND F2.F2_DOC = C5.C5_NOTA AND F2.F2_SERIE = C5.C5_SERIE AND F2.D_E_L_E_T_ = '' 
				CROSS APPLY( 
							SELECT 
								TOP 1 
								Z04.Z04_DESC 
							FROM 
								[LABOR-PROD12]..Z05040 Z05 
   								INNER JOIN [LABOR-PROD12]..Z04040 Z04 ON Z04.Z04_FILIAL = '    ' AND Z04.Z04_COD = Z05.Z05_STATUS AND Z04.D_E_L_E_T_ = '' 
							WHERE 
								Z05.Z05_FILIAL = C5.C5_FILIAL AND 
								Z05.Z05_PEDIDO = C5.C5_NUM AND 
								Z05.D_E_L_E_T_ = '' 
							ORDER BY Z05.Z05_DATA DESC 
				)STATUS_PEDIDO 
				OUTER APPLY( 
							SELECT 
								SUM(D2.D2_DESC) D2_DESC 
							FROM 
								[LABOR-PROD12]..SD2040 D2 WITH(NOLOCK) 
							WHERE 
								D2.D2_FILIAL = F2.F2_FILIAL AND 
								D2.D2_DOC = F2.F2_DOC AND 
								D2.D2_SERIE = F2.F2_SERIE AND 
								D2.D_E_L_E_T_ = '' 
				)DESCONTO_NOTA 
				CROSS APPLY( 
							SELECT 
								SUM(C6.C6_VALDESC) C6_VALDESC 
							FROM 
								[LABOR-PROD12]..SC6040 C6 WITH(NOLOCK) 
							WHERE 
								C6.C6_FILIAL = C5.C5_FILIAL AND 
								C6.C6_NUM = C5.C5_NUM AND 
								C6.D_E_L_E_T_ = '' 
				)DESCONTO_PEDIDO 
			WHERE 
				C5.C5_CLIENTE = A1.A1_COD AND 
				C5.C5_LOJACLI = A1.A1_LOJA AND 
				C5.C5_TIPO = 'N' AND 
   				C5.C5_EMISSAO BETWEEN @DTA_DE AND @DTA_ATE AND
				C5.D_E_L_E_T_ = '' 
		 )PEDIDOS 
		 WHERE	rNum > @IDPAGESIZE * (@IDPAGE - 1) 
	end
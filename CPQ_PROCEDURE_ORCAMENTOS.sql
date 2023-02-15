USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_orcamentos]    Script Date: 23/01/2023 16:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[cpq_orcamentos]
	-- Add the parameters for the stored procedure here
@IDPAGESIZE int,
@IDPAGE int,
@IDCLIENTE int,
@IDVENDEDOR int,
@DTA_DE varchar(10),
@DTA_ATE varchar(10),
@MES_ANO varchar(10)

AS
BEGIN
	IF @MES_ANO <> '' 
		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			orcamento, 
			dataEmissao,
			idCliente,
			razaoCliente, 
			tipoRegistro,
			idVendedor,
			nomeVendedor,
			idTabela,
			tipoFrete,
			valorFrete,
			idCondicao,
			obsFinanceira,
			obsPedido,
			obsEntrega,
			obsComercial,
			pedidoERP,
			nota,
			serie,
			chaveNfe,
			subTotal,
			total,
			status
		 FROM 
		 ( 
			SELECT 
				ROW_NUMBER() OVER(ORDER BY UA_EMISSAO DESC) rNum, 
				RTRIM(UA.UA_FILIAL) codigoFilial, 
				RTRIM(UA.UA_NUM) orcamento, 
				convert(varchar,convert(date,UA.UA_EMISSAO,101),121) dataEmissao, 
				A1.R_E_C_N_O_ idCliente,
				RTRIM(A1.A1_NOME) razaoCliente, 
				'cliente' tipoRegistro,
				A3.R_E_C_N_O_ idVendedor,
				A3.A3_NOME nomeVendedor,
				DA0.R_E_C_N_O_ idTabela,
				RTRIM(UA.UA_XTPFRET) tipoFrete,
				CASE 
					WHEN F2.F2_DOC <> '' THEN 
						F2.F2_FRETE 
					WHEN C5.C5_NUM <> '' THEN 
						C5.C5_FRETE
					ELSE 
						UA.UA_FRETE 
				END valorFrete,
				RTRIM(E4.R_E_C_N_O_) idCondicao,
				COALESCE(RTRIM(UA.UA_XOBSFIN),'') obsFinanceira,
				COALESCE(RTRIM(UA.UA_XOBSLO),'') obsPedido,
				COALESCE(RTRIM(UA.UA_XOBSEXP),'') obsEntrega,
				COALESCE(RTRIM(UA.UA_XOBSCO),'') obsComercial,
				COALESCE(RTRIM(C5.C5_NUM),'') pedidoERP,
				COALESCE(RTRIM(F2.F2_DOC),'') nota,
				COALESCE(RTRIM(F2.F2_SERIE),'') serie,
				COALESCE(RTRIM(F2.F2_CHVNFE),'') chaveNfe,
				CASE 
					WHEN F2.F2_DOC <> '' THEN 
						F2.F2_VALMERC 
					WHEN C5.C5_NUM <> '' THEN 
						TOTAL_PEDIDO.C6_VALOR 
					ELSE 
						TOTAL_ORC.UB_VLRITEM
				END	subTotal,
				CASE 
					WHEN F2.F2_DOC <> '' THEN 
						F2.F2_VALFAT 
					WHEN C5.C5_NUM <> '' THEN 
						TOTAL_PEDIDO.C6_VALOR + C5.C5_FRETE 
					ELSE 
						TOTAL_ORC.UB_VLRITEM + UA.UA_FRETE
				END total,
				CASE 
					WHEN STATUS_PV.Z04_DESC <> '' THEN 
						COALESCE(RTRIM(STATUS_PV.Z05_STATUS),'') 
					WHEN UA.UA_CANC <> '' THEN 
						'' 
					ELSE 
						''
				END status
			FROM 
				[LABOR-PROD12]..SUA040 UA WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '    ' AND A1.A1_COD = UA.UA_CLIENTE AND A1.A1_LOJA = UA.UA_LOJA AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..DA0040 DA0 WITH(NOLOCK) ON DA0.DA0_FILIAL = UA.UA_FILIAL AND DA0.DA0_CODTAB = A1.A1_TABELA AND DA0.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SA3040 A3 WITH(NOLOCK) ON A3.A3_FILIAL = '    ' AND A3.A3_COD = UA.UA_VEND AND A3.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SE4040 E4 WITH(NOLOCK) ON E4.E4_FILIAL = '    ' AND E4.E4_CODIGO = UA.UA_CONDPG AND E4.D_E_L_E_T_ = '' 
				LEFT JOIN [LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) ON C5.C5_FILIAL = UA.UA_FILIAL AND C5.C5_NUM = UA.UA_NUMSC5 AND C5.C5_CLIENTE = UA.UA_CLIENTE AND C5.C5_LOJACLI = UA.UA_LOJA AND C5.D_E_L_E_T_ = ''
				LEFT JOIN [LABOR-PROD12]..SF2040 F2 WITH(NOLOCK) ON F2.F2_FILIAL = C5.C5_FILIAL AND F2.F2_DOC = C5.C5_NOTA AND F2.F2_SERIE = C5.C5_SERIE AND F2.D_E_L_E_T_ = ''
				OUTER APPLY(
					SELECT 
						TOP 1 
						Z05.Z05_STATUS,
						Z04.Z04_DESC,
						Z05.Z05_DATA,
						Z05.Z05_HORA
					FROM 
						[LABOR-PROD12]..Z05040 Z05 WITH(NOLOCK) 
						INNER JOIN [LABOR-PROD12]..Z04040 Z04 WITH(NOLOCK) ON Z04.Z04_FILIAL = '' AND Z04.Z04_COD = Z05.Z05_STATUS AND Z04.D_E_L_E_T_ = ''
					WHERE 
						Z05.Z05_FILIAL = C5.C5_FILIAL AND 
						Z05.Z05_PEDIDO = C5.C5_NUM AND 
						Z05.D_E_L_E_T_ = ''
					ORDER BY Z05_DATA,Z05_HORA DESC
				)STATUS_PV
				OUTER APPLY(
					SELECT 
						SUM(C6.C6_VALOR) C6_VALOR
					FROM 
						[LABOR-PROD12]..SC6040 C6
					WHERE 
						C6.C6_FILIAL = C5.C5_FILIAL AND 
						C6.C6_NUM = C5.C5_NUM AND 
						C6.C6_BLQ = '' AND 
						C6.D_E_L_E_T_ = ''
					GROUP BY C6.C6_FILIAL, C6.C6_NUM 
				)TOTAL_PEDIDO 
				OUTER APPLY(
					SELECT 
						SUM(UB.UB_VLRITEM) UB_VLRITEM
					FROM 
						[LABOR-PROD12]..SUB040 UB
					WHERE 
						UB.UB_FILIAL = UA.UA_FILIAL AND 
						UB.UB_NUM = UA.UA_NUM AND 
						UB.D_E_L_E_T_ = ''
					GROUP BY UB.UB_FILIAL, UB.UB_NUM 
				)TOTAL_ORC
			WHERE 
				UA.UA_EMISSAO BETWEEN CONVERT(VARCHAR,CONVERT(date,SUBSTRING(@MES_ANO,1,2) + '/' + '01' + '/' + SUBSTRING(@MES_ANO,3,4)),112) AND CONVERT(VARCHAR,EOMONTH(CONVERT(date,SUBSTRING(@MES_ANO,1,2) + '/' + '01' + '/' + SUBSTRING(@MES_ANO,3,4))),112) AND
   				--SUBSTRING(UA.UA_EMISSAO,1,4) BETWEEN SUBSTRING(@MES_ANO,3,4) AND SUBSTRING(@MES_ANO,3,4) AND
				--SUBSTRING(UA.UA_EMISSAO,5,2) BETWEEN SUBSTRING(@MES_ANO,1,2) AND SUBSTRING(@MES_ANO,1,2) AND
				UA.D_E_L_E_T_ = '' 
		 )ORCAMENTOS 
		 WHERE	rNum > @IDPAGESIZE * (@IDPAGE - 1) 
	ELSE IF @IDCLIENTE > 0 AND @IDVENDEDOR = 0
		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			orcamento, 
			dataEmissao,
			idCliente,
			razaoCliente, 
			tipoRegistro,
			idVendedor,
			nomeVendedor,
			idTabela,
			tipoFrete,
			valorFrete,
			idCondicao,
			obsFinanceira,
			obsPedido,
			obsEntrega,
			obsComercial,
			pedidoERP,
			nota,
			serie,
			chaveNfe,
			subTotal,
			total,
			status
		 FROM 
		 ( 
			SELECT 
				ROW_NUMBER() OVER(ORDER BY UA_EMISSAO DESC) rNum, 
				RTRIM(UA.UA_FILIAL) codigoFilial, 
				RTRIM(UA.UA_NUM) orcamento, 
				convert(varchar,convert(date,UA.UA_EMISSAO,101),121) dataEmissao, 
				A1.R_E_C_N_O_ idCliente,
				RTRIM(A1.A1_NOME) razaoCliente, 
				'cliente' tipoRegistro,
				A3.R_E_C_N_O_ idVendedor,
				A3.A3_NOME nomeVendedor,
				DA0.R_E_C_N_O_ idTabela,
				RTRIM(UA.UA_XTPFRET) tipoFrete,
				CASE 
					WHEN F2.F2_DOC <> '' THEN 
						F2.F2_FRETE 
					WHEN C5.C5_NUM <> '' THEN 
						C5.C5_FRETE
					ELSE 
						UA.UA_FRETE 
				END valorFrete,
				RTRIM(E4.R_E_C_N_O_) idCondicao,
				COALESCE(RTRIM(UA.UA_XOBSFIN),'') obsFinanceira,
				COALESCE(RTRIM(UA.UA_XOBSLO),'') obsPedido,
				COALESCE(RTRIM(UA.UA_XOBSEXP),'') obsEntrega,
				COALESCE(RTRIM(UA.UA_XOBSCO),'') obsComercial,
				COALESCE(RTRIM(C5.C5_NUM),'') pedidoERP,
				COALESCE(RTRIM(F2.F2_DOC),'') nota,
				COALESCE(RTRIM(F2.F2_SERIE),'') serie,
				COALESCE(RTRIM(F2.F2_CHVNFE),'') chaveNfe,
				CASE 
					WHEN F2.F2_DOC <> '' THEN 
						F2.F2_VALMERC 
					WHEN C5.C5_NUM <> '' THEN 
						TOTAL_PEDIDO.C6_VALOR 
					ELSE 
						TOTAL_ORC.UB_VLRITEM
				END	subTotal,
				CASE 
					WHEN F2.F2_DOC <> '' THEN 
						F2.F2_VALFAT 
					WHEN C5.C5_NUM <> '' THEN 
						TOTAL_PEDIDO.C6_VALOR + C5.C5_FRETE 
					ELSE 
						TOTAL_ORC.UB_VLRITEM + UA.UA_FRETE
				END total,
				CASE 
					WHEN STATUS_PV.Z04_DESC <> '' THEN 
						COALESCE(RTRIM(STATUS_PV.Z05_STATUS),'') 
					WHEN UA.UA_CANC <> '' THEN 
						'' 
					ELSE 
						''
				END status
			FROM 
				[LABOR-PROD12]..SUA040 UA WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '    ' AND A1.R_E_C_N_O_ = @IDCLIENTE AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..DA0040 DA0 WITH(NOLOCK) ON DA0.DA0_FILIAL = UA.UA_FILIAL AND DA0.DA0_CODTAB = A1.A1_TABELA AND DA0.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SA3040 A3 WITH(NOLOCK) ON A3.A3_FILIAL = '    ' AND A3.A3_COD = UA.UA_VEND AND A3.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SE4040 E4 WITH(NOLOCK) ON E4.E4_FILIAL = '    ' AND E4.E4_CODIGO = UA.UA_CONDPG AND E4.D_E_L_E_T_ = '' 
				LEFT JOIN [LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) ON C5.C5_FILIAL = UA.UA_FILIAL AND C5.C5_NUM = UA.UA_NUMSC5 AND C5.C5_CLIENTE = UA.UA_CLIENTE AND C5.C5_LOJACLI = UA.UA_LOJA AND C5.D_E_L_E_T_ = ''
				LEFT JOIN [LABOR-PROD12]..SF2040 F2 WITH(NOLOCK) ON F2.F2_FILIAL = C5.C5_FILIAL AND F2.F2_DOC = C5.C5_NOTA AND F2.F2_SERIE = C5.C5_SERIE AND F2.D_E_L_E_T_ = ''
				OUTER APPLY(
					SELECT 
						TOP 1 
						Z05.Z05_STATUS,
						Z04.Z04_DESC,
						Z05.Z05_DATA,
						Z05.Z05_HORA
					FROM 
						[LABOR-PROD12]..Z05040 Z05 WITH(NOLOCK) 
						INNER JOIN [LABOR-PROD12]..Z04040 Z04 WITH(NOLOCK) ON Z04.Z04_FILIAL = '' AND Z04.Z04_COD = Z05.Z05_STATUS AND Z04.D_E_L_E_T_ = ''
					WHERE 
						Z05.Z05_FILIAL = C5.C5_FILIAL AND 
						Z05.Z05_PEDIDO = C5.C5_NUM AND 
						Z05.D_E_L_E_T_ = ''
					ORDER BY Z05_DATA,Z05_HORA DESC
				)STATUS_PV
				OUTER APPLY(
					SELECT 
						SUM(C6.C6_VALOR) C6_VALOR
					FROM 
						[LABOR-PROD12]..SC6040 C6
					WHERE 
						C6.C6_FILIAL = C5.C5_FILIAL AND 
						C6.C6_NUM = C5.C5_NUM AND 
						C6.C6_BLQ = '' AND 
						C6.D_E_L_E_T_ = ''
					GROUP BY C6.C6_FILIAL, C6.C6_NUM 
				)TOTAL_PEDIDO 
				OUTER APPLY(
					SELECT 
						SUM(UB.UB_VLRITEM) UB_VLRITEM
					FROM 
						[LABOR-PROD12]..SUB040 UB
					WHERE 
						UB.UB_FILIAL = UA.UA_FILIAL AND 
						UB.UB_NUM = UA.UA_NUM AND 
						UB.D_E_L_E_T_ = ''
					GROUP BY UB.UB_FILIAL, UB.UB_NUM 
				)TOTAL_ORC
			WHERE 
				UA.UA_CLIENTE = A1.A1_COD AND 
				UA.UA_LOJA = A1.A1_LOJA AND 
   				UA.UA_EMISSAO BETWEEN @DTA_DE AND @DTA_ATE AND
				UA.D_E_L_E_T_ = '' 
		 )ORCAMENTOS 
		 WHERE	rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	ELSE IF @IDVENDEDOR > 0

		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			orcamento, 
			dataEmissao,
			idCliente,
			razaoCliente, 
			tipoRegistro,
			idVendedor,
			nomeVendedor,
			idTabela,
			tipoFrete,
			valorFrete,
			idCondicao,
			obsFinanceira,
			obsPedido,
			obsEntrega,
			obsComercial,
			pedidoERP,
			nota,
			serie,
			chaveNfe,
			subTotal,
			total,
			status	
		 FROM 
		 ( 
			SELECT 
				ROW_NUMBER() OVER(ORDER BY UA_EMISSAO DESC) rNum, 
				RTRIM(UA.UA_FILIAL) codigoFilial, 
				RTRIM(UA.UA_NUM) orcamento, 
				convert(varchar,convert(date,UA.UA_EMISSAO,101),121) dataEmissao, 
				A1.R_E_C_N_O_ idCliente,
				RTRIM(A1.A1_NOME) razaoCliente, 
				'cliente' tipoRegistro,
				A3.R_E_C_N_O_ idVendedor,
				A3.A3_NOME nomeVendedor,
				DA0.R_E_C_N_O_ idTabela,
				RTRIM(UA.UA_XTPFRET) tipoFrete,
				CASE 
					WHEN F2.F2_DOC <> '' THEN 
						F2.F2_FRETE 
					WHEN C5.C5_NUM <> '' THEN 
						C5.C5_FRETE
					ELSE 
						UA.UA_FRETE 
				END valorFrete,
				RTRIM(E4.R_E_C_N_O_) idCondicao,
				COALESCE(RTRIM(UA.UA_XOBSFIN),'') obsFinanceira,
				COALESCE(RTRIM(UA.UA_XOBSLO),'') obsPedido,
				COALESCE(RTRIM(UA.UA_XOBSEXP),'') obsEntrega,
				COALESCE(RTRIM(UA.UA_XOBSCO),'') obsComercial,
				COALESCE(RTRIM(C5.C5_NUM),'') pedidoERP,
				COALESCE(RTRIM(F2.F2_DOC),'') nota,
				COALESCE(RTRIM(F2.F2_SERIE),'') serie,
				COALESCE(RTRIM(F2.F2_CHVNFE),'') chaveNfe,
				CASE 
					WHEN F2.F2_DOC <> '' THEN 
						F2.F2_VALMERC 
					WHEN C5.C5_NUM <> '' THEN 
						TOTAL_PEDIDO.C6_VALOR 
					ELSE 
						TOTAL_ORC.UB_VLRITEM
				END	subTotal,
				CASE 
					WHEN F2.F2_DOC <> '' THEN 
						F2.F2_VALFAT 
					WHEN C5.C5_NUM <> '' THEN 
						TOTAL_PEDIDO.C6_VALOR + C5.C5_FRETE 
					ELSE 
						TOTAL_ORC.UB_VLRITEM + UA.UA_FRETE
				END total,
				CASE 
					WHEN STATUS_PV.Z04_DESC <> '' THEN 
						COALESCE(RTRIM(STATUS_PV.Z05_STATUS),'') 
					WHEN UA.UA_CANC <> '' THEN 
						'' 
					ELSE 
						'' 
				END status
			FROM 
				[LABOR-PROD12]..SUA040 UA WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '    ' AND A1.A1_COD = UA.UA_CLIENTE AND A1.A1_LOJA = UA.UA_LOJA AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..DA0040 DA0 WITH(NOLOCK) ON DA0.DA0_FILIAL = UA.UA_FILIAL AND DA0.DA0_CODTAB = A1.A1_TABELA AND DA0.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SA3040 A3 WITH(NOLOCK) ON A3.A3_FILIAL = '    ' AND A3.R_E_C_N_O_ = @IDVENDEDOR AND A3.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SE4040 E4 WITH(NOLOCK) ON E4.E4_FILIAL = '    ' AND E4.E4_CODIGO = UA.UA_CONDPG AND E4.D_E_L_E_T_ = '' 
				LEFT JOIN [LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) ON C5.C5_FILIAL = UA.UA_FILIAL AND C5.C5_NUM = UA.UA_NUMSC5 AND C5.C5_CLIENTE = UA.UA_CLIENTE AND C5.C5_LOJACLI = UA.UA_LOJA AND C5.D_E_L_E_T_ = ''
				LEFT JOIN [LABOR-PROD12]..SF2040 F2 WITH(NOLOCK) ON F2.F2_FILIAL = C5.C5_FILIAL AND F2.F2_DOC = C5.C5_NOTA AND F2.F2_SERIE = C5.C5_SERIE AND F2.D_E_L_E_T_ = ''
				OUTER APPLY(
					SELECT 
						TOP 1 
						Z05.Z05_STATUS,
						Z04.Z04_DESC,
						Z05.Z05_DATA,
						Z05.Z05_HORA
					FROM 
						[LABOR-PROD12]..Z05040 Z05 WITH(NOLOCK) 
						INNER JOIN [LABOR-PROD12]..Z04040 Z04 WITH(NOLOCK) ON Z04.Z04_FILIAL = '' AND Z04.Z04_COD = Z05.Z05_STATUS AND Z04.D_E_L_E_T_ = ''
					WHERE 
						Z05.Z05_FILIAL = C5.C5_FILIAL AND 
						Z05.Z05_PEDIDO = C5.C5_NUM AND 
						Z05.D_E_L_E_T_ = ''
					ORDER BY Z05_DATA,Z05_HORA DESC
				)STATUS_PV
				OUTER APPLY(
					SELECT 
						SUM(C6.C6_VALOR) C6_VALOR
					FROM 
						[LABOR-PROD12]..SC6040 C6
					WHERE 
						C6.C6_FILIAL = C5.C5_FILIAL AND 
						C6.C6_NUM = C5.C5_NUM AND 
						C6.C6_BLQ = '' AND 
						C6.D_E_L_E_T_ = ''
					GROUP BY C6.C6_FILIAL, C6.C6_NUM 
				)TOTAL_PEDIDO 
				OUTER APPLY(
					SELECT 
						SUM(UB.UB_VLRITEM) UB_VLRITEM
					FROM 
						[LABOR-PROD12]..SUB040 UB
					WHERE 
						UB.UB_FILIAL = UA.UA_FILIAL AND 
						UB.UB_NUM = UA.UA_NUM AND 
						UB.D_E_L_E_T_ = ''
					GROUP BY UB.UB_FILIAL, UB.UB_NUM 
				)TOTAL_ORC
			WHERE 
				UA.UA_VEND = A3.A3_COD AND 
   				UA.UA_EMISSAO BETWEEN @DTA_DE AND @DTA_ATE AND
				UA.D_E_L_E_T_ = '' 
		 )ORCAMENTOS 
		 WHERE	rNum > @IDPAGESIZE * (@IDPAGE - 1) 
	end
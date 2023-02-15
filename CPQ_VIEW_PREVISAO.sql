USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_previsao]    Script Date: 31/01/2023 19:10:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[cpq_previsao] as 

SELECT 
	productId
	,codigoErp
	,filial 
	,processo 
	,dataPrevista 
	,quantidade  
FROM 
 ( 
	SELECT 	
		B1.R_E_C_N_O_ AS productId
		,RTRIM(W7.W7_COD_I) AS codigoErp 
		,CASE W7.W7_FILIAL	WHEN '0401' THEN 'SP-Matriz' WHEN '0404' THEN 'SC-Navegantes' ELSE  W7.W7_FILIAL END filial
		,RTRIM(W6.W6_PO_NUM)  processo
		,convert(varchar,convert(date,W6.W6_PRVENTR,113),121) dataPrevista
		,W7.W7_QTDE  quantidade 
	FROM 
		[LABOR-1233]..SW6040 W6 (NOLOCK) 
		INNER JOIN [LABOR-1233]..SW7040 W7 (NOLOCK) ON W7.W7_FILIAL = W6.W6_FILIAL AND W7.W7_HAWB = W6.W6_HAWB AND W7.D_E_L_E_T_ = '' 
		INNER JOIN [LABOR-1233]..SB1040 B1 (NOLOCK) ON B1.B1_FILIAL = '    ' AND B1.B1_COD = W7.W7_COD_I AND B1.D_E_L_E_T_ = ''
	WHERE 	
		W6.W6_PRVENTR > convert(varchar,GETDATE(),112) AND 
		W6.W6_DT_ENCE = '' AND 
		W6.W6_NF_ENT = '' AND 
		W6.D_E_L_E_T_ = '' 
	UNION ALL 
	SELECT 
		B1.R_E_C_N_O_ AS productId
		,RTRIM(W3.W3_COD_I) codigoErp
		,CASE  
			W3.W3_FILIAL 	WHEN '0401' THEN 'SP-Matriz' 
					  		WHEN '0404' THEN 'SC-Navegantes' 
			ELSE  W3.W3_FILIAL 
		END filial
		,RTRIM(W5.W5_PO_NUM) processo 
		,convert(varchar,convert(date,W3.W3_DT_ENTR,113),121) dataPrevista
		,W5.W5_SALDO_Q quantidade  
	FROM 
		[LABOR-1233]..SW3040 W3 WITH(NOLOCK) 
		INNER JOIN [LABOR-1233]..SW5040 W5 WITH(NOLOCK) ON	W5.W5_FILIAL = W3.W3_FILIAL AND W5.W5_COD_I = W3.W3_COD_I AND 
												W5.W5_PO_NUM = W3.W3_PO_NUM AND W5.W5_POSICAO = W3.W3_POSICAO AND 
												W5.W5_SEQ = 0 AND W5.W5_SALDO_Q > 0 AND W5.D_E_L_E_T_ = '' 
		INNER JOIN [LABOR-1233]..SB1040 B1 (NOLOCK) ON B1.B1_FILIAL = '    ' AND B1.B1_COD = W3.W3_COD_I AND B1.D_E_L_E_T_ = ''
	WHERE 
		W3.W3_DT_ENTR > convert(varchar,GETDATE(),112) AND 
		W3.W3_SEQ = 1 AND 
		W3.D_E_L_E_T_ = '' 
	UNION ALL 
	SELECT 
		B1.R_E_C_N_O_ AS productId
		,RTRIM(C7.C7_PRODUTO) codigoErp
		,CASE 
			C7.C7_FILIAL	WHEN '0401' THEN 'SP-Matriz' 
							WHEN '0404' THEN 'SC-Navegantes' 
							ELSE  C7.C7_FILIAL 
		END filial 
		,RTRIM(C7.C7_NUM)  processo 
		,convert(varchar,convert(date,C7.C7_DATPRF,113),121) dataPrevista 
		,C7.C7_QUANT  quantidade 
	FROM 
		[LABOR-1233]..SC7040 C7 
		INNER JOIN [LABOR-1233]..SB1040 B1 (NOLOCK) ON B1.B1_FILIAL = '    ' AND B1.B1_COD = C7.C7_PRODUTO AND B1.D_E_L_E_T_ = ''
	WHERE 
		NOT EXISTS( 
				SELECT 
					D1.D1_PEDIDO 
				FROM 
					[LABOR-1233]..SD1040 D1  
				WHERE 
					D1.D1_FILIAL = C7.C7_FILIAL AND 
					D1.D1_PEDIDO = C7.C7_NUM AND 
					D1.D_E_L_E_T_ = '' 
		) AND 
		C7.C7_NUMIMP = '' AND 
		C7.C7_DATPRF > convert(varchar,GETDATE(),112) AND 
		( C7.C7_QUANT - C7.C7_QUJE) > 0 AND 
		C7.D_E_L_E_T_ = '' 
) PREVISAO 
 
GO



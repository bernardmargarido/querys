USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_caixas]    Script Date: 22/07/2022 12:03:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[cpq_caixas] as 

SELECT 
	XTA.R_E_C_N_O_ caixaId
	,RTRIM(XTA.XTA_FILIAL) codigoFilial
	,RTRIM(XTA.XTA_CODIGO) codigoErp
	,RTRIM(XTA.XTA_DESC) descricao
	,CASE 
		WHEN XTA.XTA_TIPO   = '1' THEN 
			'Caixa'
		WHEN XTA.XTA_TIPO   = '2' THEN 
			'Envelope' 
	END tipoEmbalagem
	,CASE 
		WHEN XTA_TPMAT = '1' THEN 
			'Papelao'
		WHEN XTA_TPMAT = '1' THEN 
			'Isopor'
		WHEN XTA_TPMAT = '1' THEN 
			'Plastico'
		WHEN XTA_TPMAT = '1' THEN 
			'Madeira'
		WHEN XTA_TPMAT = '1' THEN 
			'Metalica'
	END tipoMaterial
	,XTA.XTA_ALTURA altura
	,XTA.XTA_LARG largura
	,XTA.XTA_COMPR comprimento
	,XTA.XTA_TOTAL totalM3
FROM 
	[LABOR-PROD12]..XTA040 XTA
WHERE 
	XTA_FILIAL = '' 
	AND XTA_MSEXP = ''
	AND D_E_L_E_T_ = ''

GO



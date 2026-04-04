USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_kits]    Script Date: 09/11/2023 19:44:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[cpq_kits] as 
SELECT
	cast(XTR.R_E_C_N_O_ as int) AS kitId
	,rtrim(XTR.XTR_FILIAL) codigoFilial
	,rtrim(XTR.XTR_CODIGO) codigoErp
	,rtrim(XTR.XTR_DESC) descricao
	,case when XTR.XTR_STATUS = '1' then 'Ativo' else 'Inativo' end statusKit
FROM 
	[LABOR-PROD12]..XTR040 XTR (NOLOCK)
WHERE
	--XTR.XTR_MSEXP = '' AND
	XTR.D_E_L_E_T_ = ' '
GO



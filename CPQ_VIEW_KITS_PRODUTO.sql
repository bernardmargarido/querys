USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_produtos]    Script Date: 22/08/2023 15:12:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter view [dbo].[cpq_kits] as 
SELECT
	cast(XTQ.R_E_C_N_O_ as int) AS kitId
	,rtrim(XTQ.XTQ_FILIAL) codigoFilial
	,rtrim(XTQ.XTQ_CODIGO) codigoErp
	,rtrim(XTQ.XTQ_DESC) descricao
	,case when XTQ.XTQ_STATUS = '1' then 'Ativo' else 'Inativo' end statusKit
FROM 
	[LABOR12-33]..XTQ040 XTQ (NOLOCK)
WHERE
	--XTQ.XTQ_MSEXP = '' AND
	XTQ.D_E_L_E_T_ = ' '
GO

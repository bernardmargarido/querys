USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_condicao]    Script Date: 10/02/2023 15:09:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER view [dbo].[cpq_condicao] as 

SELECT 
	E4.R_E_C_N_O_ condicaoId
	,RTRIM(E4.E4_FILIAL) codigoFilial
	,RTRIM(E4.E4_CODIGO) codigoErp
	,RTRIM(E4.E4_COND) condicaoPgto
	,RTRIM(E4.E4_DESCRI) descricao
	,RTRIM(E4.E4_INFER) inferior
	,RTRIM(E4.E4_SUPER) superior
	,CASE WHEN E4.E4_MSBLQL = '1' THEN 'S' ELSE 'N' END AS bloqueado
FROM 
	[LABOR-1233]..SE4040 E4 
WHERE 
	E4.E4_XTGV = '1' AND
	E4.E4_MSEXP = '' AND
	E4.E4_MSBLQL <> '1' AND 
	E4.D_E_L_E_T_ = ''

GO



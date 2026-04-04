USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_caixas]    Script Date: 11/07/2023 17:29:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[cpq_filiais] as 

SELECT 
	RTRIM(M0.M0_CODIGO) codigoEmpresa,
	RTRIM(M0.M0_CODFIL) codigoFilial,
	RTRIM(M0.M0_CODFIL) + ' - ' + RTRIM(dbo.CAPITAL(M0.M0_FILIAL)) descricaoFilial
FROM 
	[LABOR12-33]..SYS_COMPANY M0
WHERE 
	M0.M0_LICENSA <> '' AND
	M0.D_E_L_E_T_ = ''

GO
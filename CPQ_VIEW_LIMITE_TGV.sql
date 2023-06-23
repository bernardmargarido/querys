USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_limitetgv]    Script Date: 21/06/2023 18:49:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER view [dbo].[cpq_limitetgv] as 

SELECT 
	X5.X5_FILIAL codigoFilial,
	X5.R_E_C_N_O_ limiteId,
	RTRIM(X5.X5_CHAVE) estado,
	CAST(X5.X5_DESCRI AS numeric) limite
FROM 
	[LABOR12-33]..SX5040 X5
WHERE 
	X5.X5_FILIAL = '0404'  
	AND X5.X5_TABELA = 'Z3' 
	AND X5.D_E_L_E_T_ = ''

GO



USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_orcamento_items]    Script Date: 22/08/2023 15:39:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[cpq_kits_items]
	-- Add the parameters for the stored procedure here
@FILIAL varchar(4),
@CODIGO varchar(6)

AS
BEGIN

SELECT 
	cast(XTR.R_E_C_N_O_ as int) itemKitId
	,rtrim(XTR.XTR_ITEM) itemKit 
	,rtrim(XTR.XTR_PROD) produto
	,rtrim(XTR.XTR_DESC) descricao
FROM 
	[LABOR12-33]..XTR040 XTR 
WHERE 
	XTR.XTR_FILIAL = @FILIAL AND 
	XTR.XTR_CODIGO = @CODIGO AND 
	XTR.D_E_L_E_T_ = ''
ORDER BY XTR.XTR_FILIAL,XTR.XTR_CODIGO,XTR.XTR_ITEM

END

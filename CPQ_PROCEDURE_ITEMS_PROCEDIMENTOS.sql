USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_kits_items]    Script Date: 09/11/2023 19:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cpq_kits_items]
	-- Add the parameters for the stored procedure here
@FILIAL varchar(4),
@CODIGO varchar(6)

AS
BEGIN

SELECT 
	cast(XTS.R_E_C_N_O_ as int) itemKitId
	,rtrim(XTS.XTS_ITEM) itemKit 
	,rtrim(XTS.XTS_PROD) produto
	,rtrim(XTS.XTS_DESC) descricao
FROM 
	[LABOR-PROD12]..XTS040 XTS 
WHERE 
	XTS.XTS_FILIAL = @FILIAL AND 
	XTS.XTS_CODIGO = @CODIGO AND 
	XTS.D_E_L_E_T_ = ''
ORDER BY XTS.XTS_FILIAL,XTS.XTS_CODIGO,XTS.XTS_ITEM

END
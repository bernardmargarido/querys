USE [GATEWAY]
GO

/****** Object:  StoredProcedure [dbo].[cpq_orcamento_items]    Script Date: 28/11/2022 11:15:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[cpq_correlacionados]
	-- Add the parameters for the stored procedure here
@FILIAL varchar(4),
@PRODUTO varchar(30)

AS
BEGIN
	
	SELECT 
		B1.R_E_C_N_O_ AS productId
		,RTRIM(B1.B1_COD) AS codigoErp
		,RTRIM(B1.B1_DESC) AS descricao
		,CASE 
			WHEN ZXC.ZXC_STATUS = '1' THEN
				'A' 
			ELSE 
				'I' 
		END status
	FROM 
		[LABOR-PROD12]..ZXC040 ZXC
		INNER JOIN [LABOR-PROD12]..SB1040 B1 (NOLOCK) ON B1.B1_FILIAL = '' AND B1.B1_COD = ZXC.ZXC_CODPRD AND B1.D_E_L_E_T_ = ''
	WHERE 
		ZXC.ZXC_FILIAL = @FILIAL AND 
		ZXC.ZXC_PRODUT = @PRODUTO AND
		ZXC.D_E_L_E_T_ = '' 

END 
GO



CREATE view [dbo].[cpq_produtos_correlacionados] as 

	SELECT 
		B1.R_E_C_N_O_ AS productId
		,RTRIM(B1.B1_FILIAL) AS codigoFilial
		,RTRIM(B1.B1_COD) AS codigoErp
		,RTRIM(B1.B1_DESC) AS descricao
		,CASE 
			WHEN ZXB.ZXB_STATUS = '1' THEN
				'A' 
			ELSE 
				'I' 
		END status
	FROM 
		[LABOR-PROD12]..ZXB040 ZXB
		INNER JOIN [LABOR-PROD12]..SB1040 B1 (NOLOCK) ON B1.B1_FILIAL = '' AND B1.B1_COD = ZXB.ZXB_PRODUT AND B1.D_E_L_E_T_ = ''
	WHERE 
		ZXB.ZXB_FILIAL = '' AND 
		ZXB.D_E_L_E_T_ = '' 

GO
USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_status_pedido]    Script Date: 31/03/2023 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[cpq_status_pedido]
	-- Add the parameters for the stored procedure here
@NUMPV varchar(10)

AS
BEGIN

DECLARE @DELETE varchar(1) = ' ';
SET @DELETE = ( SELECT D_E_L_E_T_ FROM [LABOR-PROD12]..SC5040 (NOLOCK) WHERE C5_FILIAL = '0404' AND C5_NUM = @NUMPV)

SELECT 
	RTRIM(Z05.Z05_PEDIDO) pedidoErp,
	COALESCE(RTRIM(NOTA_PEDIDO.F2_DOC),'') nota,
	COALESCE(RTRIM(NOTA_PEDIDO.F2_SERIE),'') serie,
	COALESCE(RTRIM(NOTA_PEDIDO.F2_CHVNFE),'') chaveNFe,
	COALESCE(RTRIM(convert(varchar,convert(date,NOTA_PEDIDO.F2_EMISSAO,101),121)),'') dataEmissao,
	COALESCE(RTRIM(convert(varchar,convert(date,NOTA_PEDIDO.F2_DAUTNFE,101),121)),'') dataNFe,
	COALESCE(RTRIM(NOTA_PEDIDO.F2_HAUTNFE),'') horaNFe,
	RTRIM(Z05.Z05_STATUS) statusErp,
	RTRIM(Z04.Z04_DESC) descStatus, 
	convert(varchar,convert(date,Z05.Z05_DATA,101),121) dataStatus,
	RTRIM(Z05.Z05_HORA) horaStatus,
	CASE 
		WHEN NOTA_PEDIDO.F2_CHVNFE <> '' THEN 
			'https://activeonsupply.com.br/SITE/Rastreamento/Consulta?d=' + RTRIM(A1.A1_CGC) + '&c=' + RTRIM(NOTA_PEDIDO.F2_CHVNFE)
		ELSE 
			'' 
	END linkRastreio,
	COALESCE(ZXF.ZXF_URLCHK,'') linkPagamento,
	IIF(ZXF.ZXF_ADQUI = 'PagarMe',
		CASE 
			WHEN ZXF.ZXF_STAPAY = 'paid' THEN 'Pagamento Autorizado' 
			WHEN ZXF.ZXF_STAPAY = 'refused' THEN 'Recusado'
			WHEN ZXF.ZXF_STAPAY = 'created' AND ZXF.ZXF_STATPV = 'active' THEN 'Aguardando Pagamento'
			WHEN ZXF.ZXF_STAPAY = 'created' AND ZXF.ZXF_STATPV = 'expired' THEN	'Pagamento Cancelado'
			WHEN ZXF.ZXF_STAPAY = 'created' AND ZXF.ZXF_STATPV = 'expired' THEN	'Pagamento Cancelado'
			ELSE ''
		END 
	,
		CASE 
			WHEN RTRIM(ZXF.ZXF_STATPV) = 'PAID' THEN 'Pagamento Autorizado'
			WHEN RTRIM(ZXF.ZXF_STATPV) = 'NOT_PAID' THEN 'Pagamento Cancelado'
			WHEN RTRIM(ZXF.ZXF_STATPV) = 'CREATED' THEN 'Aguardando Pagamento'
			ELSE '' 
		END 
	) statusPgto
FROM 
	[LABOR-PROD12]..Z05040 Z05 (NOLOCK)
	INNER JOIN [LABOR-PROD12]..Z04040 Z04 (NOLOCK) ON Z04.Z04_FILIAL = '    ' AND Z04.Z04_COD = Z05.Z05_STATUS AND Z04.D_E_L_E_T_ = ''
	INNER JOIN [LABOR-PROD12]..SC5040 C5 (NOLOCK) ON C5.C5_FILIAL = Z05.Z05_FILIAL AND C5.C5_NUM = Z05.Z05_PEDIDO AND C5.D_E_L_E_T_ = @DELETE
	INNER JOIN [LABOR-PROD12]..SA1040 A1 (NOLOCK) ON A1.A1_FILIAL = '' AND A1.A1_COD = C5.C5_CLIENTE AND A1.A1_LOJA = C5.C5_LOJACLI AND A1.D_E_L_E_T_ = ''
	LEFT JOIN [LABOR-PROD12]..ZXF040 ZXF (NOLOCK) ON ZXF.ZXF_FILIAL = Z05.Z05_FILIAL AND ZXF.ZXF_NUMPV = Z05.Z05_PEDIDO AND ZXF.D_E_L_E_T_ = ''
	OUTER APPLY(
		SELECT 
			F2.F2_DOC,
			F2.F2_SERIE,
			F2.F2_CHVNFE,
			F2.F2_DAUTNFE,
			F2.F2_HAUTNFE,
			F2.F2_EMISSAO
		FROM 
			[LABOR-PROD12]..SF2040 F2 
		WHERE 
			F2.F2_FILIAL = C5.C5_FILIAL AND 
			F2.F2_DOC = C5.C5_NOTA AND 
			F2.F2_SERIE = C5.C5_SERIE AND 
			F2.D_E_L_E_T_ = ''
	)NOTA_PEDIDO
WHERE 
	Z05.Z05_FILIAL = '0404' AND 
	Z05.Z05_PEDIDO = @NUMPV AND
	Z05.Z05_MSEXP = '' AND
	Z05.D_E_L_E_T_ = ''
ORDER BY Z05.Z05_DATA,Z05.Z05_HORA, Z05.Z05_STATUS

end
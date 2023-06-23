USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_linkpgto]    Script Date: 21/06/2023 18:50:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER view [dbo].[cpq_linkpgto] as 

SELECT
	C5.C5_FILIAL codigoFilial,
	RTRIM(C5.C5_NUM) codigoPedido,
	A1.R_E_C_N_O_ clienteId,
	RTRIM(A1.A1_NOME) nomeCliente,
	RTRIM(ZXF.ZXF_URLCHK) linkPagamento,
	IIF( ZXF.ZXF_ADQUI = 'PagarMe',
		CASE 
			WHEN ZXF.ZXF_STATPV = 'active' AND ZXF.ZXF_STAPAY = 'created' THEN	'Aguardando Pagamento'
			WHEN ZXF.ZXF_STATPV = 'expired' AND ZXF.ZXF_STAPAY = 'refused' THEN 'Link Espirado'
			WHEN ZXF.ZXF_STATPV = 'active'  AND ZXF.ZXF_STAPAY = 'paid' THEN	'Pagamento Confirmado'
			WHEN ZXF.ZXF_STATPV = 'cancelad' THEN 'Pagamento Cancelado'
			ELSE ''
		END
	,
		CASE 
			WHEN RTRIM(ZXF.ZXF_STATPV) = 'PAID' THEN 'Pagamento Confirmado'
			WHEN RTRIM(ZXF.ZXF_STATPV) = 'NOT_PAID' THEN 'Pagamento Cancelado'
			WHEN RTRIM(ZXF.ZXF_STATPV) = 'CREATED' THEN 'Aguardando Pagamento'
			ELSE '' 
		END 
	)statusPagamento,
	IIF( ZXF.ZXF_ADQUI = '','Moip',ZXF.ZXF_ADQUI) adiquirente
	
FROM
	[LABOR12-33]..ZXF040 ZXF (NOLOCK)
	INNER JOIN [LABOR12-33]..SC5040 C5 (NOLOCK) ON C5.C5_FILIAL = ZXF.ZXF_FILIAL AND C5.C5_NUM = ZXF.ZXF_NUMPV AND C5.D_E_L_E_T_ = '' 
	INNER JOIN [LABOR12-33]..SA1040 A1 (NOLOCK) ON A1.A1_FILIAL = '' AND A1.A1_COD = C5.C5_CLIENTE AND A1.A1_LOJA = C5.C5_LOJACLI AND A1.D_E_L_E_T_ = ''
WHERE 
	ZXF.ZXF_FILIAL = '0404' AND 
	ZXF.D_E_L_E_T_ = ''

GO



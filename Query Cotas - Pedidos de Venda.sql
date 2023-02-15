-- Pedidos de Venda
SELECT 
	TIPO,PEDIDO,CLIENTE,SUM(QTDVEND) QTDVEND,SEMANA,DTENTREGA
FROM
	(
		SELECT 
			'OR' TIPO, SCK.CK_NUM PEDIDO,
			SA1.A1_NREDUZ CLIENTE,SCK.CK_QTDVEN QTDVEND,
			'' SEMANA,SCK.CK_ENTREG DTENTREGA
		FROM
			SCK010 SCK
			INNER JOIN SCJ010 SCJ ON SCJ.CJ_FILIAL = SCK.CK_FILIAL AND  
			SCJ.CJ_NUM = SCK.CK_NUM AND SCJ.CJ_XCOLECA = 'S13' AND SCJ.D_E_L_E_T_ = ''
			INNER JOIN SA1010 SA1 ON SA1.A1_COD = SCJ.CJ_CLIENTE AND SA1.A1_LOJA = SCJ.CJ_LOJA AND SA1.D_E_L_E_T_ = ''
		WHERE
			SCK.CK_FILIAL = '05' AND 
			SCK.CK_NUMPV = ' ' AND 
			LEFT(SCK.CK_PRODUTO,23) = 'D110N.1123             ' AND 
			SCK.D_E_L_E_T_ = ''
		
		UNION ALL
		
		SELECT 
			'PV' TIPO, SC6.C6_NUM PEDIDO,
			SA1.A1_NREDUZ CLIENTE,SC6.C6_QTDVEN QTDVEND,
			'' SEMANA,SC6.C6_ENTREG DTENTREGA
		FROM
			SC6010 SC6
			INNER JOIN SC5010 SC5 ON SC5.C5_FILIAL = SC6.C6_FILIAL AND 
			SC5.C5_NUM = SC6.C6_NUM AND SC5.C5_XCOLECA = 'S13' AND SC5.D_E_L_E_T_ = ''
			INNER JOIN SA1010 SA1 ON SA1.A1_COD = SC5.C5_CLIENTE AND SA1.A1_LOJA = SC5.C5_LOJACLI AND SA1.D_E_L_E_T_ = ''
		WHERE
			SC6.C6_FILIAL = '05' AND 
			LEFT(SC6.C6_PRODUTO,23) =  'D110N.1123             ' AND 
			SC6.D_E_L_E_T_ = ''				
			 
			 	
	)PEDIDO
	GROUP BY 
	TIPO,PEDIDO,CLIENTE,SEMANA,DTENTREGA
	ORDER BY DTENTREGA
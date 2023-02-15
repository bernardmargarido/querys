SELECT  
	C5.C5_NUM, 
	C5.C5_NOTA, 
	C5.C5_SERIE 
 FROM 
	SC5040 C5 
 WHERE 
	C5.C5_FILIAL = '0404' AND  
	C5.C5_XPVORIG IN( 
						SELECT 
							D2.D2_PEDIDO  
						FROM 
							SD2040 D2 
						WHERE 
							D2.D2_FILIAL = '0401' AND  
							D2.D2_DOC = '' AND 
							D2.D2_SERIE = '" + SF2->F2_SERIE + "' AND 
							D2.D2_CLIENTE = '" + SF2->F2_CLIENTE + "' AND 
							D2.D2_LOJA = '" + SF2->F2_LOJA + "' AND 
							D2.D_E_L_E_T_ = '' 
					) AND 
	( C5.C5_NOTA <> '' AND C5.C5_NOTA <> 'XXXXXXXXX' ) AND  
	( C5.C5_SERIE <> '' AND C5.C5_SERIE <> 'XXXXXXXXX' ) AND 
	C5.D_E_L_E_T_ = '' 
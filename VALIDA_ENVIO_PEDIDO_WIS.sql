SELECT  
	FILIAL,  
	PEDIDO,     
	CLIENTE,     
	LOJA,    
	NOME,   
	EMISSAO,  
	QTDLIB,    
	QTDPED,   
	RECNO   
 FROM   
 (   
		SELECT   
			C5.C5_FILIAL FILIAL,  
			C5.C5_NUM PEDIDO,   
			C5.C5_CLIENT CLIENTE,   
			C5.C5_LOJACLI LOJA,   
			A1.A1_NOME NOME,   
            C5.C5_EMISSAO EMISSAO,   
            C5.R_E_C_N_O_ RECNO,   
			LIBERADO.C9_QTDLIB QTDLIB,   
			PEDIDO.C6_QTDVEN QTDPED   
		FROM  
			SC5040 C5   
			INNER JOIN SA1040 A1 ON A1.A1_FILIAL = '    ' AND A1.A1_COD = C5.C5_CLIENT AND A1.A1_LOJA = C5.C5_LOJACLI AND A1.D_E_L_E_T_ = ''  
		    CROSS APPLY (   
						SELECT   
							SUM(C6.C6_QTDVEN) C6_QTDVEN   
						FROM   
							SC6040 C6  
                            INNER JOIN SB2040 B2  ON B2.B2_FILIAL = C6.C6_FILIAL AND B2.B2_COD = C6.C6_PRODUTO AND B2.B2_LOCAL = C6.C6_LOCAL AND B2.D_E_L_E_T_ = '' 
						WHERE   
							C6.C6_FILIAL = C5.C5_FILIAL AND   
							C6.C6_NUM = C5.C5_NUM AND   
							C6.C6_NOTA = '' AND   
							C6.C6_SERIE = '' AND   
							C6.C6_LOCAL = '01' AND   
							C6.D_E_L_E_T_ = ''   
			) PEDIDO   
			CROSS APPLY (   
						SELECT   
							SUM(C9.C9_QTDLIB) C9_QTDLIB   
						FROM   
							SC9040 C9   
                            INNER JOIN SB2040 B2 ON B2.B2_FILIAL = C9.C9_FILIAL AND B2.B2_COD = C9.C9_PRODUTO AND B2.B2_LOCAL = C9.C9_LOCAL AND B2.D_E_L_E_T_ = ''  
						WHERE   
							C9.C9_FILIAL = C5.C5_FILIAL AND   
							C9.C9_PEDIDO = C5.C5_NUM AND   
							C9.C9_NFISCAL = '' AND   
							C9.C9_SERIENF = '' AND   
							C9.C9_BLEST <> '' AND   
							C9.C9_BLCRED = '  ' AND   
                            ( B2.B2_QATU - B2.B2_RESERVA ) >= C9.C9_QTDLIB AND   
							C9.C9_LOCAL = '01' AND   
							C9.D_E_L_E_T_ = ''   
			) LIBERADO   
		WHERE   
			C5.C5_FILIAL = '0404' AND   
			C5.C5_XENVWMS = '1' AND   
			C5.C5_NOTA = '' AND   
			C5.C5_SERIE = '' AND   
			C5.C5_LIBEROK = 'S' AND   
			C5.C5_XPVORIG = '' AND   
			C5.D_E_L_E_T_ = ''   
 )PEDIDOS   
 WHERE   
		QTDLIB = QTDPED   
ORDER BY PEDIDO 
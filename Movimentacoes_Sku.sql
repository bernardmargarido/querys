			SELECT 	'SD1' ARQ, 	
					 SB1.B1_COD PRODUTO,
					 SB1.B1_TIPO TIPO,
					 SB1.B1_UM UM, 
					 SB1.B1_GRUPO GRUPO,
					 SB1.B1_DESC DESCPRD, 
					 D1_DTDIGIT DTDIGIT,
					 D1_TES TES,
					 D1_CF CF,
					 D1_NUMSEQ SEQUENCIA,
					 D1_DOC DOCUMENTO,
					 D1_SERIE SERIE,
					 D1_QUANT QUANTIDADE,
					 D1_QTSEGUM QUANT2UM,
					 D1_LOCAL ARMAZEM,
					 D1_FILIAL FILIAL,
					 D1_FORNECE FORNECEDOR,
					 D1_LOJA LOJA,
					 D1_TIPO TIPONF,
					 SD1.R_E_C_N_O_ NRECNO,
                     0 QTDATU,
                     0 VATU1,
                     0 QFIM1,
                     0 VFIM1,
                     0 CM1, 
                     0 QNPT,
                     0 QTNP 
		
			FROM SB1030 SB1, 
           SD1030 SD1, 
           SF4030 SF4
		
			WHERE 
        SB1.B1_COD     =  SD1.D1_COD		AND  	SD1.D1_FILIAL  IN ('02','03','05')	AND
				 SF4.F4_FILIAL  =  ' '  			AND 	SD1.D1_TES     =  SF4.F4_CODIGO		AND
				 SF4.F4_ESTOQUE =  'S'				AND 	SD1.D1_DTDIGIT >= '20151001'   		AND
				  SD1.D1_DTDIGIT <= '20151031'		AND		SD1.D1_ORIGLAN <> 'LF'				AND
				  SD1.D1_LOCAL   >= '01'			AND		SD1.D1_LOCAL   <= '04'				AND
				  SD1.D_E_L_E_T_ <> '*'				AND 	SF4.D_E_L_E_T_ <> '*'               AND
		          SB1.B1_COD     >= 'PET-96746'	AND		SB1.B1_COD     <= 'PET-96746' 		AND
				  SB1.B1_FILIAL  =  ' '				AND		SB1.B1_TIPO    >= '  '				AND
				  SB1.B1_TIPO    <= 'ZZ'			AND		SB1.D_E_L_E_T_ <> '*'							   		  
				  			
		    UNION
		    
			SELECT 'SD2' ARQ,	
					SB1.B1_COD PRODUTO,
					SB1.B1_TIPO TIPO ,
					SB1.B1_UM UM,	
					SB1.B1_GRUPO GRUPO ,
					SB1.B1_DESC DESCPRD,
					D2_EMISSAO DTDIGIT,	
					D2_TES TES,		
					D2_CF CF,		
					D2_NUMSEQ SEQUENCIA,	
					D2_DOC DOCUMENTO,		
					D2_SERIE SERIE,	
					D2_QUANT QUANTIDADE,	
					D2_QTSEGUM QUANT2UM,	
					D2_LOCAL ARMAZEM,	
					D2_FILIAL FILIAL ,	
					D2_CLIENTE FORNECEDOR,	
					D2_LOJA LOJA,	
					D2_TIPO TIPONF,	
					SD2.R_E_C_N_O_ RECNO,
                    0 QTDATU,
                    0 VATU1,
                    0 QFIM1,
                    0 VFIM1,
                    0 CM1, 
                    0 QNPT,
                    0 QTNP 
					
			FROM SB1030 SB1,SD2030 SD2,SF4030 SF4
				
			WHERE	SB1.B1_COD     =  SD2.D2_COD		AND	SD2.D2_FILIAL  IN ('02','03','05')	AND
					SF4.F4_FILIAL  = '  ' 				AND	SD2.D2_TES     =  SF4.F4_CODIGO		AND
					SF4.F4_ESTOQUE =  'S'				AND	SD2.D2_EMISSAO >= '20151001'		AND
					SD2.D2_EMISSAO <= '20151031'		AND	SD2.D2_ORIGLAN <> 'LF'				AND
					SD2.D2_LOCAL   >= '01'				AND	SD2.D2_LOCAL   <= '04'				AND
					SD2.D_E_L_E_T_ <> '*'				AND SF4.D_E_L_E_T_ <> '*'				AND
			        SB1.B1_COD     >= 'PET-96746'		AND	SB1.B1_COD  <= 'PET-96746'			AND
					SB1.B1_FILIAL  =  '  '	    		AND	SB1.B1_TIPO >= '  '					AND
					SB1.B1_TIPO    <= 'ZZ'				AND	SB1.D_E_L_E_T_ <> '*'						   		  
				
			UNION		
		
			SELECT 	'SD3' ARQ ,	  
					SB1.B1_COD PRODUTO,
					SB1.B1_TIPO TIPO ,
					SB1.B1_UM UM ,	
					SB1.B1_GRUPO GRUPO,
					SB1.B1_DESC DESCPRD,
					D3_EMISSAO DTDIGIT,
					D3_TM TES,
					D3_CF CF,	
					D3_NUMSEQ SEQUENCIA,
					D3_DOC DOCUMENTO,
					' ' SERIE,	
					D3_QUANT QUANTIDADE,	
					D3_QTSEGUM QUANT2UM ,
					D3_LOCAL ARMAZEM,
					D3_FILIAL FILIAL ,
					' ' FORNECEDOR,
					' ' LOJA,
					' ' TIPONF,
					SD3.R_E_C_N_O_ SD3RECNO,
                    0 QTDATU,
                    0 VATU1,
                    0 QFIM1,
                    0 VFIM1,
                    0 CM1, 
                    0 QNPT,
                    0 QTNP 
		
			FROM SB1030 SB1,SD3030 SD3
			
			WHERE	SB1.B1_COD     =  SD3.D3_COD 		AND SD3.D3_FILIAL  IN ('02','03','05')	AND
					SD3.D3_EMISSAO >= '20151001'		AND	SD3.D3_EMISSAO <= '20151031'	AND
					SD3.D3_LOCAL   >= '01'				AND	SD3.D3_LOCAL   <= '04'			AND
					SD3.D_E_L_E_T_ <> '*'				                                   	AND
			        SB1.B1_COD     >= 'PET-96746'		AND		SB1.B1_COD  <= 'PET-96746'	AND
					SB1.B1_FILIAL  =  '  '	    		AND		SB1.B1_TIPO >= '  '			AND
					SB1.B1_TIPO    <= 'ZZ'				AND		SB1.D_E_L_E_T_ <> '*'
					
			UNION
			
			SELECT 	'SB1' ARQ,
					SB1.B1_COD PRODUTO,
					SB1.B1_TIPO TIPO ,
					SB1.B1_UM UM,
					SB1.B1_GRUPO GRUPO,
					SB1.B1_DESC DESCPRD,
					' ' DTDIGIT,
					' ' TES,
					' ' CF,
					' ' SEQUENCIA,
					' ' DOCUMENTO,
					' ' SERIE,
					0 QUANTIDADE,
					0 QUANT2UM,
					SB2.B2_LOCAL ARMAZEM,
					SB2.B2_FILIAL FILIAL,	
					' ' FORNECEDOR,
					' ' LOJA,
					' ' TIPONF,
					0 SD3RECNO,
					B2_QATU QTDATU,
                    B2_VATU1 VATU1,
                    B2_QFIM QFIM1,
                    B2_VFIM1 VFIM1,
                    B2_CM1 CM1, 
                    B2_QNPT QNPT,
                    B2_QTNP QTNP         
		
			FROM SB1030 SB1, SB2030 SB2
			
			WHERE   SB1.B1_COD     >= 'PET-96746'		AND		SB1.B1_COD  <= 'PET-96746' 	AND
					SB1.B1_FILIAL  =  '  '	    		AND		SB1.B1_TIPO >= '  '				AND
					SB1.B1_TIPO    <= 'ZZ'				AND		SB1.D_E_L_E_T_ <> '*'  			AND
				    SB1.B1_COD = SB2.B2_COD 			AND
					SB2.B2_LOCAL >= '01' 				AND		SB2.B2_LOCAL <= '04'			AND   
    				SB2.B2_FILIAL IN ('02','03','05') AND
    				SB2.D_E_L_E_T_ = ''	   		  
			ORDER BY 16,3,2,1
      

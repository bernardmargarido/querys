SELECT 
  B9.B9_FILIAL,
  B9.B9_COD,
  B9.B9_LOCAL,
  B9.R_E_C_N_O_ RECNOB9
FROM 
  SB9030 B9
WHERE
  NOT EXISTS (
                SELECT 
                  D1.* 
                FROM 
                  SD1030 D1 
                WHERE
                  D1.D1_FILIAL = B9.B9_FILIAL AND 
                  D1.D1_COD = B9.B9_COD AND 
                  D1.D1_LOCAL = B9.B9_LOCAL AND 
                  D1.D_E_L_E_T_ <> '*' 
              ) AND 
  NOT EXISTS (
                SELECT 
                  D2.* 
                FROM 
                  SD2030 D2 
                WHERE
                  D2.D2_FILIAL = B9.B9_FILIAL AND 
                  D2.D2_COD = B9.B9_COD AND 
                  D2.D2_LOCAL = B9.B9_LOCAL AND 
                  D2.D_E_L_E_T_ <> '*' 
              ) AND
      NOT EXISTS (
                SELECT 
                  D3.* 
                FROM 
                  SD3030 D3 
                WHERE
                  D3.D3_FILIAL = B9.B9_FILIAL AND 
                  D3.D3_COD = B9.B9_COD AND 
                  D3.D3_LOCAL = B9.B9_LOCAL AND 
                  D3.D_E_L_E_T_ <> '*' 
              )			  
              
  AND B9.D_E_L_E_T_ <> '*' 
  AND B9.B9_QINI = 0 
  AND B9.B9_VINI1 = 0            
  AND B9.B9_FILIAL IN('01','02')
  ORDER BY B9.B9_FILIAL,B9.B9_LOCAL,B9.B9_COD          
  
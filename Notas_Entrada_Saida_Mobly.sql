SELECT 
  A2.A2_COD,
  A2.A2_LOJA,
  A2.A2_CGC
FROM 
  SA2030 A2
WHERE 
  SUBSTR(A2.A2_CGC,1,8) IN ( 
                            SELECT 
                              SUBSTR(B2.A2_CGC,1,8) 
                            FROM 
                              SA2030 B2 
                            WHERE 
                              B2.D_E_L_E_T_ = ' ' 
                            GROUP BY SUBSTR(B2.A2_CGC,1,8) HAVING COUNT(B2.A2_CGC) > 1 
                          )
  AND A2.A2_CGC <> ' '
  AND A2.A2_MSBLQL IN (' ','2')
  AND A2.D_E_L_E_T_ =  ' '
ORDER BY A2.A2_CGC

SELECT 
	F2.F2_NUMECO,
	C5.C5_NUMECLI,
	F2.* 
FROM 
	SF2030 F2 
INNER JOIN SC5030 C5 ON C5.C5_NUMECO = F2.F2_NUMECO AND C5.D_E_L_E_T_ = ' '
WHERE 
	F2.F2_CHVNFE = '35150914055516000490550400000088601003995335' 
	AND F2.D_E_L_E_T_ = ' '
	
SELECT 
	F2_FILIAL,
	F2_SERIE,
	COUNT(F2_DOC) 
FROM
	SF2030 
WHERE 
	F2_EMISSAO = '20150922' AND 
	F2_SERIE = '040' AND 
	D_E_L_E_T_ = ' '
GROUP BY F2_FILIAL,F2_SERIE
ORDER BY F2_SERIE
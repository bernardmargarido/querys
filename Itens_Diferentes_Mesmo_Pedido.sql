SELECT C5.C5_NUMECO, ITENS, X.C5_NUMX CORRETO, C5.C5_NUM
FROM   (select C5_NUMECO, COUNT(DISTINCT C5_NUM) AS ITENS, MIN(DECODE(C5_FILIAL,'04',C5_NUM,'9999999')) AS C5_NUMX
        from   SC5030 C5
        WHERE  C5.D_E_L_E_T_ <> '*'
            AND C5_NUMECO <> ' '
			AND C5_NUMECLI <> ' '
			AND C5_ORCRES = ' '
			AND C5_01OST = ' ' 
			AND C5_FILIAL ='04' 
        GROUP BY C5_NUMECO
        HAVING COUNT(DISTINCT C5_NUM) > 1) X
       JOIN SC5030 C5  on x.C5_NUMECO = C5.C5_NUMECO
                            AND C5.D_E_L_E_T_ <> '*'
							AND C5.C5_FILIAL = '04' 
							AND C5_ORCRES = ' '
							AND C5_01OST = ' '
       JOIN SC6030 C6 ON C5.C5_NUM = C6.C6_NUM
                          AND C6.D_E_L_E_T_ <> '*'
                          AND C6_NOTA =  '         ' 
						  AND C6_NOTA <> 'XXXXXXXXX'
                          AND C6_BLQ <> 'R'
						  AND C6_FILIAL = '04'
WHERE  C5.C5_NUM <> X.C5_NUMX
ORDER BY C5_NUMECO
UPDATE SB4010 SET B4_OPER = '1',B4_STATECO = '2',B4_ENVECO = '1',B4_CATECO = '1'
WHERE
B4_COD = 'PE0000001'--IN('LPMA04528','CBAL00002','CBID00003','CBPD00004','CBMA00001','CRSC00032','MO0000001','PE0000001','PE0000002')

UPDATE SB1010 SET B1_OPER = '1',B1_STATECO = '2',B1_ENVECO = '1'
WHERE
B1_COD LIKE '%PE0000001%'

UPDATE SB1010 SET B1_OPER = '1',B1_STATECO = '1',B1_ENVECO = '2'
WHERE
B1_COD = 'T00000001001036'--LIKE '%T00000001%'

UPDATE SB2010 SET B2_MSEXP = '20120106'
WHERE
B2_COD LIKE '%%' AND
B2_LOCAL = '01' AND 
B2_FILIAL = '02' 

SELECT * FROM SB1010 WHERE B1_COD LIKE '%T00000001%'



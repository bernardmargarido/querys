SELECT B1_USAECO,B1_STATPRO,B1_ENVECO,B1_STATFIL,B1_STATEC FROM SB1010
WHERE 
B1_COD = '01100000001'

!-- WebService Produto 
SELECT SB1.B1_COD,R_E_C_N_O_ RECNOSB1 
FROM SB1010 SB1 
WHERE 
SB1.B1_USAECO  = '1' AND 
SB1.B1_STATPRO = '1' AND 
SB1.B1_ENVECO  = '2' AND 
SB1.B1_STATFIL = '1' AND 
SB1.B1_STATEC  = '1' AND 
SB1.D_E_L_E_T_ = ' ' 

!-- WebService Estoque
SELECT SB2.B2_COD,
(SB2.B2_QATU - SB2.B2_QEMP - SB2.B2_RESERVA) AS ESTOQUE, SB2.R_E_C_N_O_ AS RECSB2, SB1.B1_EMIN, SB1.R_E_C_N_O_ AS RECSB1
FROM 
SB2010 SB2 
INNER JOIN SB1010 SB1 ON SB1.B1_COD = SB2.B2_COD AND SB1.B1_USAECO = '1' AND SB1.B1_STATPRO = '1' AND SB1.D_E_L_E_T_ = ' ' 
WHERE 
SB2.B2_FILIAL = '00' AND 
SB2.B2_LOCAL = '01' AND 
SB2.B2_ENVECO = '1' AND 
SB2.D_E_L_E_T_ = ' ' 
ORDER BY B2_COD

!-- WebService Categorias x caracteristicas.
SELECT ZA2.ZA2_CODCAT,ZA2.ZA2_CODCAR, ZA2.ZA2_OBRIGA, ZA2.ZA2_STATUS,ZA2.ZA2_OPER, ZA2.ZA2_STATEC, 
ZA2.R_E_C_N_O_ AS RECNOZA2, ZA1.R_E_C_N_O_ AS RECNOZA1 
FROM ZA2010 ZA2 
INNER JOIN ZA1010 ZA1 ON ZA1.ZA1_FILIAL = ZA2.ZA2_FILIAL AND ZA1.ZA1_CODCAR = ZA2.ZA2_CODCAR AND ZA1.D_E_L_E_T_ = ' '
WHERE  
ZA2.ZA2_FILIAL = ' ' AND ZA2.ZA2_ENVECO = '1' AND ZA2.D_E_L_E_T_ = ' ' 
ORDER BY ZA2_CODCAR, ZA2_CODCAT

!-- WebService Categorias x caracteristicas x Produto.
SELECT DISTINCT ZA3.ZA3_PRODUT,ZA3.ZA3_CODCAR,ZA3.ZA3_VALOR,ZA3.ZA3_STATUS,ZA3.ZA3_OPER,ZA3.ZA3_STATEC,SB1.B1_STATEC 
FROM ZA3010 ZA3 
INNER JOIN SB1010 SB1
ON SB1.B1_FILIAL = '  ' AND SB1.B1_COD = ZA3.ZA3_PRODUT AND SB1.D_E_L_E_T_ = ' '
AND SB1.B1_STATEC = '1' AND SB1.B1_USAECO = '1' 
WHERE 
ZA3.ZA3_ENVECO = '1' AND ( ZA3.ZA3_SEQVAL <> ' ' OR ( ZA3.ZA3_SEQVAL = ' ' AND ZA3.ZA3_STATUS = '0' ) ) AND ZA3.ZA3_STATUS <> ' ' AND
ZA3.D_E_L_E_T_ = ' ' 
ORDER BY ZA3_PRODUT,ZA3_CODCAR

SELECT SA1.A1_COD,SA1.A1_LOJA, 
SA1.R_E_C_N_O_ RECNOREG, 
SU5.U5_CODECO 
FROM 
SA1010 SA1 
INNER JOIN SU5010 SU5 ON SU5.U5_CONTAEC = SA1.A1_CONTAEC AND SU5.D_E_L_E_T_ <> '*' 
WHERE 
SA1.A1_FILIAL = ' ' AND 
SA1.A1_ENVECO = '1' AND  
SA1.A1_OPER In('1','2') AND  
SA1.D_E_L_E_T_ = ' ' 
ORDER BY A1_COD 

SELECT * FROM SA1010
SELECT * FROM SU5010
SELECT * FROM ZA0010
SELECT * FROM SC6010
SELECT * FROM SC5010
SELECT * FROM SE1010

DELETE FROM SC5010
DELETE FROM SC6010
DELETE FROM SE1010

SP_HELP SC5010
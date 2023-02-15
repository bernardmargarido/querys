-- Categorias
SELECT ACU_COD,ACU_STATUS,ACU_CODPAI,ACU_ENVECO,
ACU_STATEC,ACU_OPER,ACU.R_E_C_N_O_ AS ACU_RECNO 
FROM 
ACU010 ACU 
WHERE 
ACU.ACU_FILIAL = ' ' AND 
ACU.ACU_ENVECO = '1' AND 
ACU.ACU_STATEC = '2' AND 
ACU.D_E_L_E_T_ = ' '
ORDER BY ACU_CODPAI

-- Tipo de Caracteristica
SELECT DISTINCT ZA3.ZA3_PRODUT,ZA3.ZA3_CODCAR,ZA3.ZA3_VALOR,ZA3.ZA3_STATUS,ZA3.ZA3_OPER,ZA3.ZA3_STATEC,SB1.B1_STATEC
FROM ZA3010 ZA3 
INNER JOIN SB1010 SB1 ON SB1.B1_FILIAL = ' ' AND SB1.B1_COD = ZA3.ZA3_PRODUT AND SB1.D_E_L_E_T_ = ' ' AND SB1.B1_STATEC = '1' AND SB1.B1_USAECO = '1' 
WHERE 
ZA3.ZA3_ENVECO = '1' AND 
ZA3.ZA3_STATEC = '2' AND 
ZA3.D_E_L_E_T_ = ' ' 
ORDER BY ZA3_PRODUT,ZA3_CODCAR

-- Fabricantes
SELECT T7_FABRICA,T7_STATUS, 
T7_OPER,R_E_C_N_O_ RECNOREG 
FROM 
ST7010 
WHERE
T7_FILIAL = '' AND 
T7_ENVECOM = '1' AND 
T7_STATECO = '2' AND 
D_E_L_E_T_ = ''
ORDER BY T7_FABRICA 

-- Tipos Caracteristicas
SELECT ZA2.ZA2_CODCAT,ZA2.ZA2_CODCAR, ZA2.ZA2_OBRIGA, 
ZA2.ZA2_STATUS,ZA2.ZA2_OPER, ZA2.ZA2_STATEC, 
ZA2.R_E_C_N_O_ AS RECNOZA2, ZA1.R_E_C_N_O_ AS RECNOZA1 
FROM 
ZA2010 ZA2 
INNER JOIN ZA1010 ZA1 ON ZA1.ZA1_FILIAL = ZA2.ZA2_FILIAL AND ZA1.ZA1_CODCAR = ZA2.ZA2_CODCAR AND ZA1.D_E_L_E_T_ = ' ' 
WHERE 
ZA2.ZA2_FILIAL = ' ' AND 
ZA2.ZA2_ENVECO = '1' AND 
ZA2.ZA2_STATEC = '2' AND 
ZA2.D_E_L_E_T_ = ' ' 
ORDER BY ZA2_CODCAR, ZA2_CODCAT

-- Produtos x Caracteristicas x Valores Caracteristicas.
SELECT 
DISTINCT ZA3.ZA3_PRODUT,ZA3.ZA3_CODCAR,
ZA3.ZA3_VALOR,ZA3.ZA3_STATUS,ZA3.ZA3_OPER,
ZA3.ZA3_STATEC,SB1.B1_STATEC 
FROM 
ZA3010 ZA3
INNER JOIN SB1010 SB1 ON SB1.B1_FILIAL = ' ' AND SB1.B1_COD = ZA3.ZA3_PRODUT AND SB1.D_E_L_E_T_ = ' ' AND SB1.B1_STATEC = '1' AND SB1.B1_USAECO = '1' 
WHERE 
ZA3.ZA3_ENVECO = '1' AND 
ZA3.ZA3_STATEC = '2' AND 
ZA3.ZA3_STATUS <> ' ' AND 
ZA3.D_E_L_E_T_ = ' ' 
ORDER BY ZA3_PRODUT,ZA3_CODCAR

-- Produto Categoria
SELECT ACV.ACV_REFGRD,ACV.ACV_CATEGO, 
ACV.ACV_STATUS,ACV.ACV_OPER,ACV.ACV_STATEC, 
ACV.R_E_C_N_O_ RECNOACV,SB1.B1_STATEC 
FROM 
ACV010 ACV 
INNER JOIN SB1010 SB1 ON SB1.B1_FILIAL = ' ' AND SB1.B1_COD = ACV.ACV_REFGRD AND SB1.D_E_L_E_T_ = ' ' AND SB1.B1_STATEC = '1' 
WHERE 
ACV.ACV_FILIAL = ' ' AND  
ACV.ACV_ENVECO = '1' AND 
ACV.ACV_STATEC = '2' AND
ACV.D_E_L_E_T_ = ' ' 
ORDER BY ACV_CATEGO 

-- Produto Pai
SELECT SB1.B1_COD,R_E_C_N_O_ RECNOSB1 
FROM SB1010 SB1 
WHERE 
SB1.B1_USAECO = '1' AND 
SB1.B1_STATPRO IN('1','2') AND 
SB1.B1_ENVECO = '1' AND 
SB1.B1_STATEC = '2' AND 
SB1.B1_MSBLQL <> '1' AND 
SB1.D_E_L_E_T_ = ' ' 

-- Produto Filho
SELECT SB1.B1_COD,ZA5.ZA5_CODCOR, 
Cast(Cast(ZA5.ZA5_DESECO as Binary(1024)) as varchar(1024)) CORECO, 
ZAC.ZAC_CODIGO, 
Cast(Cast(ZAC.ZAC_DESCEC as Binary(1024)) as varchar(1024)) VOLTAGEMECO, 
ZAD.ZAD_CODIGO, 
Cast(Cast(ZAD.ZAD_DESCEC as Binary(1024)) as varchar(1024)) MATERIALECO, 
ZAE.ZAE_CODIGO, 
Cast(Cast(ZAE.ZAE_DESCEC as Binary(1024)) as varchar(1024)) FORMAECO, 
ZAH.ZAH_CODIGO, 
Cast(Cast(ZAH.ZAH_DESCEC as Binary(1024)) as varchar(1024)) EMBALAGEMECO, 
ZAG.ZAG_CODIGO, 
Cast(Cast(ZAG.ZAG_DESCEC as Binary(1024)) as varchar(1024)) ESTAMPAECO, 
ZAF.ZAF_CODIGO, 
Cast(Cast(ZAF.ZAF_DESCEC as Binary(1024)) as varchar(1024)) TECIDOECO, 
SB1.R_E_C_N_O_ RECNOSB1  
FROM  SB1010  SB1 
LEFT OUTER JOIN  ZA5010 ZA5 ON ZA5.ZA5_CODCOR = SB1.B1_CORECO AND ZA5.D_E_L_E_T_ = ' ' 
LEFT OUTER JOIN  ZAC010 ZAC ON ZAC.ZAC_CODIGO = SB1.B1_CODVOLT AND ZAC.D_E_L_E_T_ = ' ' 
LEFT OUTER JOIN  ZAD010 ZAD ON ZAD.ZAD_CODIGO = SB1.B1_MATECO AND ZAD.D_E_L_E_T_ = ' ' 
LEFT OUTER JOIN  ZAE010 ZAE ON ZAE.ZAE_CODIGO = SB1.B1_FORMECO AND ZAE.D_E_L_E_T_ = ' ' 
LEFT OUTER JOIN  ZAH010 ZAH ON ZAH.ZAH_CODIGO = SB1.B1_EMBECO AND ZAH.D_E_L_E_T_ = ' ' 
LEFT OUTER JOIN  ZAF010 ZAF ON ZAF.ZAF_CODIGO = SB1.B1_TECIECO AND ZAF.D_E_L_E_T_ = ' ' 
LEFT OUTER JOIN  ZAG010 ZAG ON ZAG.ZAG_CODIGO = SB1.B1_ESTAMEC AND ZAF.D_E_L_E_T_ = ' '  
WHERE 
SB1.B1_USAECO  = '1' AND 
SB1.B1_STATPRO IN('1','2') AND 
SB1.B1_ENVECO  = '2' AND 
SB1.B1_STATFIL = '1' AND                         
SB1.B1_STATEC  = '1' AND 
SB1.B1_MSBLQL <> '1' AND 
SB1.D_E_L_E_T_ = ' ' 

-- Estoque 
SELECT SB2.B2_COD, 
(SB2.B2_QATU - SB2.B2_QEMP - SB2.B2_RESERVA) AS ESTOQUE,
SB2.R_E_C_N_O_ AS RECSB2, SB1.B1_EMIN, SB1.R_E_C_N_O_ AS RECSB1 
FROM 
SB2010 SB2 
INNER JOIN SB1010 SB1 ON SB1.B1_COD = SB2.B2_COD AND SB1.B1_USAECO = '1' AND SB1.B1_STATPRO = '1' AND SB1.D_E_L_E_T_ = ' ' 
WHERE 
SB2.B2_FILIAL = '14' AND 
SB2.B2_LOCAL = '01' AND 
--SB2.B2_MSEXP = ' ' AND 
SB2.D_E_L_E_T_ = ' ' 
ORDER BY B2_COD 

-- Altera��o Pre�o
SELECT DA1.DA1_CODPRO,DA1.DA1_BASSEL,DA1.DA1_PRCVEN,DA1.R_E_C_N_O_ RECNODA1 
FROM 
DA1010 DA1 
LEFT OUTER JOIN SB1010 SB1 ON SB1.B1_FILIAL = ' ' AND SB1.B1_COD = DA1.DA1_CODPRO AND SB1.B1_ENVECO = '2' AND SB1.B1_STATEC = '1' AND SB1.D_E_L_E_T_ = '' 
WHERE 
DA1.DA1_FILIAL = ' ' AND 
DA1.DA1_ENVECO = '2' AND 
DA1.DA1_CODTAB = 'ECO' AND 
DA1.D_E_L_E_T_ = '' 

-- Update Produto Pai e Filho
UPDATE SB1010 SET B1_ENVECO = '1', B1_STATEC = '2',B1_USAECO = '1', B1_OPER = '1',B1_STATFIL = '1',B1_STATPRO = '1',B1_MSBLQL = '2'
FROM 
SB1010 SB1
INNER JOIN DA1010 DA1 ON DA1.DA1_CODTAB = 'ECO' AND DA1.DA1_CODPRO = SB1.B1_COD AND DA1.D_E_L_E_T_ = ''
WHERE
SB1.D_E_L_E_T_ = ''

-- Update Produto Categoria
UPDATE ACV010 SET ACV_ENVECO = '1', ACV_STATEC = '2',ACV_OPER = '1',ACV_STATUS = '1'
FROM 
ACV010 ACV
INNER JOIN DA1010 DA1 ON DA1.DA1_CODTAB = 'ECO' AND DA1.DA1_CODPRO = ACV.ACV_REFGRD AND DA1.D_E_L_E_T_ = ''
WHERE
ACV.D_E_L_E_T_ = ''

UPDATE ZA3010 SET ZA3_ENVECO = '1', ZA3_STATEC = '2',ZA3_OPER = '1',ZA3_STATUS = '1'
FROM 
ZA3010 ZA3
INNER JOIN DA1010 DA1 ON DA1.DA1_CODTAB = 'ECO' AND DA1.DA1_CODPRO = ZA3.ZA3_PRODUT AND DA1.D_E_L_E_T_ = ''
WHERE
ZA3.D_E_L_E_T_ = ''

UPDATE DA1010 SET DA1_ENVECO = '2'
FROM 
DA1010 DA1
INNER JOIN SB1010 SB1 ON SB1.B1_COD = DA1.DA1_CODPRO AND SB1.B1_ENVECO = '2' AND SB1.D_E_L_E_T_ = ''
WHERE
DA1.DA1_CODTAB IN('ECO','CRE') AND 
DA1.D_E_L_E_T_ = ''

UPDATE SB1010 SET B1_ENVECO = '2',B1_STATEC = '1',B1_STATFIL = '2' 
WHERE
B1_COD = 'B06016000121'

SELECT DA1.DA1_CODPRO,DA1.DA1_CODTAB
FROM 
DA1010 DA1 
INNER JOIN SB1010 SB1 ON SB1.B1_FILIAL = '  ' AND SB1.B1_COD = DA1.DA1_CODPRO AND SB1.B1_ENVECO = '2' AND SB1.B1_STATEC = '1' AND SB1.D_E_L_E_T_ = '' 
WHERE 
DA1.DA1_FILIAL = '  ' AND 
DA1.DA1_ENVECO = '2' AND 
DA1.DA1_CODTAB IN('ECO','CRE') AND 
DA1.D_E_L_E_T_ = '' 


SELECT SB1.B1_COD,SB1.B1_DESC, 
SB1.B1_UM,SB1.B1_TIPO, 
SB1.B1_GRUPO
FROM SB1010 SB1 
WHERE 
SB1.B1_FILIAL = ' ' AND 
SB1.B1_COD BETWEEN 'B06016000121' AND 'B06016000121' AND 
SB1.B1_TIPO BETWEEN '  ' AND 'ZZ' AND 
SB1.B1_GRUPO BETWEEN '  ' AND 'ZZZZ' AND 
SB1.D_E_L_E_T_ = ' ' 
ORDER BY B1_COD 

SELECT * FROM ZA3010

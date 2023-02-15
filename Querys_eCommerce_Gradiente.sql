-- Categoria
SELECT AY1_CODIGO,AY1_SUBCAT,AY0_DESC,AY0_OPER,AY0_STATUS,AY1_CATPAI,AY1_CATFIL,SYP.YP_TEXTO,AY0.R_E_C_N_O_ RECNOAY0 
FROM AY1010 AY1 
INNER JOIN AY0010 AY0 ON AY0.AY0_CODIGO = AY1.AY1_SUBCAT AND 
AY0.AY0_ENVECO = '1' AND AY0.AY0_STATEC = '2' AND AY0.D_E_L_E_T_ = ' ' 
INNER JOIN SYP010 SYP ON SYP.YP_CHAVE = AY0.AY0_CODDES AND SYP.D_E_L_E_T_ = '' 
WHERE 
AY1.D_E_L_E_T_ = ' ' 
ORDER BY AY1_CATPAI 

-- Produto
SELECT B4_COD,B4_01CODMA,B4_PESO,B4_PESOEMB,B4_ALTPROD,B4_ALTEMBA,B4_LARGPRO,B4_LARGEMB,B4_PROFPRO,B4_PROFEMB, 
B4_ENTREGA,B4_QTDMAX,B4_STATUS,B4_TIPOPRO,B4_PRESENT,B4_PERSONA,B4_TITPERS,B4_YOUTUBE,B4_PRV1,B4_OPER,B4_01CODEN,
SB4.R_E_C_N_O_ RECNOSB4, DA1.DA1_PRCVEN 
FROM 
SB4010 SB4
LEFT OUTER JOIN DA1010 DA1 ON DA1.DA1_CODTAB = '012' AND DA1.DA1_CODPRO = SB4.B4_COD AND DA1.D_E_L_E_T_ = ''
WHERE 
--B4_FILIAL = '01' AND 
B4_USAECO = '1' AND 
B4_STATECO IN('0','2') AND 
SB4.D_E_L_E_T_ = '' 
ORDER BY B4_COD 

-- Produto Filho
SELECT SB4.B4_COD,SB4.B4_LINHA,SB4.B4_COLUNA,SB1.B1_COD,SB1.B1_STATUS, 
SB1.B1_DESC,SB1.B1_OPER,B1_PRV1,SB1.B1_01CLGRD,SB1.B1_01LNGRD,SB1.R_E_C_N_O_ RECNOSB1, 
(SELECT BV_DESCRI FROM SBV010 SBV WHERE SBV.BV_TABELA = SB4.B4_COLUNA AND SBV.BV_CHAVE = SB1.B1_01CLGRD AND D_E_L_E_T_ = '') DESCCOL, 
(SELECT BV_DESCRI FROM SBV010 SBV WHERE SBV.BV_CHAVE = SB4.B4_LINHA AND SBV.D_E_L_E_T_ = '') DESCLIN, 
DA1.DA1_PRCVEN, DA1.R_E_C_N_O_ RECNODA1 
FROM 
SB4010 SB4 
INNER JOIN SB1010 SB1 ON  SB1.B1_FILIAL = '01' AND SUBSTRING(B1_COD,1,LEN(SB4.B4_COD)) = SB4.B4_COD AND 
SB1.B1_STATECO = '2' AND SB1.B1_ENVECO = '1' AND SB1.B1_USAECO = '1' AND SB1.D_E_L_E_T_ = '' 
LEFT OUTER JOIN DA1010 DA1 ON DA1.DA1_FILIAL = ' ' AND DA1.DA1_CODTAB = '001' AND ( DA1.DA1_CODPRO = SB1.B1_COD ) OR (DA1.DA1_REFGRD = SB4.B4_COD ) AND DA1.D_E_L_E_T_ = ' ' 
WHERE 
SB4.B4_FILIAL = '01' AND 
SB4.B4_ENVECO = '2' AND 
SB4.B4_01UTGRD = 'S' AND 
SB4.B4_STATECO = '1' AND  
SB4.D_E_L_E_T_ = '' 
ORDER BY B4_COD 

-- Produto Categoria
SELECT DISTINCT(SB4.B4_COD),SB4.B4_DESC,SB4.B4_01CAT1,SB4.B4_01CAT2,SB4.B4_01CAT3,SB4.B4_01CAT4,SB4.B4_01CAT5,SB4.B4_OPER,SB4.R_E_C_N_O_ RECNOSB4, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_SUBCAT = SB4.B4_01CAT1 AND AY1.D_E_L_E_T_ = '' ) CATNV1, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_CODIGO = SB4.B4_01CAT1 AND AY1.AY1_SUBCAT = SB4.B4_01CAT2 AND AY1.D_E_L_E_T_ = '' ) CATNV2, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_CODIGO = SB4.B4_01CAT2 AND AY1.AY1_SUBCAT = SB4.B4_01CAT3 AND AY1.D_E_L_E_T_ = '' ) CATNV3, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_CODIGO = SB4.B4_01CAT3 AND AY1.AY1_SUBCAT = SB4.B4_01CAT4 AND AY1.D_E_L_E_T_ = '' ) CATNV4, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_CODIGO = SB4.B4_01CAT4 AND AY1.AY1_SUBCAT = SB4.B4_01CAT5 AND AY1.D_E_L_E_T_ = '' ) CATNV5  
FROM 
SB4010 SB4 
WHERE 
SB4.B4_FILIAL = '01' AND 
SB4.B4_USAECO = '1' AND 
SB4.B4_ENVECO = '2' AND 
SB4.B4_STATECO = '1' AND 
SB4.B4_CATECO = '1' AND 
SB4.D_E_L_E_T_ = '' 
ORDER BY B4_COD 

-- Filtros
SELECT DISTINCT(AY3.AY3_CODIGO), 
CAST(CAST(AY3.AY3_DESCEC AS BINARY) AS VARCHAR) CARDESC, 
AY3.AY3_OPER,AY3.AY3_STATUS,AY3.R_E_C_N_O_ RECNOAY3, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_SUBCAT = SB4.B4_01CAT1 AND AY1.D_E_L_E_T_ = '' ) CATNV1, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_CODIGO = SB4.B4_01CAT1 AND AY1.AY1_SUBCAT = SB4.B4_01CAT2 AND AY1.D_E_L_E_T_ = '' ) CATNV2, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_CODIGO = SB4.B4_01CAT2 AND AY1.AY1_SUBCAT = SB4.B4_01CAT3 AND AY1.D_E_L_E_T_ = '' ) CATNV3, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_CODIGO = SB4.B4_01CAT3 AND AY1.AY1_SUBCAT = SB4.B4_01CAT4 AND AY1.D_E_L_E_T_ = '' ) CATNV4, 
(SELECT AY1.AY1_CATFIL FROM AY1010 AY1 WHERE AY1.AY1_CODIGO = SB4.B4_01CAT4 AND AY1.AY1_SUBCAT = SB4.B4_01CAT5 AND AY1.D_E_L_E_T_ = '' ) CATNV5, 
SB4.B4_COD 
FROM 
AY3010 AY3 
INNER JOIN AY5010 AY5 ON AY5.AY5_FILIAL = '' AND AY5_CODIGO = AY3.AY3_CODIGO AND AY5.D_E_L_E_T_ = '' 
INNER JOIN SB4010 SB4 ON SB4.B4_FILIAL = '' AND SB4.B4_COD = AY5.AY5_CODPRO AND SB4.B4_USAECO = '1' AND SB4.B4_ENVECO = '2' AND SB4.B4_STATECO = '1' AND SB4.D_E_L_E_T_ = '' 
WHERE 
AY3.AY3_STATEC IN('0','2') AND 
AY3.AY3_ENVECO = '1' AND 
AY3.D_E_L_E_T_ = '' 
ORDER BY B4_COD 

-- Filtro x Produto
SELECT AY5.AY5_CODIGO,AY5.AY5_SEQ, 
CAST(CAST(AY4.AY4_VLRECO AS BINARY) AS VARCHAR) VLRECO, 
AY5.AY5_CODPRO,AY5.AY5_OPER,AY5.AY5_STATUS,AY5.R_E_C_N_O_ RECNOAY5, 
AY4.R_E_C_N_O_ RECNOAY4 
FROM 
AY5010 AY5 
INNER JOIN AY4010 AY4 ON AY4.AY4_FILIAL = '' AND AY4.AY4_CODCAR = AY5.AY5_CODIGO AND AY4.AY4_SEQ = AY5.AY5_SEQ AND AY4.AY4_STATEC = '2' AND AY4.AY4_ENVECO = '1' AND AY4.D_E_L_E_T_ = '' 
INNER JOIN SB4010 SB4 ON SB4.B4_FILIAL = '01' AND SB4.B4_COD = AY5.AY5_CODPRO AND SB4.B4_ENVECO = '2' AND SB4.B4_STATECO = '1' AND SB4.B4_USAECO = '1' AND SB4.D_E_L_E_T_ = '' 
WHERE 
AY5.AY5_FILIAL = '' AND 
AY5.AY5_ENVECO = '1' AND  
AY5.AY5_STATEC = '2' AND 
AY5.D_E_L_E_T_ = ' ' 
ORDER BY AY5_CODPRO 

-- Estoque
SELECT SB4.B4_COD,SB1.B1_COD,SB1.B1_DESC,SB1.B1_LOCPAD, 
(SB2.B2_QATU - SB2.B2_QEMP - SB2.B2_RESERVA - SB2.B2_QPEDVEN) AS ESTOQUE,
SB2.R_E_C_N_O_ RECNOSB2
FROM 
SB2010 SB2 
INNER JOIN SB1010 SB1 ON SB1.B1_FILIAL = '01' AND SB1.B1_COD = SB2.B2_COD AND SB1.B1_STATECO = '1' AND SB1.B1_ENVECO = '2' AND SB1.B1_USAECO = '1' AND SB1.D_E_L_E_T_ = '' 
INNER JOIN SB4010 SB4 ON SB4.B4_FILIAL = '01' AND SB4.B4_COD = SUBSTRING(SB1.B1_COD,1,LEN(SB4.B4_COD)) AND SB4.B4_USAECO = '1' AND SB4.B4_TIPOPRO <> '2' AND SB4.D_E_L_E_T_ = ' ' 
WHERE 
SB2.B2_FILIAL = '02' AND 
SB2.B2_LOCAL = 'EC' AND 
SB2.B2_MSEXP = '' AND 
SB2.D_E_L_E_T_ = ' ' 
ORDER BY B2_COD 

--Altera��o Pre�o
SELECT DA1.DA1_REFGRD,DA1.DA1_CODPRO,DA1.DA1_PRCVEN,SB1.B1_PRV1,SB4.B4_PRV1,DA1.R_E_C_N_O_ RECNODA1 
FROM 
DA1010 DA1
LEFT OUTER JOIN SB4010 SB4 ON SB4.B4_FILIAL = '01' AND SB4.B4_COD = DA1.DA1_REFGRD AND SB4.B4_ENVECO = '2' AND SB4.B4_STATECO = '1' AND SB4.B4_USAECO = '1' AND SB4.D_E_L_E_T_ = '' 
LEFT OUTER JOIN SB1010 SB1 ON SB1.B1_FILIAL = '01' AND SB1.B1_COD = DA1.DA1_CODPRO AND SB1.B1_ENVECO = '2' AND SB1.B1_STATECO = '1' AND SB1.B1_USAECO = '1' AND SB1.D_E_L_E_T_ = '' 
WHERE
DA1.DA1_FILIAL = '' AND 
DA1.DA1_ENVECO = '2' AND 
DA1.DA1_CODTAB = '001' AND 
DA1.D_E_L_E_T_ = '' 
SELECT 
	SB1.B1_COD,
	SB1.B1_DESC,
	SB1.B1_UM,
	SB1.B1_XCOLECA,
	SB4.B4_01MULSO,
	SB4.B4_01QMINS,
	SB4.B4_COD,
	DA1.DA1_PRCVEN,
	SB4.B4_01CANAL,
	SB4.B4_01CAT1,
	SB4.B4_01CAT2,
	SB4.B4_01CAT3,
	SB4.B4_01CAT4,
	SB4.B4_GRUPO,
	SB4.B4_COLUNA,
	SB4.R_E_C_N_O_ RECNOSB4,
	SB1.R_E_C_N_O_ RECNOSB1
FROM 
	SB4010 SB4 
	INNER JOIN SB1010 SB1 ON SB1.B1_FILIAL = '' AND SUBSTRING(SB1.B1_COD,1,23) = SB4.B4_COD	AND SB1.D_E_L_E_T_ = ''
	INNER JOIN DA0010 DA0 ON DA0.DA0_FILIAL = '05' AND DA0.DA0_XCOLEC = 'F14' AND DA0.DA0_XREFER = '63' AND DA0.D_E_L_E_T_ = ''
	INNER JOIN DA1010 DA1 ON DA1.DA1_FILIAL = '05' AND DA1.DA1_CODTAB = DA0.DA0_CODTAB AND DA1.DA1_REFGRD = SB4.B4_COD AND DA1.D_E_L_E_T_ = ''
WHERE
	SB4.B4_FILIAL = ''
	AND SB4.B4_COD BETWEEN '' AND 'ZZZZZZZZZZZZZZZZZZZZZZZZZ' 
	AND SB4.B4_01COLEC = 'F14'
	AND SB4.B4_MSEXP = '' 
	AND SB4.D_E_L_E_T_ = '' 

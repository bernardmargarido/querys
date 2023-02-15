-- Usina Filial 01
SELECT 
	A3.A3_COD,
	A3.A3_CODP12,
	A1.A1_CGC,
	F2.F2_DOC, 
	F2.F2_SERIE,
	D2.D2_CCUSTO
FROM 
	SA3010 A3 
	INNER JOIN SA1010 A1 ON A1.A1_FILIAL = '  ' AND A1.A1_VEND = A3.A3_COD AND A1.D_E_L_E_T_ = ''
	INNER JOIN SF2010 F2 ON F2.F2_FILIAL = '01' AND F2.F2_CLIENTE = A1.A1_COD AND F2.F2_LOJA = A1.A1_LOJA AND F2.F2_VEND1 = A3.A3_COD AND F2.F2_EMISSAO > '20140101' AND F2.D_E_L_E_T_ = ''
	INNER JOIN SD2010 D2 ON D2.D2_FILIAL = '01' AND D2.D2_DOC = F2.F2_DOC AND D2.D2_SERIE = F2.F2_SERIE AND D2.D_E_L_E_T_= ''
WHERE
	A3.A3_FILIAL = '  ' AND 
	A3.A3_CODP12 <> '' AND 
	A3.D_E_L_E_T_ = ''
GROUP BY A3.A3_COD,
	A3.A3_CODP12,
	A1.A1_CGC,
	F2.F2_DOC, 
	F2.F2_SERIE,
	D2.D2_CCUSTO
ORDER BY F2_DOC,F2_SERIE

-- Usina Filial 02
SELECT 
	A3.A3_COD,
	A3.A3_CODP12,
	A1.A1_CGC,
	F2.F2_DOC, 
	F2.F2_SERIE,
	D2.D2_CCUSTO
FROM 
	SA3010 A3 
	INNER JOIN SA1010 A1 ON A1.A1_FILIAL = '  ' AND A1.A1_VEND = A3.A3_COD AND A1.D_E_L_E_T_ = ''
	INNER JOIN SF2010 F2 ON F2.F2_FILIAL = '02' AND F2.F2_CLIENTE = A1.A1_COD AND F2.F2_LOJA = A1.A1_LOJA AND F2.F2_VEND1 = A3.A3_COD AND F2.F2_EMISSAO > '20140101' AND F2.D_E_L_E_T_ = ''
	INNER JOIN SD2010 D2 ON D2.D2_FILIAL = '02' AND D2.D2_DOC = F2.F2_DOC AND D2.D2_SERIE = F2.F2_SERIE AND D2.D_E_L_E_T_= ''
WHERE
	A3.A3_FILIAL = '  ' AND 
	A3.A3_CODP12 <> '' AND 
	A3.D_E_L_E_T_ = ''
GROUP BY A3.A3_COD,
	A3.A3_CODP12,
	A1.A1_CGC,
	F2.F2_DOC, 
	F2.F2_SERIE,
	D2.D2_CCUSTO
ORDER BY F2_DOC,F2_SERIE

-- RG Filial 01
SELECT 
	A3.A3_COD,
	A3.A3_CODP12,
	A1.A1_CGC,
	F2.F2_DOC, 
	F2.F2_SERIE,
	D2.D2_CCUSTO
FROM 
	SA3070 A3 
	INNER JOIN SA1070 A1 ON A1.A1_FILIAL = '01' AND A1.A1_VEND = A3.A3_COD AND A1.D_E_L_E_T_ = ''
	INNER JOIN SF2070 F2 ON F2.F2_FILIAL = '01' AND F2.F2_CLIENTE = A1.A1_COD AND F2.F2_LOJA = A1.A1_LOJA AND F2.F2_VEND1 = A3.A3_COD AND F2.F2_EMISSAO > '20140101' AND F2.D_E_L_E_T_ = ''
	INNER JOIN SD2070 D2 ON D2.D2_FILIAL = '01' AND D2.D2_DOC = F2.F2_DOC AND D2.D2_SERIE = F2.F2_SERIE AND D2.D_E_L_E_T_= ''
WHERE
	A3.A3_FILIAL = '01' AND 
	A3.A3_CODP12 <> '' AND 
	A3.D_E_L_E_T_ = ''
GROUP BY A3.A3_COD,
	A3.A3_CODP12,
	A1.A1_CGC,
	F2.F2_DOC, 
	F2.F2_SERIE,
	D2.D2_CCUSTO
ORDER BY F2_DOC,F2_SERIE
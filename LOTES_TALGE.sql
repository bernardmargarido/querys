-- SALDO LOTE
UPDATE SB8030 SET B8_LOTECTL = 'TSLB001'
FROM
	SB8030
WHERE
	B8_PRODUTO = '7381' AND 
	B8_LOTECTL = '0TLSB001' AND 
	D_E_L_E_T_ = ''

-- BAIXA LOTE
UPDATE SD5030 SET D5_LOTECTL = 'TSLB001'
FROM
	SD5030
WHERE
	D5_PRODUTO = '7381' AND 
	D5_LOTECTL = '0TLSB001' AND 
	D_E_L_E_T_ = ''

-- NOTA SAIDA 
UPDATE SD2030 SET D2_LOTECTL = 'TSLB001'
FROM
	SD2030
WHERE
	D2_COD = '7381' AND 
	D2_LOTECTL = '0TLSB001' AND 
	D_E_L_E_T_ = ''

-- ITEM LIBERADO
UPDATE SC9030 SET C9_LOTECTL = 'TSLB001'
FROM
	SC9030
WHERE
	C9_PRODUTO = '7381' AND 
	C9_LOTECTL = '0TLSB001' AND 
	D_E_L_E_T_ = ''


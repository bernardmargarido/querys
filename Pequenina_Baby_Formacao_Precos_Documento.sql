SELECT 
	ISNULL(WS5.WS5_ITEM,'') WS5_ITEM,
	B4.B4_COD WS5_REFGRD, 
	B4.B4_DESC WS5_DREFGR,
	ISNULL(B1.B1_COD,'') WS5_CODPRD,
	ISNULL(B1.B1_DESC,'') WS5_DESPRD,
	D1.D1_VUNIT WS5_PRCCUS,
	ISNULL(DA1.DA1_PRCVEN,0) WS5_PRCVEN,
	ISNULL(WS5.WS5_IPI,0) WS5_IPI,
	ISNULL(WS5.WS5_ICMS,0) WS5_ICMS,
	ISNULL(WS5.WS5_DEFIXA,0) WS5_DEFIXA,
	ISNULL(WS5.WS5_DEVARI,0) WS5_DEVARI,
	ISNULL(WS5.WS5_FRETE,0) WS5_FRETE,
	ISNULL(WS5.WS5_COMISS,0) WS5_COMISS,
	ISNULL(WS5.WS5_JUROS,0) WS5_JUROS,
	ISNULL(WS5.WS5_INADIM,0) WS5_INADIM,
	ISNULL(WS5.WS5_MARKET,0) WS5_MARKET,
	ISNULL(WS5.WS5_MARGEM,0) WS5_MARGEM,
	AY2.AY2_CODIGO WS5_MARCA,
	AY2.AY2_DESCR WS5_DESMAR,
	ISNULL(WS5.WS5_STATUS,'1') WS5_STATUS,
	D1.D1_EMISSAO
FROM 
	SD1010 D1 
	INNER JOIN SB4010 B4 ON B4.B4_FILIAL = '01  ' AND B4.B4_COD = SUBSTRING(D1.D1_COD,1,9) AND B4.D_E_L_E_T_ = '' 
	INNER JOIN SB2010 B2 ON B2.B2_FILIAL = '0101' AND B2.B2_COD = D1.D1_COD AND B2.D_E_L_E_T_ = '' 
	INNER JOIN AY2010 AY2 ON AY2.AY2_FILIAL = '' AND AY2.AY2_CODIGO = B4.B4_01CODMA AND AY2.D_E_L_E_T_ = ''
	LEFT OUTER JOIN DA1010 DA1 ON DA1.DA1_FILIAL = '01' AND DA1.DA1_CODTAB = '001' AND DA1.DA1_REFGRD = B4.B4_COD AND DA1.D_E_L_E_T_ = ''
	LEFT OUTER JOIN SB1010 B1 ON B1.B1_FILIAL = '01  ' AND B1.B1_COD = D1.D1_COD AND B1.D_E_L_E_T_ = ''
	LEFT OUTER JOIN WS5010 WS5 ON WS5.WS5_FILIAL = '0101' AND WS5.WS5_CODIGO = '000001' AND WS5.WS5_TABELA = '001' AND WS5.D_E_L_E_T_ = ''
WHERE
	D1.D1_FILIAL = '0101' AND 
	D1.D1_DOC = '000047921' AND 
	D1.D1_SERIE = '1' AND 
	D1.D_E_L_E_T_ = ''
GROUP BY WS5.WS5_ITEM,B4.B4_COD,B4.B4_DESC,B1.B1_COD,
		 B1.B1_DESC,D1.D1_VUNIT,DA1.DA1_PRCVEN,WS5.WS5_IPI,
		 WS5.WS5_ICMS,WS5.WS5_DEFIXA,WS5.WS5_DEVARI,
		 WS5.WS5_FRETE,WS5.WS5_COMISS,WS5.WS5_JUROS,
		 WS5.WS5_INADIM,WS5.WS5_MARKET,WS5.WS5_MARGEM,
		 AY2.AY2_CODIGO,AY2.AY2_DESCR,WS5.WS5_STATUS,
		 D1_EMISSAO
HAVING D1.D1_EMISSAO = MAX(D1.D1_EMISSAO)
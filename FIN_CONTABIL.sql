-- SALDOS EM ABERTO
SELECT 
	E1.E1_FILIAL FILIAL, 
	E1.E1_NUM TITULO,
	E1.E1_PREFIXO PREFIXO,
	E1.E1_EMISSAO EMISSAO,
	COALESCE(CT2.CT2_DATA,'') CONTABILIZACAO,
	COALESCE(CT2.CT2_DEBITO,'') CONTA,
	COALESCE(CT2.CT2_VALOR,0) VALOR_CONTABIL,
	SUM(E1.E1_VALOR) VALOR_TITULO	
FROM 
	SE1040 E1 WITH (NOLOCK)
	CROSS APPLY(
		SELECT 
			TOP 1
			D2.D2_FILIAL,
			D2.D2_DOC,
			D2.D2_SERIE,
			D2.D2_CLIENTE,
			D2.D2_LOJA,
			D2.D2_COD,
			D2.D2_ITEM ITEM
		FROM 
			SD2040 D2 WITH (NOLOCK)
		WHERE 
			D2.D2_FILIAL = E1.E1_FILIAL AND 
			D2.D2_DOC = E1.E1_NUM AND 
			D2.D2_SERIE = E1.E1_PREFIXO AND 
			D2.D_E_L_E_T_ = ''
	) ITENS_NOTA
	LEFT JOIN CT2040 CT2 WITH (NOLOCK) ON CT2.CT2_FILIAL = E1.E1_FILIAL AND CT2.CT2_LOTE = '008820' AND	CT2.CT2_DEBITO = '1010201001' AND CT2_KEY LIKE ITENS_NOTA.D2_FILIAL + ITENS_NOTA.D2_DOC + ITENS_NOTA.D2_SERIE + ITENS_NOTA.D2_CLIENTE + ITENS_NOTA.D2_LOJA + ITENS_NOTA.D2_COD + ITENS_NOTA.ITEM AND CT2.D_E_L_E_T_ = ''
WHERE 
	--E1.E1_FILIAL = '0404' AND 
	E1.E1_TIPO = 'NF' AND 
	E1.E1_EMISSAO BETWEEN '20210501' AND '20210531' AND 
	E1.D_E_L_E_T_ = ''
GROUP BY E1.E1_FILIAL,E1.E1_NUM,E1.E1_PREFIXO,E1.E1_EMISSAO,CT2.CT2_DATA,CT2.CT2_DEBITO,CT2.CT2_VALOR

-- SALDOS BAIXADOS
SELECT 
	E5.E5_FILIAL FILIAL, 
	E5.E5_NUMERO TITULO,
	E5.E5_PREFIXO PREFIXO,
	E5.E5_DATA DATA_BAIXA,
	E5.E5_PARCELA PARCELA,
	SUM(E5_VALOR) VALOR_TITULO,
	COALESCE(BAIXA_CONTABIL.CT2_VALOR,0) VALOR_CONTABIL
FROM 
	SE5040 E5 WITH (NOLOCK)
	OUTER APPLY( 
		SELECT  
			CT2.CT2_DATA ,
			CT2.CT2_CREDIT,
			SUM(CT2.CT2_VALOR) CT2_VALOR
		FROM 
			CT2040 CT2 WITH (NOLOCK) 
		WHERE 
			CT2.CT2_FILIAL = E5.E5_FILIAL AND 
			CT2.CT2_LOTE = '008850' AND	
			CT2.CT2_CREDIT = '1010201001' AND 
			CT2.CT2_LP IN('520','521') AND 
			CT2_KEY = CASE WHEN CT2.CT2_LP = '520' THEN E5.E5_FILIAL + E5.E5_TIPODOC + E5.E5_PREFIXO + E5.E5_NUMERO + E5.E5_PARCELA + E5.E5_TIPO + E5.E5_DATA + E5.E5_CLIFOR + E5.E5_LOJA + E5.E5_SEQ ELSE E5.E5_FILIAL + E5.E5_PREFIXO + E5.E5_NUMERO + E5.E5_PARCELA + E5.E5_TIPO END  AND 
			CT2.CT2_DATA = E5.E5_DATA AND 
			CT2.D_E_L_E_T_ = ''
		GROUP BY CT2.CT2_DATA ,CT2.CT2_CREDIT
	) BAIXA_CONTABIL 
WHERE 
	E5.E5_TIPO = 'NF' AND 
	E5.E5_DATA BETWEEN '20210501' AND '20210531' AND 
	E5.E5_RECPAG = 'R' AND 
	E5.E5_MOTBX IN('NOR','LIQ') AND
	E5.E5_TIPODOC IN('DC','VL') AND
	E5.D_E_L_E_T_ = ''
GROUP BY E5.E5_FILIAL,E5.E5_NUMERO,E5.E5_PREFIXO,E5.E5_DATA,E5.E5_PARCELA,BAIXA_CONTABIL.CT2_VALOR
ORDER BY E5.E5_FILIAL,E5.E5_NUMERO,E5.E5_DATA,E5.E5_PARCELA

-- SALDO FECHAMENTO 


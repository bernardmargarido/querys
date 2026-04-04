
-- FATURAS
SELECT 
	recno,
	identificador,
	posicao
FROM (
SELECT 
	recno,
	identificador,
	 ROW_NUMBER() OVER (
						PARTITION BY identificador
						ORDER BY (recno)
					) as posicao
FROM 
	TMS_FATURAS
) FATURAS
WHERE 
	identificador <> '' and 
	identificador <> 'NULL' and
	posicao > 1

-- CTES FATURA
SELECT 
	recno,
	cte_chave,
	posicao
FROM (
SELECT 
	recno,
	cte_chave,
	 ROW_NUMBER() OVER (
						PARTITION BY cte_chave
						ORDER BY (recno)
					) as posicao
FROM 
	TMS_FATURA_CTES
) FATURA_CTES 
WHERE 
	cte_chave <> '' and 
	cte_chave <> 'NULL' and
	posicao > 1
	

-- NOTAS
SELECT 
	recno,
	nota_chave,
	posicao
FROM (
SELECT 
	recno,
	nota_chave,
	 ROW_NUMBER() OVER (
						PARTITION BY nota_chave
						ORDER BY (recno)
					) as posicao
FROM 
	TMS_NOTAS
) NOTAS 
WHERE 
	nota_chave <> '' and 
	nota_chave <> 'NULL' and
	posicao > 1

-- OCORRENCIAS
SELECT 
	recno,
	documento_chave,
	posicao
FROM (
SELECT 
	recno,
	documento_chave,
	 ROW_NUMBER() OVER (
						PARTITION BY documento_chave, ocorrencia_codigo
						ORDER BY (recno)
					) as posicao
FROM 
	TMS_OCORRENCIA
) OCORRENCIA 
WHERE 
	documento_chave <> '' and 
	documento_chave <> 'NULL' and
	posicao > 1

-- PRE CTE
SELECT 
	recno,
	identificador,
	documento_numero
FROM (
SELECT 
	recno,
	identificador,
	documento_numero,
	 ROW_NUMBER() OVER (
						PARTITION BY identificador, documento_numero
						ORDER BY (recno)
					) as posicao
FROM 
	TMS_PRE_CTE
) PRE_CTE 
WHERE 
	posicao > 1

-- PRE CTE NOTAS
SELECT 
	recno,
	identificador_pre_cte,
	nota_fiscal_chave
FROM (
SELECT 
	recno,
	identificador_pre_cte,
	nota_fiscal_chave,
	 ROW_NUMBER() OVER (
						PARTITION BY nota_fiscal_chave
						ORDER BY (recno)
					) as posicao
FROM 
	TMS_PRE_CTE_NOTAS
) PRE_CTE_NOTAS 
WHERE 
	posicao > 1


-- coletas
SELECT 
	recno,
	identificador,
	coleta_numero,
	nota_fiscal_chave
FROM (
SELECT 
	recno,
	identificador,
	coleta_numero,
	nota_fiscal_chave,
	 ROW_NUMBER() OVER (
						PARTITION BY identificador,coleta_numero
						ORDER BY (recno)
					) as posicao
FROM 
	TMS_COLETA
) COLETA 
WHERE 
	nota_fiscal_chave <> '' and 
	nota_fiscal_chave <> 'NULL' and
	posicao > 1


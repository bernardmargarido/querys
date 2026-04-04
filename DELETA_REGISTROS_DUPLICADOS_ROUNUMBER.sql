DELETE  
	CONHECIMENTO
FROM (
SELECT 
	recno,
	documento_chave,
	 ROW_NUMBER() OVER (
						PARTITION BY documento_chave
						ORDER BY (recno)
					) as posicao
FROM 
	TMS_CONHECIMENTO
) CONHECIMENTO
WHERE 
	documento_chave <> '' and 
	documento_chave <> 'NULL' and
	posicao > 1


DELETE 
	CONHECIMENTO_NOTAS
FROM (
SELECT 
	recno,
	nota_fiscal_chave,
	 ROW_NUMBER() OVER (
						PARTITION BY nota_fiscal_chave
						ORDER BY (recno)
					) as posicao
FROM 
	TMS_CONHECIMENTO_NOTAS
) CONHECIMENTO_NOTAS 
WHERE 
	nota_fiscal_chave <> '' and 
	nota_fiscal_chave <> 'NULL' and
	posicao > 1


DELETE 
	FATURAS
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


DELETE 
	FATURA_CTES
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


DELETE 
	NOTAS
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


DELETE
	OCORRENCIA
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


DELETE 
	PRE_CTE
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


DELETE 
	PRE_CTE_NOTAS
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
DELETE 
	COLETAS
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
) COLETAS 
WHERE 
	nota_fiscal_chave <> '' and 
	nota_fiscal_chave <> 'NULL' and
	posicao > 1


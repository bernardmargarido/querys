SELECT
	VENDEDOR,
	NOME_VENDEDOR,
	COALESCE([01],0) JANEIRO,
	COALESCE([02],0) FEVEREIRO,
	COALESCE([03],0) MAR�O,
	COALESCE([04],0) ABRIL,
	COALESCE([05],0) MAIO,
	COALESCE([06],0) JUNHO,
	COALESCE([07],0) JULHO,
	COALESCE([08],0) AGOSTO,
	COALESCE([09],0) SETEMBRO,
	COALESCE([10],0) OUTUBRO,
	COALESCE([11],0) NOVEMBRO,
	COALESCE([12],0) DEZEMBRO
FROM 
(
	SELECT 
		ZZW_CODUSR VENDEDOR,
		ZZW_NOME NOME_VENDEDOR,
		SUBSTRING(ZZW_MESANO,1,2) MES,
		CASE 
			WHEN ZZW_BENEF = '1' THEN
				1
			ELSE 
				0
		END VIDA
	FROM 
		ZZW040 
	WHERE 
		ZZW_FILIAL = '' AND 
		SUBSTRING(ZZW_MESANO,1,2) BETWEEN '01' AND '12' AND 
		SUBSTRING(ZZW_MESANO,3,4) BETWEEN '2022' AND '2022' AND  
		D_E_L_E_T_ = ''
	GROUP BY ZZW_CODUSR,ZZW_NOME, SUBSTRING(ZZW_MESANO,1,2) ,ZZW_BENEF
)COMISSAO 
	PIVOT ( SUM( VIDA) FOR MES IN([01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12]) )  TOTAL_VIDAS
ORDER BY NOME_VENDEDOR

SELECT * FROM SA3040 WHERE A3_COD = '000187' AND D_E_L_E_T_ = ''
SELECT 
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
		COUNT(TTAT_DTIME) TOTAL,
		SUBSTRING(CONVERT(varchar,TTAT_DTIME,103),4,2) MES
	FROM 
		SA1040_TTAT_LOG 
	WHERE 
		TTAT_USER IN('caique.santos','josy') AND 
		TTAT_DELET = ''
	GROUP BY SUBSTRING(CONVERT(varchar,TTAT_DTIME,103),4,2)
)CLIENTES
PIVOT ( MAX(TOTAL) 
FOR MES IN([01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12]) ) ALTERACOES
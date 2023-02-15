SELECT 
	UA.UA_NUM, 
	UA.UA_EMISSAO,
	COALESCE(C5.C5_NUM,'') C5_NUM,
	COALESCE(C5.C5_NOTA,'') C5_NOTA,
	COALESCE(C5.C5_SERIE,'')C5_SERIE,
	SUM(UB.UB_QUANT) QTD_TOTAL,
	SUM(UB.UB_VLRITEM) TOTAL_ORC
FROM 
	SUA040 UA (NOLOCK)
	INNER JOIN SUB040 UB (NOLOCK) ON UB.UB_FILIAL = UA.UA_FILIAL AND UB.UB_NUM = UA.UA_NUM AND UB.D_E_L_E_T_ = ''
	LEFT JOIN SC5040 C5 (NOLOCK) ON C5.C5_FILIAL = UA.UA_FILIAL AND C5.C5_NUM = UA.UA_NUMSC5 AND C5.D_E_L_E_T_ = ''
WHERE 
	UA.UA_FILIAL = '0404' AND 
	UA.UA_EMISSAO BETWEEN '20210930' AND '20211029' AND 
	UA.D_E_L_E_T_ = ''
GROUP BY UA.UA_NUM,UA.UA_EMISSAO,C5.C5_NUM,C5.C5_NOTA,C5.C5_SERIE,UA.UA_CANC
ORDER BY UA.UA_NUM
-- FOR XML EXPLICIT
SELECT 
	1 AS TAG,
	NULL AS PARENT,
	RTRIM(B1.B1_COD) AS [produto!1!CodPrd!ELEMENT],
	RTRIM(B1.B1_DESC) AS [produto!2!DescPrd!ELEMENT]
FROM 
	SB1010 B1
WHERE
	B1.B1_MSEXP = '' AND 
	B1.B1_MSBLQL = '2' AND 
	B1.D_E_L_E_T_ = '' 
FOR XML EXPLICIT

-- FOR XML PATH
SELECT 
	RTRIM(B1.B1_COD) AS [CodPrd],
	RTRIM(B1.B1_DESC) AS [DescPrd]
FROM 
	SB1010 B1
WHERE
	B1.B1_MSEXP = '' AND 
	B1.B1_MSBLQL = '2' AND 
	B1.D_E_L_E_T_ = '' 
FOR XML PATH('Produto'), ROOT('Produtos')

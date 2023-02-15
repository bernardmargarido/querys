
-- Categoria
UPDATE
	AY0010
SET
	AY0_MSEXP = '',
	AY0_ENVECO = '1' 
WHERE
D_E_L_E_T_ = '' 

-- Marcas
UPDATE
	AY2010 
SET
	AY2_MSEXP = '',
	AY2_ENVECO = '1' 
	WHERE
D_E_L_E_T_ = '' 

-- Produto Pai
UPDATE
	WS5010
SET
	WS5_ENVECO = '1', 
	WS5_ENVCAT = '1' 
WHERE 
	WS5_USAECO = 'S' AND 
	D_E_L_E_T_ = '' 

-- SKU
UPDATE
	SB1010
SET
 B1_XENVECO = '1'
WHERE 
 D_E_L_E_T_ = ''

 -- Filtros
UPDATE
	AY3010
SET
	AY3_MSEXP = '',
	AY3_ENVECO = '1' 
WHERE
D_E_L_E_T_ = '' 

-- Filtros X  Produtos
UPDATE
	AY5010
SET
	AY5_MSEXP = '', 
	AY5_ENVECO = '1' 
WHERE
D_E_L_E_T_ = ''

-- Estoque 
UPDATE
	SB2010
SET
	B2_MSEXP = '' 
WHERE
D_E_L_E_T_ = '' 

CREATE TABLE TMS_PRE_CTE_NOTAS
(
	recno_pre_cte int,
	identificador_pre_cte char(10),
	recno INT IDENTITY,
	nota_fiscal_emissor char(14),
	nota_fiscal_numero char(9),
	nota_fiscal_serie char(3),
	nota_fiscal_chave char(44),
	nota_fiscal_data_emissao date,
	nota_fiscal_peso float(12),
	nota_fiscal_peso_calculado float(12),
	nota_fiscal_m3 float(8),
	nota_fiscal_volumes int,
	nota_fiscal_km int,
	nota_valor float(16)

)
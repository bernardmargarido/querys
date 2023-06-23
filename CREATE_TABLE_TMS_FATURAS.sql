CREATE TABLE TMS_FATURAS
(
	recno INT IDENTITY,
	identificador char(10),
	transportador_cnpj_cpf char(14),
	pagador_cnpj_cpf char(14),
	fatura_numero char(9),
	fatura_serie char(3),
	fatura_tipo char(1),
	fatura_emissao date,
	fatura_vencimento date,
	fatura_cancelamento char(1),
	fatura_observacao text,
	fatura_quantidade_ctes int,
	fatura_aprovacao date,
	fatura_usuario_aprovacao varchar(100),
	prestacao_total_prestacao float(14),
	prestacao_total_acrescimo float(14),
	prestacao_total_desconto float(14),
	prestacao_total_imposto float(14),
	prestacao_total_liquido float(14)	
)
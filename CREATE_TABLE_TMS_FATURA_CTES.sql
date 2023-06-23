CREATE TABLE TMS_FATURA_CTES
(
	recno INT IDENTITY,
	recno_fatura int,
	identificador_fatura char(10),
	cte_emissor char(14),
	cte_numero char(9),
	cte_serie char(3),
	cte_tipo varchar(30),
	cte_emissao date,
	cte_chave char(44),
	cte_autorizado date,
	cte_protocolo varchar(60),
	cte_cancelamento char(1),
	cte_observacao varchar(MAX) 	
)
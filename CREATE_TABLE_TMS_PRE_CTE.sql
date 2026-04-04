USE [LABOR-BI]
GO

/****** Object:  Table [dbo].[TMS_PRE_CTE]    Script Date: 16/11/2023 11:11:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_PRE_CTE](
	[recno] [int] IDENTITY(1,1) NOT NULL,
	[identificador] [char](10) NULL,
	[remetente_cnpj_cpf] [char](14) NULL,
	[destinatario_cnpj_cpf] [char](14) NULL,
	[pagador_cnpj_cpf] [char](14) NULL,
	[transportador_cnpj_cpf] [char](14) NULL,
	[romaneio_numero] [char](10) NULL,
	[romaneio_tipo] [char](1) NULL,
	[romaneio_motorista_nome] [varchar](100) NULL,
	[romaneio_motorista_rg_cpf] [char](14) NULL,
	[romaneio_motorista_celular] [char](15) NULL,
	[romaneio_placa_tracao] [char](8) NULL,
	[romaneio_placa_tracao_2] [char](8) NULL,
	[romaneio_placa_carreta] [char](8) NULL,
	[romaneio_placa_carreta_2] [char](8) NULL,
	[romaneio_placa_carreta_3] [char](8) NULL,
	[documento_numero] [char](9) NULL,
	[documento_tipo] [varchar](30) NULL,
	[documento_saida] [date] NULL,
	[documento_saida_hora] [char](5) NULL,
	[documento_previsao] [date] NULL,
	[documento_previsao_hora] [char](5) NULL,
	[documento_total_quantidade_nf] [int] NULL,
	[documento_total_peso] [real] NULL,
	[documento_total_peso_calculado] [real] NULL,
	[documento_total_m3] [real] NULL,
	[documento_total_volumes] [int] NULL,
	[documento_total_km] [int] NULL,
	[documento_total_valor] [real] NULL,
	[coleta_numero] [char](10) NULL,
	[coleta_pre_coleta] [char](10) NULL,
	[origem_ibge] [char](7) NULL,
	[origem_uf] [char](2) NULL,
	[origem_cidade] [varchar](60) NULL,
	[origem_regiao] [varchar](15) NULL,
	[destino_ibge] [char](7) NULL,
	[destino_uf] [char](2) NULL,
	[destino_cidade] [varchar](60) NULL,
	[destino_regiao] [varchar](15) NULL,
	[prestacao_cfop] [char](4) NULL,
	[prestacao_valor_prestacao] [real] NULL,
	[prestacao_total_frete] [real] NULL,
	[prestacao_conciliacao_valor] [real] NULL,
	[prestacao_imposto_tipo] [varchar](10) NULL,
	[prestacao_imposto_base] [real] NULL,
	[prestacao_imposto_aliquota] [real] NULL,
	[prestacao_imposto_valor] [real] NULL,
	[prestacao_imposto_desconto] [real] NULL
) ON [PRIMARY]
GO



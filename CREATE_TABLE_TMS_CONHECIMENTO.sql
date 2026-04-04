USE [LABOR-BI]
GO

/****** Object:  Table [dbo].[TMS_CONHECIMENTO]    Script Date: 16/11/2023 11:08:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_CONHECIMENTO](
	[recno] [int] IDENTITY(1,1) NOT NULL,
	[identificador] [char](10) NULL,
	[remetente_cnpj_cpf] [char](14) NULL,
	[destinatario_cnpj_cpf] [char](14) NULL,
	[pagador_cnpj_cpf] [char](14) NULL,
	[transportador_cnpj_cpf] [char](14) NULL,
	[documento_numero] [char](9) NULL,
	[documento_serie] [char](3) NULL,
	[documento_tipo] [varchar](30) NULL,
	[documento_emissao] [date] NULL,
	[documento_chave] [char](44) NULL,
	[documento_autorizado] [date] NULL,
	[documento_protocolo] [varchar](60) NULL,
	[documento_cancelamento] [char](1) NULL,
	[documento_ciencia_cancelamento] [date] NULL,
	[documento_usuario_ciencia] [varchar](100) NULL,
	[documento_aprovacao] [date] NULL,
	[documento_usuario_aprovacao] [varchar](100) NULL,
	[documento_observacao] [text] NULL,
	[documento_modelo] [varchar](15) NULL,
	[fatura_transportador_cnpj_cpf] [char](14) NULL,
	[fatura_transportador_razao_social] [varchar](100) NULL,
	[fatura_fatura] [char](15) NULL,
	[fatura_tipo] [char](1) NULL,
	[fatura_emissao] [date] NULL,
	[fatura_vencimento] [date] NULL,
	[fatura_total_prestacao] [real] NULL,
	[fatura_total_acrescimo] [real] NULL,
	[fatura_total_desconto] [real] NULL,
	[fatura_total_imposto] [real] NULL,
	[fatura_total_liquido] [real] NULL,
	[origem_ibge] [char](7) NULL,
	[origem_uf] [char](2) NULL,
	[origem_cidade] [varchar](60) NULL,
	[origem_regiao] [varchar](15) NULL,
	[destino_ibge] [char](7) NULL,
	[destino_uf] [char](2) NULL,
	[destino_cidade] [varchar](60) NULL,
	[destino_regiao] [varchar](15) NULL,
	[carga_quantidade_notas] [int] NULL,
	[carga_volumes] [int] NULL,
	[carga_peso_calculado] [real] NULL,
	[carga_m3] [real] NULL,
	[carga_valor] [real] NULL,
	[prestacao_cfop] [char](4) NULL,
	[prestacao_valor_prestacao] [real] NULL,
	[prestacao_total_frete] [real] NULL,
	[prestacao_conciliacao_valor] [real] NULL,
	[prestacao_imposto_tipo] [varchar](10) NULL,
	[prestacao_imposto_base] [real] NULL,
	[prestacao_imposto_aliquota] [real] NULL,
	[prestacao_imposto_valor] [real] NULL,
	[prestacao_imposto_desconto] [real] NULL,
	[pre_cte_numero] [varchar](10) NULL,
	[pre_cte_valor_prestacao] [real] NULL,
	[pre_cte_total_frete] [real] NULL,
	[pre_cte_divergencia_valor] [real] NULL,
	[pre_cte_conciliacao_valor] [real] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



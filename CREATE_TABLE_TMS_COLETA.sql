USE [LABOR-BI]
GO

/****** Object:  Table [dbo].[TMS_COLETA]    Script Date: 16/11/2023 11:07:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_COLETA](
	[recno] [int] IDENTITY(1,1) NOT NULL,
	[identificador] [char](10) NULL,
	[remetente_cnpj_cpf] [char](14) NULL,
	[destinatario_cnpj_cpf] [char](14) NULL,
	[pagador_cnpj_cpf] [char](14) NULL,
	[transportador_cnpj_cpf] [char](14) NULL,
	[coleta_numero] [char](10) NULL,
	[coleta_pre_coleta] [char](10) NULL,
	[coleta_tipo] [char](1) NULL,
	[coleta_cif_fob] [char](1) NULL,
	[coleta_peso_calculado] [real] NULL,
	[coleta_m3] [real] NULL,
	[coleta_volumes] [int] NULL,
	[coleta_valor] [real] NULL,
	[coleta_contato] [varchar](60) NULL,
	[coleta_contato_email] [varchar](100) NULL,
	[coleta_contato_fone] [char](15) NULL,
	[coleta_contato_departamento] [varchar](60) NULL,
	[coleta_agendamento] [date] NULL,
	[coleta_agendamento_hora_inicial] [char](5) NULL,
	[coleta_agendamento_hora_final] [char](5) NULL,
	[coleta_motivo] [varchar](100) NULL,
	[coleta_retirada] [date] NULL,
	[coleta_retirada_hora_inicial] [char](5) NULL,
	[coleta_retirada_hora_final] [char](5) NULL,
	[coleta_devolucao] [date] NULL,
	[coleta_devolucao_hora_inicial] [char](5) NULL,
	[coleta_devolucao_hora_final] [char](5) NULL,
	[coleta_cancelamento] [char](1) NULL,
	[coleta_observacao] [text] NULL,
	[coleta_coletado] [date] NULL,
	[coleta_coletado_hora] [char](5) NULL,
	[origem_cep] [char](8) NULL,
	[origem_endereco] [varchar](100) NULL,
	[origem_numero] [char](10) NULL,
	[origem_complemento] [varchar](100) NULL,
	[origem_bairro] [varchar](60) NULL,
	[origem_ibge] [char](7) NULL,
	[origem_uf] [char](2) NULL,
	[origem_cidade] [varchar](60) NULL,
	[origem_regiao] [varchar](15) NULL,
	[destino_cep] [char](8) NULL,
	[destino_endereco] [varchar](100) NULL,
	[destino_numero] [char](10) NULL,
	[destino_complemento] [varchar](100) NULL,
	[destino_bairro] [varchar](60) NULL,
	[destino_ibge] [char](7) NULL,
	[destino_uf] [char](2) NULL,
	[destino_cidade] [varchar](60) NULL,
	[destino_regiao] [varchar](15) NULL,
	[nota_fiscal_emissor] [char](14) NULL,
	[nota_fiscal_numero] [char](9) NULL,
	[nota_fiscal_serie] [char](3) NULL,
	[nota_fiscal_chave] [char](44) NULL,
	[nota_fiscal_data_emissao] [date] NULL,
	[nota_fiscal_peso] [real] NULL,
	[nota_fiscal_peso_calculado] [real] NULL,
	[nota_fiscal_m3] [real] NULL,
	[nota_fiscal_volumes] [int] NULL,
	[nota_valor] [real] NULL,
	[transporte_coleta] [varchar](100) NULL,
	[transporte_motorista] [varchar](100) NULL,
	[transporte_rg_cpg] [char](30) NULL,
	[transporte_veiculo] [text] NULL,
	[transporte_observacao] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



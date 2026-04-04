USE [LABOR-BI]
GO

/****** Object:  Table [dbo].[TMS_OCORRENCIA]    Script Date: 16/11/2023 11:10:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_OCORRENCIA](
	[recno] [int] IDENTITY(1,1) NOT NULL,
	[identificador] [char](10) NULL,
	[remetente_cnpj_cpf] [char](14) NULL,
	[transportador_cnpj_cpf] [char](14) NULL,
	[documento_tipo] [varchar](15) NULL,
	[documento_numero] [char](9) NULL,
	[documento_serie] [char](3) NULL,
	[documento_emissao] [date] NULL,
	[documento_chave] [char](44) NULL,
	[ocorrencia_codigo] [char](3) NULL,
	[ocorrencia_descricao] [varchar](100) NULL,
	[ocorrencia_ocorreu_data] [date] NULL,
	[ocorrencia_ocorreu_hora] [char](5) NULL,
	[ocorrencia_solucao_data] [date] NULL,
	[ocorrencia_solucao_hora] [char](5) NULL,
	[ocorrencia_solucao_responsavel] [varchar](100) NULL,
	[ocorrencia_cancelada] [char](1) NULL,
	[ocorrencia_observacao] [text] NULL,
	[ocorrencia_origem_informacao] [varchar](60) NULL,
	[ocorrencia_responsavel] [varchar](60) NULL,
	[ocorrencia_responsavel_interessado_nome] [varchar](100) NULL,
	[ocorrencia_responsavel_interessado_documento] [varchar](14) NULL,
	[ocorrencia_responsavel_contato] [varchar](100) NULL,
	[tipo_entrega] [char](1) NULL,
	[tipo_indica_problema] [char](1) NULL,
	[tipo_agendamento] [char](1) NULL,
	[tipo_necessita_interacao] [char](1) NULL,
	[tipo_permite_calculo] [char](1) NULL,
	[ocorrencia_justifica_atraso] [char](1) NULL,
	[ocorrencia_dataprevisao_cliente] [date] NULL,
	[ocorrencia_dataprevisao_transportador] [date] NULL,
	[ocorrencia_usuario_cancelamento] [varchar](100) NULL,
	[ocorrencia_motivo_cancelamento] [varchar](150) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



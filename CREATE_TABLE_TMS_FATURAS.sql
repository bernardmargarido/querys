USE [LABOR-BI]
GO

/****** Object:  Table [dbo].[TMS_FATURAS]    Script Date: 16/11/2023 11:09:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_FATURAS](
	[recno] [int] IDENTITY(1,1) NOT NULL,
	[identificador] [char](10) NULL,
	[transportador_cnpj_cpf] [char](14) NULL,
	[pagador_cnpj_cpf] [char](14) NULL,
	[fatura_numero] [char](9) NULL,
	[fatura_serie] [char](3) NULL,
	[fatura_tipo] [char](1) NULL,
	[fatura_emissao] [date] NULL,
	[fatura_vencimento] [date] NULL,
	[fatura_cancelamento] [char](1) NULL,
	[fatura_observacao] [text] NULL,
	[fatura_quantidade_ctes] [int] NULL,
	[fatura_aprovacao] [date] NULL,
	[fatura_usuario_aprovacao] [varchar](100) NULL,
	[prestacao_total_prestacao] [real] NULL,
	[prestacao_total_acrescimo] [real] NULL,
	[prestacao_total_desconto] [real] NULL,
	[prestacao_total_imposto] [real] NULL,
	[prestacao_total_liquido] [real] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



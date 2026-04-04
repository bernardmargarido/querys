USE [LABOR-BI]
GO

/****** Object:  Table [dbo].[TMS_CONHECIMENTO_NOTAS]    Script Date: 16/11/2023 11:09:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_CONHECIMENTO_NOTAS](
	[recno_conhecimento] [int] NULL,
	[identificador_conhecimento] [char](10) NULL,
	[recno] [int] IDENTITY(1,1) NOT NULL,
	[nota_fiscal_emissor] [char](14) NULL,
	[nota_fiscal_numero] [char](9) NULL,
	[nota_fiscal_serie] [char](3) NULL,
	[nota_fiscal_chave] [char](44) NULL,
	[nota_fiscal_data_emissao] [date] NULL,
	[nota_fiscal_peso] [real] NULL,
	[nota_fiscal_peso_calculado] [real] NULL,
	[nota_fiscal_m3] [real] NULL,
	[nota_fiscal_volumes] [int] NULL,
	[nota_valor] [real] NULL
) ON [PRIMARY]
GO



USE [LABOR-BI]
GO

/****** Object:  Table [dbo].[TMS_FATURA_CTES]    Script Date: 16/11/2023 11:09:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_FATURA_CTES](
	[recno] [int] IDENTITY(1,1) NOT NULL,
	[recno_fatura] [int] NULL,
	[identificador_fatura] [char](10) NULL,
	[cte_emissor] [char](14) NULL,
	[cte_numero] [char](9) NULL,
	[cte_serie] [char](3) NULL,
	[cte_tipo] [varchar](30) NULL,
	[cte_emissao] [date] NULL,
	[cte_chave] [char](44) NULL,
	[cte_autorizado] [date] NULL,
	[cte_protocolo] [varchar](60) NULL,
	[cte_cancelamento] [char](1) NULL,
	[cte_observacao] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



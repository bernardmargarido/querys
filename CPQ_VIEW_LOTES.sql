USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_lotes]    Script Date: 01/02/2023 14:47:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[cpq_lotes] as 
SELECT
	SB1.R_E_C_N_O_ AS productId
	,RTRIM(B1_FILIAL) AS codigoFilial
	,RTRIM(B1_COD) AS codigoErp
	,RTRIM(B1_DESC) AS descricao
	,RTRIM(B1_LOCPAD) AS armazem
	,RTRIM(SB8.B8_LOTECTL) AS lote
	,convert(varchar,convert(date,SB8.B8_DFABRIC,113),121) AS dtFabricacao
	,convert(varchar,convert(date,SB8.B8_DTVALID,113),121) AS dtValidade
	,SB8.B8_SALDO AS saldoLote
FROM [LABOR-1233]..SB8040 SB8 (NOLOCK)
INNER JOIN [LABOR-1233]..SB1040 SB1 (NOLOCK)
	ON SB1.B1_COD = SB8.B8_PRODUTO
	AND SB1.B1_TIPO = 'ME'
	AND SB1.D_E_L_E_T_ = ' '
WHERE
	SB8.B8_FILIAL = '0404' AND
	SB8.B8_LOCAL = '01' AND
	SB8.B8_SALDO > 0 AND 
	SB8.B8_MSEXP = '' AND
	SB8.D_E_L_E_T_ = ' '
GO
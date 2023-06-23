USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_estoque]    Script Date: 22/06/2023 13:53:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER view [dbo].[cpq_estoque] as 
SELECT
	cast(SB1.R_E_C_N_O_ as int) AS productId
	,RTRIM(B2_FILIAL) AS codigoFilial
	,RTRIM(B1_COD) AS codigoErp
	,RTRIM(B1_DESC) AS descricao
	,RTRIM(B1_LOCPAD) AS armazem
	,SB2.B2_CM1 AS custoProduto
	,COALESCE(CUSTO_ENTRADA.CUSTO,0) As custoEntrada
	,CASE WHEN (SB2.B2_QATU - SB2.B2_QPEDVEN - SB2.B2_RESERVA) < 0 THEN 0 ELSE (SB2.B2_QATU - SB2.B2_QPEDVEN - SB2.B2_RESERVA) END AS saldoTotal
FROM
	[LABOR12-33]..SB2040 SB2 (NOLOCK)
	INNER JOIN [LABOR12-33]..SB1040 SB1 (NOLOCK)
		ON SB1.B1_COD = SB2.B2_COD
		AND SB1.B1_TIPO = 'ME'
		AND SB1.D_E_L_E_T_ = ' '
	OUTER APPLY(
		SELECT 
			TOP 1
			D1.D1_DTDIGIT,
			D1.D1_DOC DOC,
			D1.D1_SERIE SERIE,
			D1.D1_VUNIT CUSTO 
		FROM 
			[LABOR12-33]..SD1040 D1 (NOLOCK)
		WHERE 
			D1.D1_FILIAL = SB2.B2_FILIAL AND 
			D1.D1_COD = SB2.B2_COD AND 
			D1.D1_LOCAL = SB2.B2_LOCAL AND 
			D1.D1_CF NOT IN('1907','1152','2152','2202','1202','2411','1411','1949') AND
			D1.D1_FORNECE NOT IN('017384','017980') AND 
			D1.D1_QUANT > 0 AND
			D1.D1_TIPO NOT IN('C','D') AND
			D1.D_E_L_E_T_ = ''
		GROUP BY D1.D1_DOC,D1.D1_VUNIT,D1.D1_SERIE,D1.D1_DTDIGIT
		ORDER BY D1.D1_DTDIGIT DESC
	)CUSTO_ENTRADA
WHERE
	--SB2.B2_FILIAL = '0404' AND
	SB2.B2_LOCAL = '01' AND
	SB2.B2_XCPQEXP = '' AND
	SB2.D_E_L_E_T_ = ' '
GO



USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_tabelapromocao]    Script Date: 21/06/2023 18:57:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER view [dbo].[cpq_tabelapromocao] as 
SELECT 
	Z2.Z2_FILIAL codigoFilial
	,Z2.R_E_C_N_O_ promocaoId
	,RTRIM(Z2.Z2_ITEM) itemPromocao
	,RTRIM(Z2.Z2_CODPROM) codigoPromocao
	,RTRIM(Z2.Z2_DESCPRO) descricaoPromocao
	,convert(varchar,convert(date,Z2.Z2_DTIVIGE,113),121) dataVigenciaInicio
	,convert(varchar,convert(date,Z2.Z2_DTFVIGE,113),121) dataVigenciaFim
	,cast(B1.R_E_C_N_O_ as int) productId
	,RTRIM(Z2.Z2_PRODUTO) codigoProduto
	,RTRIM(B1.B1_DESC) descricaoProduto
	,COALESCE(DA0.R_E_C_N_O_,0) tabelaId
	,RTRIM(Z2.Z2_TABELAS) codigoTabela
	,Z2.Z2_PRETAB1 precoVenda
	,Z2.Z2_PROTAB1 precoPromocao
FROM 
	[LABOR12-33]..SZ2040 Z2 
	LEFT JOIN [LABOR12-33]..DA0040 DA0 (NOLOCK) ON DA0.DA0_FILIAL = Z2.Z2_FILIAL AND DA0.DA0_CODTAB = Z2.Z2_TABELAS AND DA0.D_E_L_E_T_ = ''
	INNER JOIN [LABOR12-33]..SB1040 B1 (NOLOCK) ON B1.B1_FILIAL = '' AND B1.B1_COD = Z2.Z2_PRODUTO AND B1.D_E_L_E_T_ = ''
WHERE 
	Z2.Z2_FILIAL = '0404' AND 
	Z2.D_E_L_E_T_ = '' 
GO



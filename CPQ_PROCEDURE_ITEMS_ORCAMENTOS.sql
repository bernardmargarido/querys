USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_orcamento_items]    Script Date: 03/01/2023 15:12:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cpq_orcamento_items]
	-- Add the parameters for the stored procedure here
@FILIAL varchar(4),
@ORCAMENTO varchar(6),
@NOTA varchar(9),
@SERIE varchar(3),
@IDTABELA varchar(3)

AS
BEGIN
	IF @NOTA <> '' 
		SELECT
			idProduto,
			quantidade,
			descricao,
			valorUnitario,
			valorItem,
			precoTabela,
			custo,
			baseIpi,
			aliqIpi,
			valorIpi,
			baseIcms,
			aliqIcms,
			valorIcms,
			basePis,
			aliqPis,
			valorPis,
			baseCofins,
			aliqCofins,
			valorCofins,
			baseSolidario,
			aliqSolidario,
			valorSolidario,
			aliqIcmsComplementar,
			valorIcmsComplementar,
			valorDifal,
			valorFecpDifal,
			descZonaFranca
		FROM 
		(
			SELECT 
				B1.R_E_C_N_O_ idProduto,
				B1.B1_DESC descricao,
				D2.D2_QUANT quantidade,
				D2.D2_PRCVEN valorUnitario,
				D2.D2_TOTAL valorItem,
				D2.D2_PRUNIT precoTabela,
				D2.D2_CUSTO1 custo,
				D2.D2_BASEIPI baseIpi,
				D2.D2_IPI aliqIpi,
				D2.D2_VALIPI valorIpi,
				D2.D2_BASEICM baseIcms,
				D2.D2_PICM aliqIcms,
				D2.D2_VALICM valorIcms,
				D2.D2_BASIMP5 basePis,
				D2.D2_ALQPIS aliqPis,
				D2.D2_VALIMP5 valorPis,
				D2.D2_BASIMP6 baseCofins,
				D2.D2_ALQCOF aliqCofins,
				D2.D2_VALIMP6 valorCofins,
				0 baseSolidario,
				0 aliqSolidario,
				0 valorSolidario,
				D2.D2_ALQCPM aliqIcmsComplementar,
				D2.D2_VALCPM valorIcmsComplementar,
				D2.D2_DIFAL valorDifal,
				D2_VFCPDIF valorFecpDifal,
				0 descZonaFranca

			FROM 
				[LABOR-PROD12]..SD2040 D2 WITH(NOLOCK)
				INNER JOIN [LABOR-PROD12]..SB1040 B1 WITH(NOLOCK) ON B1.B1_FILIAL = '' AND B1.B1_COD = D2.D2_COD AND B1.D_E_L_E_T_ = ''
				INNER JOIN [LABOR-PROD12]..DA0040 DA0 WITH(NOLOCK) ON DA0.DA0_FILIAL = D2.D2_FILIAL AND DA0.R_E_C_N_O_ = @IDTABELA AND DA0.D_E_L_E_T_ = ''
				INNER JOIN [LABOR-PROD12]..DA1040 DA1 WITH(NOLOCK) ON DA1.DA1_FILIAL = DA0.DA0_FILIAL AND DA1.DA1_CODTAB = DA0.DA0_CODTAB AND DA1.DA1_CODPRO = D2.D2_COD AND DA1.D_E_L_E_T_ = ''
			WHERE
				D2.D2_FILIAL = @FILIAL AND 
				D2.D2_DOC = @NOTA AND 
				D2.D2_SERIE = @SERIE AND
				D2.D_E_L_E_T_ = ''
		)ITEMS_ORCAMENTO
	ELSE
		SELECT
			idProduto,
			quantidade,
			descricao,
			valorUnitario,
			valorItem,
			precoTabela,
			custo,
			baseIpi,
			aliqIpi,
			valorIpi,
			baseIcms,
			aliqIcms,
			valorIcms,
			basePis,
			aliqPis,
			valorPis,
			baseCofins,
			aliqCofins,
			valorCofins,
			baseSolidario,
			aliqSolidario,
			valorSolidario,
			aliqIcmsComplementar,
			valorIcmsComplementar,
			valorDifal,
			valorFecpDifal,
			descZonaFranca
		FROM 
		(
			SELECT 
				B1.R_E_C_N_O_ idProduto,
				B1.B1_DESC descricao,
				UB.UB_QUANT quantidade,
				UB.UB_VRUNIT valorUnitario,
				UB.UB_VLRITEM valorItem,
				UB.UB_PRCTAB precoTabela,
				0 custo,
				0 baseIpi,
				0 aliqIpi,
				0 valorIpi,
				0 baseIcms,
				0 aliqIcms,
				0 valorIcms,
				0 basePis,
				0 aliqPis,
				0 valorPis,
				0 baseCofins,
				0 aliqCofins,
				0 valorCofins,
				0 baseSolidario,
				0 aliqSolidario,
				0 valorSolidario,
				0 aliqIcmsComplementar,
				0 valorIcmsComplementar,
				0 valorDifal,
				0 valorFecpDifal,
				0 descZonaFranca
			FROM 
				[LABOR-PROD12]..SUB040 UB WITH(NOLOCK)
				INNER JOIN [LABOR-PROD12]..SB1040 B1 WITH(NOLOCK) ON B1.B1_FILIAL = '' AND B1.B1_COD = UB.UB_PRODUTO AND B1.D_E_L_E_T_ = ''
				INNER JOIN [LABOR-PROD12]..DA0040 DA0 WITH(NOLOCK) ON DA0.DA0_FILIAL = UB.UB_FILIAL AND DA0.R_E_C_N_O_ = @IDTABELA AND DA0.D_E_L_E_T_ = ''
				INNER JOIN [LABOR-PROD12]..DA1040 DA1 WITH(NOLOCK) ON DA1.DA1_FILIAL = DA0.DA0_FILIAL AND DA1.DA1_CODTAB = DA0.DA0_CODTAB AND DA1.DA1_CODPRO = UB.UB_PRODUTO AND DA1.D_E_L_E_T_ = ''
			WHERE
				UB.UB_FILIAL = @FILIAL AND 
				UB.UB_NUM = @ORCAMENTO AND 
				UB.D_E_L_E_T_ = ''
		)ITEMS_ORCAMENTO

END 
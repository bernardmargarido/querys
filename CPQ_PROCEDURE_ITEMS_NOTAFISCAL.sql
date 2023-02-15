USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_notasaida_items]    Script Date: 01/02/2023 16:36:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[cpq_notasaida_items]
	-- Add the parameters for the stored procedure here
@FILIAL varchar(4),
@NOTA varchar(9),
@SERIE varchar(3)

AS
BEGIN
	
	SELECT
		idProduto,
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
			[LABOR-1233]..SD2040 D2 WITH(NOLOCK)
			INNER JOIN [LABOR-1233]..SB1040 B1 WITH(NOLOCK) ON B1.B1_FILIAL = '' AND B1.B1_COD = D2.D2_COD AND B1.D_E_L_E_T_ = ''
		WHERE
			D2.D2_FILIAL = @FILIAL AND 
			D2.D2_DOC = @NOTA AND 
			D2.D2_SERIE = @SERIE AND 
			D2.D_E_L_E_T_ = ''
	)ITEMS_NOTA

END 
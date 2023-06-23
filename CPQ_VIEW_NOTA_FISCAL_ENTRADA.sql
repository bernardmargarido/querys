USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_nota_entrada]    Script Date: 15/05/2023 10:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[cpq_nota_entrada] AS

SELECT 
	Rtrim(SD1.D1_FILIAL) codigoFilial, 
	Rtrim(SD1.D1_SERIE) serie, 
	Rtrim(SD1.D1_DOC) nota,
	CASE WHEN D1_TIPO = 'N' THEN 'Nota Fiscal Entrada'  ELSE 'Complementar' END tipoDeVenda,
	SA2.R_E_C_N_O_  fornecedorId,
	Rtrim(SD1.D1_FORNECE + SD1.D1_LOJA) codigoERP,
	Rtrim(SA2.A2_NOME) razaoFornecedor,
	Rtrim(ISNULL(SC7.C7_FILIAL + SC7.C7_NUM + SC7.C7_ITEM + SD1.D1_COD,'')) idPedido,
	Rtrim(ISNULL(SC7.C7_PO_EIC, '')) poECI,
	Rtrim(ISNULL(SD1.D1_CONHEC,'')) procEIC,
	CASE WHEN ( SC7.C7_EMISSAO = '' OR SC7.C7_EMISSAO IS NULL ) THEN '' ELSE convert(varchar,convert(date,SC7.C7_EMISSAO,101),121) END dataPedido,
	Rtrim(SD1.D1_CF) cfop,
	case 
		when SC7.C7_COND is not null then SC7.C7_COND 
		else '001' 
	end idCondicao,
	Rtrim(SD1.D1_COD) codigoProduto,
	CAST(SD1.D1_EMISSAO AS DATE) dataEmissao,
	CAST(SD1.D1_DTDIGIT AS DATE) dataDigitacao,
	Rtrim(SD1.D1_TP) tipoProduto,
	SD1.D1_QUANT quantidade,
	SD1.D1_TOTAL + SD1.D1_VALFRE + SD1.D1_DESPESA + SD1.D1_VALIPI + SD1.D1_ICMSRET-SD1.D1_VALDESC valorBruto,
	SD1.D1_TOTAL  valorMercadoria,
	(SD1.D1_TOTAL + SD1.D1_VALFRE + SD1.D1_DESPESA + SD1.D1_VALIPI + SD1.D1_ICMSRET  - SD1.D1_VALDESC ) - SD1.D1_ICMSRET - SD1.D1_VALIPI - SD1.D1_VALISS  - SD1.D1_VALIMP5 - SD1.D1_VALIMP6 - SD1.D1_VALICM + SD1.D1_DESCICM  - SD1.D1_DIFAL - SD1.D1_ICMSCOM - SD1.D1_VFCPDIF  valorLiquido,
	SD1.D1_ALQIMP5 / 100 aliquotaCofins,
	SD1.D1_VALIMP5 valorCofins,
	SD1.D1_ALQIMP6 / 100 aliquotaPIS,
	SD1.D1_VALIMP6 valorPIS,
	SD1.D1_PICM / 100 aliquotaICMS,
	SD1.D1_VALICM - SD1.D1_DESCICM valorICMS,
	SD1.D1_PDDES / 100 aliquotaDifal,
	SD1.D1_DIFAL valorIcmsDifal,
	SD1.D1_ALIQCMP / 100 aliquotaIcmsComplementar,
	SD1.D1_ICMSCOM valorIcmsComplementar,
	SD1.D1_ALQFECP / 100 aliquotaFECP,
	SD1.D1_VFCPDIF valorFECP,
	SD1.D1_IPI / 100 alquiotaIPI,
	SD1.D1_VALIPI valorIPI,
	SD1.D1_ALIQISS / 100 aliquotaISS,
	SD1.D1_VALISS valorISS,
	SD1.D1_VALDESC valorDesconto,
	SD1.D1_ALIQSOL / 100 aliquotaIcmsSolidario,
	SD1.D1_ICMSRET valorIcmsSolidario,
	SD1.D1_VALFRE valorFrete,
	SD1.D1_SEGURO valorSeguro,
	SD1.D1_DESPESA valorDespesa,
	SD1.D1_CUSTO valorCusto,
	' ' as origemVenda,
	case
		when SF1.F1_TPFRETE = 'C' then 'CIF'
		when SF1.F1_TPFRETE = 'F' then 'FOB'
		else 'Retira'
	end tipoFrete,
	'NFE' tipoEntrada,
	Rtrim(SD1.D1_LOTECTL) lote,
	CAST(SD1.D1_DTVALID AS DATE) dataValidadeLote
FROM
	[LABOR-PROD12]..SD1040 SD1 with (nolock)  

	INNER JOIN [LABOR-PROD12]..SA2040 SA2 with(nolock) 
		ON SA2.D_E_L_E_T_ = ''
		AND SA2.A2_FILIAL = '  '
		AND SA2.A2_COD = SD1.D1_FORNECE
		AND SA2.A2_LOJA = SD1.D1_LOJA

	LEFT JOIN [LABOR-PROD12]..SF4040 SF4 with (nolock) 
		ON SF4.D_E_L_E_T_ = ' ' 
		and SF4.F4_FILIAL = '  '  
		and SF4.F4_CODIGO = SD1.D1_TES  
		AND SF4.F4_ESTOQUE = 'S'

	INNER JOIN [LABOR-PROD12]..SF1040 SF1 with (nolock) 
		on SF1.D_E_L_E_T_ = ' ' 
		and SF1.F1_FILIAL = SD1.D1_FILIAL 
		and SF1.F1_DOC = SD1.D1_DOC 
		and SF1.F1_SERIE = SD1.D1_SERIE
		and SF1.F1_FORNECE = SD1.D1_FORNECE 
		and SF1.F1_EMISSAO = SD1.D1_EMISSAO

	LEFT JOIN [LABOR-PROD12]..SC7040 SC7 (nolock)
		ON  SC7.D_E_L_E_T_ = ''
		and SC7.C7_NUM = SD1.D1_PEDIDO
		and SC7.C7_FORNECE = SD1.D1_FORNECE
		and SC7.C7_LOJA = SD1.D1_LOJA 
		AND SC7.C7_ITEM = SD1.D1_ITEMPC
WHERE
	SD1.D_E_L_E_T_ = ' '  
	AND SD1.D1_FILIAL BETWEEN '  ' AND 'ZZZZ'
	AND SD1.D1_DTDIGIT >= '20170101' 
	--AND SD1.D1_DTDIGIT BETWEEN '20230101' AND '20230102'  
	AND SD1.D1_TIPO IN ('N','C') 

GO



USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_caixas]    Script Date: 25/07/2022 14:05:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[cpq_metasvendas] as 

SELECT 
	codigoFilial
	,vendedorId
	,codigoVendedor
	,nomeVendedor
	,COALESCE([01], 0) janeiro
	,COALESCE([02], 0) fevereiro
	,COALESCE([03], 0) março
	,COALESCE([04], 0) abril
	,COALESCE([05], 0) maio
	,COALESCE([06], 0) junho
	,COALESCE([07], 0) julho
	,COALESCE([08], 0) agosto
	,COALESCE([09], 0) setembro
	,COALESCE([10], 0) outubro
	,COALESCE([11], 0) novembro
	,COALESCE([12], 0) dezembro 
FROM
(
	SELECT 
		 CT.CT_FILIAL codigoFilial
		, SUBSTRING(CT.CT_DATA,5,2) mesMeta 
		, A3.R_E_C_N_O_ vendedorId
		, CT.CT_VEND codigoVendedor
		, A3.A3_NOME nomeVendedor
		, SUM(CT.CT_VALOR) valorMeta 
	FROM 
		[LABOR-PROD12]..SCT040 CT (NOLOCK)
		INNER JOIN [LABOR-PROD12]..SA3040 A3 (NOLOCK) ON A3.A3_FILIAL = '' AND A3.A3_COD = CT.CT_VEND AND A3.D_E_L_E_T_ = ''
	WHERE
		CT.CT_FILIAL = '' 
		AND SUBSTRING(CT.CT_DATA,1,4) =  SUBSTRING(CONVERT(varchar,GETDATE(),112),1,4)
		AND CT.D_E_L_E_T_ = ''
	GROUP BY  CT.CT_FILIAL,SUBSTRING(CT.CT_DATA,5,2), A3.R_E_C_N_O_ , CT.CT_VEND, A3.A3_NOME
) METAS_VENDAS
PIVOT( SUM(valorMeta) 
		FOR mesMeta IN ([01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12]) ) METAS

GO



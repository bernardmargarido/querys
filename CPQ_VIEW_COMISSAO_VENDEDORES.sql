USE [GATEWAY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[cpq_comissao_vendedores] AS

SELECT 
	codigoFilial,
	vendedorId,
	codigoERP,
	nomeVendedor,
	tipoVendedor,
	valorComissao
FROM (
	-- INTERNO 
	SELECT
		A3.A3_FILIAL codigoFilial,
		A3.R_E_C_N_O_ vendedorId,
		A3.A3_COD codigoERP,
		A3.A3_NOME nomeVendedor,
		case	
			when A3.A3_TIPO = 'I' then 'Interno'  
			when A3.A3_TIPO = 'E' then 'Externo' 
		else 
			'indefinido'
		end tipoVendedor,
		COMISSAO_INTERNO.COMISSAO valorComissao
	FROM 
		[LABOR-PROD12]..SA3040 A3 
		CROSS APPLY( 
			SELECT 
				ZZW.ZZW_VLRCOT COMISSAO
			FROM 
				[LABOR-PROD12]..ZZW040 ZZW 
			WHERE 
				ZZW.ZZW_FILIAL = '    ' AND 
				ZZW.ZZW_CODUSR = A3.A3_COD AND 
				ZZW.ZZW_MESANO = '122022' AND 
				ZZW.D_E_L_E_T_ = ''
		)COMISSAO_INTERNO
	WHERE 
		A3.A3_FILIAL = '    ' AND 
		A3.A3_MSBLQL < > '1' AND
		A3.A3_TIPO = 'I' AND 
		A3.D_E_L_E_T_ = '' 
	
	UNION ALL

	-- EXTERNO
	SELECT
		A3.A3_FILIAL codigoFilial,
		A3.R_E_C_N_O_ vendedorId,
		A3.A3_COD codigoERP,
		A3.A3_NOME nomeVendedor,
		case	
			when A3.A3_TIPO = 'I' then 'Interno'  
			when A3.A3_TIPO = 'E' then 'Externo' 
		else 
			'indefinido'
		end tipoVendedor,
		COMISSAO_EXTERNO.COMISSAO valorComissao
	FROM 
		[LABOR-PROD12]..SA3040 A3 
		CROSS APPLY( 
			SELECT 
				E3.E3_VEND,
				SUM(E3_COMIS) COMISSAO
			FROM 
				[LABOR-PROD12]..SE3040 E3 
			WHERE 
				E3.E3_FILIAL = '0404' AND 
				E3.E3_VEND = A3.A3_COD AND 
				E3.E3_EMISSAO BETWEEN '20221201' AND '20221231' AND 
				E3.D_E_L_E_T_ = ''
			GROUP BY E3.E3_VEND
		) COMISSAO_EXTERNO 
	WHERE 
		A3.A3_FILIAL = '    ' AND 
		A3.A3_MSBLQL < > '1' AND
		A3.A3_TIPO = 'E' AND 
		A3.D_E_L_E_T_ = '' 
) COMISSAO_VENDEDORES
--ORDER BY codigoERP

GO

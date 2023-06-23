USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_comissao_vendedores]    Script Date: 19/05/2023 12:18:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[cpq_comissao_vendedores]
	-- Add the parameters for the stored procedure here

@IDVENDEDOR int,
@MES_ANO varchar(10),
@DATA_DE varchar(10),
@DATA_ATE varchar(10)

AS
BEGIN
	
	-- Preeenche as variaveis de data 
	SET @DATA_DE = ( SELECT Z4.Z4_DTINI FROM [LABOR-1233]..SZ4040 Z4 WHERE Z4.Z4_FILIAL = '' AND Z4.Z4_ANO = SUBSTRING(@MES_ANO,3,4) AND Z4.Z4_MES = SUBSTRING(@MES_ANO,1,2) AND Z4.D_E_L_E_T_ = '')
	SET @DATA_ATE= ( SELECT Z4.Z4_DTFIM FROM [LABOR-1233]..SZ4040 Z4 WHERE Z4.Z4_FILIAL = '' AND Z4.Z4_ANO = SUBSTRING(@MES_ANO,3,4) AND Z4.Z4_MES = SUBSTRING(@MES_ANO,1,2) AND Z4.D_E_L_E_T_ = '')

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
			RTrim(A3.A3_FILIAL) codigoFilial,
			A3.R_E_C_N_O_ vendedorId,
			RTrim(A3.A3_COD) codigoERP,
			RTrim(A3.A3_NOME) nomeVendedor,
			case	
				when A3.A3_TIPO = 'I' then 'Interno'  
				when A3.A3_TIPO = 'E' then 'Externo' 
			else 
				'indefinido'
			end tipoVendedor,
			COMISSAO_INTERNO.COMISSAO valorComissao
		FROM 
			[LABOR-1233]..SA3040 A3 
			CROSS APPLY( 
				SELECT 
					ZZW.ZZW_VLRCOT COMISSAO
				FROM 
					[LABOR-1233]..ZZW040 ZZW 
				WHERE 
					ZZW.ZZW_FILIAL = '    ' AND 
					ZZW.ZZW_CODUSR = A3.A3_COD AND 
					ZZW.ZZW_MESANO = @MES_ANO AND 
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
			RTrim(A3.A3_FILIAL) codigoFilial,
			A3.R_E_C_N_O_ vendedorId,
			RTrim(A3.A3_COD) codigoERP,
			RTrim(A3.A3_NOME) nomeVendedor,
			case	
				when A3.A3_TIPO = 'I' then 'Interno'  
				when A3.A3_TIPO = 'E' then 'Externo' 
			else 
				'indefinido'
			end tipoVendedor,
			COMISSAO_EXTERNO.COMISSAO valorComissao
		FROM 
			[LABOR-1233]..SA3040 A3 
			CROSS APPLY( 
				SELECT 
					E3.E3_VEND,
					SUM(E3_COMIS) COMISSAO
				FROM 
					[LABOR-1233]..SE3040 E3 
				WHERE 
					E3.E3_FILIAL = '0404' AND 
					E3.E3_VEND = A3.A3_COD AND 
					E3.E3_EMISSAO BETWEEN @DATA_DE AND @DATA_ATE AND 
					E3.D_E_L_E_T_ = ''
				GROUP BY E3.E3_VEND
			) COMISSAO_EXTERNO 
		WHERE 
			A3.A3_FILIAL = '    ' AND 
			A3.A3_MSBLQL < > '1' AND
			A3.A3_TIPO = 'E' AND 
			A3.D_E_L_E_T_ = '' 
	) COMISSAO_VENDEDORES

END

--exec dbo.cpq_comissao_vendedores 3,'122022','',''
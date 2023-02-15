USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_tabela_preco]    Script Date: 21/07/2022 18:51:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[cpq_tabela_preco] as 
SELECT 
	DA0.R_E_C_N_O_ tabelaId
	,RTRIM(DA0.DA0_CODTAB) codigoErp
	,RTRIM(DA0.DA0_DESCRI) descricao
	,CASE 
		WHEN DA0.DA0_ATIVO = '1' THEN 
			'ativo'
		ELSE 
			'inativo'
	END ativo
FROM 
	[LABOR-PROD12]..DA0040 DA0 
WHERE 
	DA0.DA0_FILIAL = '0404' AND 
	DA0.DA0_MSEXP = '' AND
	DA0.D_E_L_E_T_ = '' 
GO



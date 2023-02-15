USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_caixas]    Script Date: 14/02/2023 18:59:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[zendesk_invoice] as 

SELECT 
	rtrim(F2.F2_DOC) documento,
	rtrim(F2.F2_SERIE) serie, 
	case 
		when A1.A1_TIPO = 'F' then 'Final' 
		when A1.A1_TIPO = 'R' then 'Revenda'
		when A1.A1_TIPO = 'X' then 'Exportador' 
		else 
			'Revenda'
	end tipoCliente,
	rtrim(A1.A1_CGC) cnpj,
	rtrim(A1.A1_TEL) telefone,
	rtrim(case when A1.A1_ENDENT <> '' then A1.A1_ENDENT else A1.A1_END end) endereco,
	rtrim(case when A1.A1_ENDENT <> '' then A1.A1_BAIRROE else A1.A1_BAIRRO end) bairro,
	rtrim(case when A1.A1_ENDENT <> '' then A1.A1_MUNE else A1.A1_MUN end) municipio,
	rtrim(case when A1.A1_ENDENT <> '' then A1.A1_ESTE else A1.A1_EST end) estado,
	rtrim(case when A1.A1_ENDENT <> '' then A1.A1_CEPE else A1.A1_CEP end) cep,
	rtrim(case when A1.A1_ENDENT <> '' then A1.A1_COMPENT else A1.A1_COMPLEM end) complemento,
	rtrim(case when A1.A1_CONTRIB = '1' then 'Sim' else 'Não' end) contribuinte, 
	rtrim(F2.F2_COND) condicaoPagamento,
	rtrim(E4.E4_DESCRI) descricaoCondicao,
	rtrim(STATUS_PEDIDO.Z04_DESC) statusPedido
FROM 
	[LABOR-1233]..SF2040 F2 (NOLOCK)
	INNER JOIN [LABOR-1233]..SA1040 A1 (NOLOCK) ON A1.A1_FILIAL = '' AND A1.A1_COD = F2.F2_CLIENTE AND A1.A1_LOJA = F2.F2_LOJA AND A1.D_E_L_E_T_ = ''
	INNER JOIN [LABOR-1233]..SE4040 E4 (NOLOCK) ON E4.E4_FILIAL = '' AND E4.E4_CODIGO = F2.F2_COND AND E4.D_E_L_E_T_ = ''
	INNER JOIN [LABOR-1233]..SC5040 C5 (NOLOCK) ON C5.C5_FILIAL = F2.F2_FILIAL AND C5.C5_NOTA = F2.F2_DOC AND C5.C5_SERIE = F2.F2_SERIE AND C5.D_E_L_E_T_ = ''
	CROSS APPLY (

			
	)STATUS_PAGAMENTO
	CROSS APPLY(
		SELECT
			TOP 1
			Z04.Z04_DESC
		FROM 
			[LABOR-1233]..Z05040 Z05 (NOLOCK)
			INNER JOIN[LABOR-1233]..Z04040 Z04 (NOLOCK) ON Z04.Z04_FILIAL = '' AND Z04.Z04_COD = Z05.Z05_STATUS AND Z04.D_E_L_E_T_ = ''
		WHERE 
			Z05.Z05_FILIAL = C5.C5_FILIAL AND 
			Z05.Z05_PEDIDO = C5.C5_NUM AND 
			Z05.D_E_L_E_T_ = ''
		ORDER BY Z05_DATA DESC
	) STATUS_PEDIDO
WHERE 
	F2.F2_FILIAL = '0404' AND 
	F2.D_E_L_E_T_ = '' 

GO
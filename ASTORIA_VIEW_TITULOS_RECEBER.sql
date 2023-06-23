USE [GATEWAY]
GO

/****** Object:  View [dbo].[titulos_receber]    Script Date: 19/04/2023 22:32:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[titulos_receber] as 
SELECT
	E1.R_E_C_N_O_ id,
	Case when A1.A1_PESSOA = 'J' then 'PJ' else 'PF' end tipoCliente,
	Rtrim(A1.A1_CGC) cpfCnpj,
	Rtrim(A1.A1_NOME) nome, 
	Rtrim(A1.A1_COD) + RTrim(A1.A1_LOJA) contrato,
	Coalesce(E1.E1_PARCELA,'AA') parcela,
	convert(varchar,convert(date,E1.E1_VENCREA,3),103) dtVencimento,
	case when E1.E1_BAIXA = '' then E1.E1_SALDO else E1.E1_VALOR end valor,
	E1.E1_FILIAL + E1.E1_PREFIXO + E1.E1_NUM + E1.E1_PARCELA detalheParcela,
	Coalesce(RTrim(A1.A1_XVEND5),'') carteiraContrato,
	Rtrim(case when A1.A1_ENDCOB <> '' then A1.A1_ENDCOB else A1.A1_END end) endereco,
	Rtrim(case when A1.A1_ENDCOB <> '' then A1.A1_BAIRROC else A1.A1_BAIRRO end) bairro,
	Rtrim(case when A1.A1_ENDCOB <> '' then A1.A1_MUNC else A1.A1_MUN end) municipio,
	Rtrim(case when A1.A1_ENDCOB <> '' then A1.A1_ESTC else A1.A1_EST end) uf,
	Rtrim(case when A1.A1_ENDCOB <> '' then A1.A1_CEPC else A1.A1_CEP end) cep,
	Rtrim(A1.A1_DDD + A1.A1_TEL) telefone,
	Rtrim(A1.A1_EMAIL) email,
	case when E1.E1_BAIXA = '' then 'Em aberto' 
		 when E1.E1_BAIXA <> '' then 'baixado' end status 
FROM 
	[PROTHEUS_PRO]..SE1010 E1 (NOLOCK)
	INNER JOIN [PROTHEUS_PRO]..SA1010 A1 (NOLOCK) ON A1.A1_FILIAL = E1.E1_FILIAL AND A1.A1_COD = E1.E1_CLIENTE AND A1.A1_LOJA = E1.E1_LOJA AND A1.D_E_L_E_T_ = ''
	LEFT JOIN [PROTHEUS_PRO]..SE5010 E5 (NOLOCK) ON E5.E5_FILIAL = E1.E1_FILIAL AND E5.E5_NUMERO = E1.E1_NUM AND E5.E5_PREFIXO = E1.E1_PREFIXO AND E5.E5_PARCELA = E1.E1_PARCELA AND E5.D_E_L_E_T_ = ''
WHERE
	E1.E1_EMISSAO >= '20200101' AND
	E1.D_E_L_E_T_ = ' '

GO



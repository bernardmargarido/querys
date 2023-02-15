USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_pedidos]    Script Date: 12/01/2023 11:46:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE [dbo].[zendesk_order]
	-- Add the parameters for the stored procedure here
@PEDIDO varchar(6)

AS
BEGIN
	SELECT 
		codigoFilial, 
		tipoCliente,
		cnpj,
		telefone,
		endereco,
		bairro,
		municipio,
		cep,
		estado,
		complemento,
		condicaoPagamento,
		descricaoCondicao,
		statusPagamento,
		nomeVendedor,
		tipoFrete,
		statusPedido,
		contribuinte
	FROM 
	( 
		SELECT 
			C5.C5_FILIAL codigoFilial, 
			case 
			when A1.A1_TIPO = 'F' then 'Final' 
			when A1.A1_TIPO = 'R' then 'Revenda'
			when A1.A1_TIPO = 'X' then 'Exportador' 
			else 
				'Revenda'
			end tipoCliente,
			rtrim(A1.A1_CGC) cnpj,
			rtrim(case when A1.A1_TEL <> '' then A1.A1_DDD + '' + A1.A1_TEL  else  A1.A1_TEL2 end) telefone,
			rtrim(case when A1.A1_ENDENT <> '' then A1.A1_ENDENT else A1.A1_END end) endereco,
			rtrim(case when A1.A1_ENDENT <> '' then A1.A1_BAIRROE else A1.A1_BAIRRO end) bairro,
			rtrim(case when A1.A1_ENDENT <> '' then A1.A1_MUNE else A1.A1_MUN end) municipio,
			rtrim(case when A1.A1_ENDENT <> '' then A1.A1_ESTE else A1.A1_EST end) estado,
			rtrim(case when A1.A1_ENDENT <> '' then A1.A1_CEPE else A1.A1_CEP end) cep,
			rtrim(case when A1.A1_ENDENT <> '' then A1.A1_COMPENT else A1.A1_COMPLEM end) complemento,
			rtrim(case when A1.A1_CONTRIB = '1' then 'Sim' else 'Não' end) contribuinte, 
			rtrim(C5.C5_CONDPAG) condicaoPagamento,
			rtrim(E4.E4_DESCRI) descricaoCondicao,
			case 
				when STATUS_PAGAMENTO.SALDO > 0 then 'Aberto'  
				when STATUS_PAGAMENTO.SALDO = 0 then 'Baixado'
				else 'Não criado' 
			end statusPagamento,
			rtrim(A3.A3_NOME) nomeVendedor,
			rtrim(C5.C5_TPFRETE) tipoFrete,
			coalesce(rtrim(STATUS_PEDIDO.Z04_DESC),'') statusPedido
		FROM 
			[LABOR-1233]..SC5040 C5 WITH(NOLOCK) 
			INNER JOIN [LABOR-1233]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '    ' AND A1.A1_COD = C5.C5_CLIENTE AND A1.A1_LOJA = C5.C5_LOJACLI AND A1.D_E_L_E_T_ = '' 
			INNER JOIN [LABOR-1233]..SA3040 A3 WITH(NOLOCK) ON A3.A3_FILIAL = '    ' AND A3.A3_COD = C5.C5_VEND1 AND A3.D_E_L_E_T_ = '' 
			LEFT JOIN [LABOR-1233]..SE4040 E4 WITH(NOLOCK) ON E4.E4_FILIAL = '    ' AND E4.E4_CODIGO = C5.C5_CONDPAG AND E4.D_E_L_E_T_ = ''
			LEFT JOIN [LABOR-1233]..SA4040 A4 WITH(NOLOCK) ON A4.A4_FILIAL = '    ' AND A4.A4_COD = C5.C5_TRANSP AND A4.D_E_L_E_T_ = '' 
			LEFT JOIN [LABOR-1233]..SF2040 F2 WITH(NOLOCK) ON F2.F2_FILIAL = C5.C5_FILIAL AND F2.F2_DOC = C5.C5_NOTA AND F2.F2_SERIE = C5.C5_SERIE AND F2.D_E_L_E_T_ = '' 
			OUTER APPLY(
					SELECT 
						SUM(E1.E1_SALDO) SALDO
					FROM 
						[LABOR-1233]..SE1040 E1 WITH(NOLOCK) 
					WHERE 
						E1.E1_FILIAL = F2.F2_FILIAL AND 
						E1.E1_NUM = F2.F2_DOC AND 
						E1.E1_PREFIXO = F2.F2_SERIE AND 
						E1.E1_CLIENTE = F2.F2_CLIENTE AND 
						E1.E1_LOJA = F2.F2_LOJA AND 
						F2.D_E_L_E_T_ = '' 
			) STATUS_PAGAMENTO
			OUTER APPLY( 
						SELECT 
							TOP 1 
							Z04.Z04_DESC 
						FROM 
							[LABOR-1233]..Z05040 Z05 
   							INNER JOIN [LABOR-1233]..Z04040 Z04 ON Z04.Z04_FILIAL = '    ' AND Z04.Z04_COD = Z05.Z05_STATUS AND Z04.D_E_L_E_T_ = '' 
						WHERE 
							Z05.Z05_FILIAL = C5.C5_FILIAL AND 
							Z05.Z05_PEDIDO = C5.C5_NUM AND 
							Z05.D_E_L_E_T_ = '' 
						ORDER BY Z05.Z05_DATA DESC 
			)STATUS_PEDIDO 
		WHERE 
			C5.C5_FILIAL = '0404' AND 
			C5.C5_NUM = @PEDIDO AND
			C5.D_E_L_E_T_ = '' 
	)PEDIDOS 
		
end

--SELECT * FROM [LABOR-1233]..SC5040 WHERE C5_FILIAL = '0404' AND C5_NUM = '401365' AND D_E_L_E_T_ = ''
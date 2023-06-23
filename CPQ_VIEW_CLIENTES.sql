USE [GATEWAY]
GO

/****** Object:  View [dbo].[cpq_clientes]    Script Date: 15/05/2023 11:34:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[cpq_clientes] as 

SELECT 
	clienteId
	,moipId
	,codigoFilial
	,codigoErp
	,tipoCliente
	,razaoSocial
	,nomeFantasia
	,endereco
	,complemento
	,bairro
	,uf
	,codigoMunicipio
	,nomeMunicipio
	,cep
	,endereco_entrega
	,complemento_entrega
	,bairro_entrega
	,uf_entrega
	,municipio_entrega
	,cep_entrega
	,tipoPessoa
	,cnpj
	,cpf
	,ddd
	,telefone
	,mailNfe
	,mailCompras
	,mailContato
	,contato
	,inscricaoEstadual
	,inscricaoMunicipal
	,pais
	,bloqueado
	,grupoCliente
	,descricaoGrupoCliente
	,dataCadastro
	,protestar
	,risco
	,cnae
	,descricaoCnae
	,cnaeSecundario
	,descricaoCnaeSecundario
	,limiteCredito
	,saldoLimiteCredito
	,dataLimiteCredito
	,mediaAtrasos
	,saldoAtrasos
	,codigoSegmento
	,descricaoSegmento
	,diasEmAtraso
	,codigoVendedor
	,nomeVendedor
	,mailVendedor
	,codigoVendedor2
	,nomeVendedor2
	,mailVendedor2
	,pedidosLiberados
	,saldoPedidos
	,dataFundacao
	,tabelaPreco
	,tabelaPreco2
	,obsFinanceiro 
	,obsLogistica
	,obsComercial
	,dataReceita
	,situacaoReceita
	,dataSintegra
	,situacaoSintegra
	,dataSuframa
	,situacaoSuframa
	,dataSimples
	,situacaoSimples
	,dataUltimaCompra
	,situacaoCompra
	,dataAnvisa
	,contribuinte
	,grupoColigado
	,tipoRegistro
FROM 
(

	SELECT
		SA1.R_E_C_N_O_ AS clienteId
		,RTRIM(A1_XIDWIRE) AS moipId
		,RTRIM(A1_FILIAL) AS codigoFilial
		,RTRIM(A1_COD+A1_LOJA) AS codigoErp
		,A1_TIPO tipoCliente
		,RTRIM(A1_NOME) AS razaoSocial
		,RTRIM(A1_NREDUZ) AS nomeFantasia
		,RTRIM(A1_END) AS endereco
		,RTRIM(A1_COMPLEM) AS complemento
		,RTRIM(A1_BAIRRO) AS bairro
		,RTRIM(A1_EST) AS uf
		,RTRIM(A1_COD_MUN) AS codigoMunicipio
		,RTRIM(A1_MUN) AS nomeMunicipio
		,RTRIM(A1_CEP) AS cep
		,RTRIM(A1_ENDENT)endereco_entrega
		,RTRIM(A1_COMPENT)complemento_entrega
		,RTRIM(A1_BAIRROE)bairro_entrega
		,RTRIM(A1_ESTE)uf_entrega
		,RTRIM(A1_MUNE)municipio_entrega
		,RTRIM(A1_CEPE)cep_entrega
		,RTRIM(A1_PESSOA) AS tipoPessoa
		,CASE WHEN A1_PESSOA = 'J' THEN RTRIM(A1_CGC) ELSE ' ' END AS cnpj
		,CASE WHEN A1_PESSOA = 'F' THEN RTRIM(A1_CGC) ELSE ' ' END AS cpf
		,RTRIM(A1_DDD) AS ddd
		,RTRIM(A1_TEL) AS telefone
		,RTRIM(A1_EMAIL) AS mailNfe
		,RTRIM(A1_EMLCOMP) AS mailCompras
		,RTRIM(A1_EMLCONT) AS mailContato
		,RTRIM(A1_CONTATO) AS contato
		,RTRIM(A1_INSCR) AS inscricaoEstadual
		,RTRIM(A1_INSCRM) AS inscricaoMunicipal
		,RTRIM(A1_PAIS) AS pais
		,CASE WHEN A1_MSBLQL = '1' THEN 'S' ELSE 'N' END AS bloqueado
		,A1_GRPVEN AS grupoCliente
		,RTRIM(ISNULL(ACY_DESCRI,'')) AS descricaoGrupoCliente
		,IIF(A1_XDTRCAD <> '', convert(varchar,convert(date,A1_XDTRCAD,101),121), '') AS dataCadastro
		,RTRIM(CASE WHEN A1_XPROTES = '1' THEN 'S' ELSE 'N' END) AS protestar
		,RTRIM(A1_RISCO) risco
		,RTRIM(A1_CNAE) cnae
		,COALESCE(RTRIM(CC3_DESC),'') descricaoCnae
		,COALESCE(RTRIM(CNAE_SEC.ZX2_CNAE),'') cnaeSecundario
		,COALESCE(RTRIM(CNAE_SEC.ZX2_DESC),'') descricaoCnaeSecundario
		,A1_LC AS limiteCredito
		,CASE WHEN (A1_LC - ( A1_SALDUP + A1_SALPEDL ) ) > 0 THEN (A1_LC - ( A1_SALDUP + A1_SALPEDL ) ) ELSE 0 END AS saldoLimiteCredito
		,IIF(A1_VENCLC <> '', convert(varchar,convert(date,A1_VENCLC,101),121), '') AS dataLimiteCredito
		,A1_METR AS mediaAtrasos
		,COALESCE(SALDO_ATRASO.SALDO,0) AS saldoAtrasos
		,RTRIM(A1_XSGMCRE) AS codigoSegmento
		,RTRIM(ISNULL(XTI_DESCRI,'')) AS descricaoSegmento
		,ISNULL(
			(SELECT
				CASE WHEN DATEDIFF(DAY,MIN(E1_VENCTO),GETDATE()) > 0 THEN DATEDIFF(DAY,MIN(E1_VENCTO),GETDATE()) ELSE 0 END AS diasEmAtraso
			FROM [LABOR-PROD12]..SE1040 SE1 (NOLOCK) 
			WHERE
				SE1.E1_CLIENTE = SA1.A1_COD
				AND SE1.E1_LOJA = SA1.A1_LOJA
				AND SE1.E1_SALDO > 0
				AND SE1.E1_VENCTO < CONVERT(VARCHAR, GETDATE(), 112)
				AND SE1.D_E_L_E_T_ = ' '),0) AS diasEmAtraso
		,RTRIM(A1_VEND) AS codigoVendedor
		,RTRIM(ISNULL(SA3.A3_NOME,'')) AS nomeVendedor
		,RTRIM(ISNULL(SA3.A3_EMAIL,'')) AS mailVendedor	
		,RTRIM(A1_XVEND2) AS codigoVendedor2
		,RTRIM(ISNULL(SA3_2.A3_NOME,'')) AS nomeVendedor2
		,RTRIM(ISNULL(SA3_2.A3_EMAIL,'')) AS mailVendedor2	
		,A1_SALPEDL AS pedidosLiberados
		,A1_SALPED AS saldoPedidos
		,IIF(A1_DTNASC <> '', convert(varchar,convert(date,A1_DTNASC,101),121),'') AS dataFundacao
		,A1_TABELA AS tabelaPreco
		,A1_XTABPR2 AS tabelaPreco2
		,IIF(dbo.fncRemove_Caracteres_Ocultos(A1_OBSFIN) <> '',dbo.fncRemove_Caracteres_Ocultos(CAST(CAST( RTRIM(A1_OBSFIN) AS BINARY(1024)) AS VARCHAR(1024))),'') AS obsFinanceiro 
		,IIF(dbo.fncRemove_Caracteres_Ocultos(A1_OBSLO) <> '',dbo.fncRemove_Caracteres_Ocultos(CAST(CAST( RTRIM(A1_OBSLO) AS BINARY(1024)) AS VARCHAR(1024))),'') AS obsLogistica
		,IIF(dbo.fncRemove_Caracteres_Ocultos(A1_OBSCO) <> '',dbo.fncRemove_Caracteres_Ocultos(CAST(CAST( RTRIM(A1_OBSCO) AS BINARY(1024)) AS VARCHAR(1024))),'') AS obsComercial
		,IIF(A1_XDTRECF <> '', convert(varchar,convert(date,A1_XDTRECF,101),121), '') AS dataReceita
		,COALESCE(CASE 
			WHEN A1_XSITREC = '1' THEN 'Ativa' 
			WHEN A1_XSITREC = '2' THEN 'Habilitada' 
			WHEN A1_XSITREC = '3' THEN 'Não Habilitada' 
			WHEN A1_XSITREC = '4' THEN 'Não Localizada' 
			WHEN A1_XSITREC = '5' THEN 'Suspensa' 
			WHEN A1_XSITREC = '6' THEN 'Inapta' 
			WHEN A1_XSITREC = '7' THEN 'Baixada' 
			WHEN A1_XSITREC = '8' THEN 'Impedida' 
			WHEN A1_XSITREC = '9' THEN 'Inativa' 
			WHEN A1_XSITREC = 'A' THEN 'Cancelada' 
			WHEN A1_XSITREC = 'B' THEN 'Nula' 
		END,'') AS situacaoReceita
		,IIF(A1_XDTSINT <> '', convert(varchar,convert(date,A1_XDTSINT,101),121), '') AS dataSintegra
		,COALESCE(CASE 
			WHEN A1_XSITSIN = '1' THEN 'Ativa' 
			WHEN A1_XSITSIN = '2' THEN 'Habilitada' 
			WHEN A1_XSITSIN = '3' THEN 'Não Habilitada' 
			WHEN A1_XSITSIN = '4' THEN 'Não Localizada' 
			WHEN A1_XSITSIN = '5' THEN 'Suspensa' 
			WHEN A1_XSITSIN = '6' THEN 'Inapta' 
			WHEN A1_XSITSIN = '7' THEN 'Baixada' 
			WHEN A1_XSITSIN = '8' THEN 'Impedida' 
			WHEN A1_XSITSIN = '9' THEN 'Inativa' 
			WHEN A1_XSITSIN = 'A' THEN 'Cancelada' 
			WHEN A1_XSITSIN = 'B' THEN 'Nula' 
		 END,'') AS situacaoSintegra
		,IIF(A1_XDTSUFR <> '', convert(varchar,convert(date,A1_XDTSUFR,101),121), '') AS dataSuframa
		,COALESCE(CASE 
			WHEN A1_XSITSUF = '1' THEN 'Ativa' 
			WHEN A1_XSITSUF = '2' THEN 'Habilitada' 
			WHEN A1_XSITSUF = '3' THEN 'Não Habilitada' 
			WHEN A1_XSITSUF = '4' THEN 'Não Localizada' 
			WHEN A1_XSITSUF = '5' THEN 'Suspensa' 
			WHEN A1_XSITSUF = '6' THEN 'Inapta' 
			WHEN A1_XSITSUF = '7' THEN 'Baixada' 
			WHEN A1_XSITSUF = '8' THEN 'Impedida' 
			WHEN A1_XSITSUF = '9' THEN 'Inativa' 
			WHEN A1_XSITSUF = 'A' THEN 'Cancelada' 
			WHEN A1_XSITSUF = 'B' THEN 'Nula' 
		 END,'') AS situacaoSuframa
		,IIF(A1_XDTSIMP <> '',convert(varchar,convert(date,A1_XDTSIMP,101),121),'') AS dataSimples
		,CASE 
			WHEN A1_SIMPLES = '1' THEN 'Ativo' 
			ELSE 'Inativo' 
		END AS situacaoSimples
		,IIF(ULTIMA_COMPRA.DT_COMPRA <> '', convert(varchar,convert(date,ULTIMA_COMPRA.DT_COMPRA,101),121), '') AS dataUltimaCompra
		,CASE 
			WHEN DATEADD(day,-90,getdate()) > COALESCE(convert(date,ULTIMA_COMPRA.DT_COMPRA,101),DATEADD(day,-100,getdate())) THEN 
				'CLIENTE INATIVO'
			ELSE 
				'CLIENTE ATIVO' 
		END AS situacaoCompra
		,IIF(A1_XVLD <> '', convert(varchar,convert(date,A1_XVLD,101),121), '') AS dataAnvisa
		,CASE 
			WHEN A1_CONTRIB = '1' THEN 'Sim' 
			ELSE 'Não' 
		END AS contribuinte
		,RTRIM(SZ5.Z5_DESCRI) AS grupoColigado
		,'cliente' tipoRegistro
	FROM [LABOR-PROD12]..SA1040 SA1 (NOLOCK)
	LEFT JOIN [LABOR-PROD12]..ACY040 ACY (NOLOCK)
		ON ACY.ACY_FILIAL = ' '
		AND ACY.ACY_GRPVEN = SA1.A1_GRPVEN
		AND ACY.D_E_L_E_T_ = ' '
	LEFT JOIN [LABOR-PROD12]..XTI040 XTI (NOLOCK)
		ON XTI.XTI_FILIAL = ' '
		AND XTI.XTI_CODIGO = SA1.A1_XSGMCRE
		AND XTI.D_E_L_E_T_ = ' '
	LEFT JOIN [LABOR-PROD12]..SA3040 SA3 (NOLOCK)
		ON SA3.A3_FILIAL = ' '
		AND SA3.A3_COD = SA1.A1_VEND
		AND SA3.D_E_L_E_T_ = ' '
	LEFT JOIN [LABOR-PROD12]..SA3040 SA3_2 (NOLOCK)
		ON SA3_2.A3_FILIAL = ' '
		AND SA3_2.A3_COD = SA1.A1_XVEND2
		AND SA3_2.D_E_L_E_T_ = ' '
	LEFT JOIN [LABOR-PROD12]..CC3040 CC3 (NOLOCK)
		ON CC3.CC3_FILIAL = ' '
		AND CC3.CC3_COD = SA1.A1_CNAE
		AND CC3.D_E_L_E_T_ = ' '
	LEFT JOIN [LABOR-PROD12]..SZ5040 SZ5 (NOLOCK)
		ON SZ5.Z5_FILIAL = ' '
		AND SZ5.Z5_CODIGO = SA1.A1_XCOLIG
		AND SZ5.D_E_L_E_T_ = ' '
	OUTER APPLY( 
		SELECT 
			TOP 1 
			ZX2.ZX2_CNAE,
			ZX2.ZX2_DESC
		FROM 
			[LABOR-PROD12]..ZX2040 ZX2 (NOLOCK)
		WHERE 
			ZX2.ZX2_FILIAL = '' AND 
			ZX2.ZX2_CGC = SA1.A1_CGC AND 
			ZX2.D_E_L_E_T_ = ''
	)CNAE_SEC
	OUTER APPLY(
		SELECT 
			MAX(F2_EMISSAO) DT_COMPRA
		FROM 
			[LABOR-PROD12]..SF2040 F2 (NOLOCK)
		WHERE 
			F2.F2_CLIENTE = SA1.A1_COD AND 
			F2.F2_LOJA = SA1.A1_LOJA AND 
			F2.D_E_L_E_T_ = ''
	)ULTIMA_COMPRA
	OUTER APPLY (
		SELECT 
			SUM(SE1.E1_SALDO) SALDO 
		FROM 
			[LABOR-PROD12]..SE1040 SE1 
		WHERE 
			SE1.E1_CLIENTE = SA1.A1_COD
			AND SE1.E1_LOJA = SA1.A1_LOJA
			AND SE1.E1_SALDO > 0
			AND SE1.E1_VENCREA < CONVERT(VARCHAR, GETDATE(), 112)
			AND SE1.D_E_L_E_T_ = ' '
	)SALDO_ATRASO
	WHERE
		SA1.A1_MSEXP = '' AND
		SA1.D_E_L_E_T_ = ' '
	
	UNION ALL 
	
	SELECT
		SUS.R_E_C_N_O_ AS clienteId
		,RTRIM(US_XIDWIRE) AS moipId
		,RTRIM(US_FILIAL) AS codigoFilial
		,RTRIM(US_COD+US_LOJA) AS codigoErp
		,US_TIPO tipoCliente
		,RTRIM(US_NOME) AS razaoSocial
		,RTRIM(US_NREDUZ) AS nomeFantasia
		,RTRIM(US_END) AS endereco
		,RTRIM(US_XCOMPLE) AS complemento
		,RTRIM(US_BAIRRO) AS bairro
		,RTRIM(US_EST) AS uf
		,RTRIM(US_COD_MUN) AS codigoMunicipio
		,RTRIM(US_MUN) AS nomeMunicipio
		,RTRIM(US_CEP) AS cep
		,'' endereco_entrega
		,'' complemento_entrega
		,'' bairro_entrega
		,'' uf_entrega
		,'' municipio_entrega
		,'' cep_entrega
		,RTRIM(US_PESSOA) AS tipoPessoa
		,CASE WHEN US_PESSOA = 'J' THEN RTRIM(US_CGC) ELSE ' ' END AS cnpj
		,CASE WHEN US_PESSOA = 'F' THEN RTRIM(US_CGC) ELSE ' ' END AS cpf
		,RTRIM(US_DDD) AS ddd
		,RTRIM(US_TEL) AS telefone
		,RTRIM(US_EMAIL) AS mailNfe
		,'' mailCompras
		,'' mailContato
		,RTRIM(US_XCONTAT) AS contato
		,RTRIM(US_INSCR) AS inscricaoEstadual
		,'' AS inscricaoMunicipal
		,RTRIM(US_PAIS) AS pais
		,CASE WHEN US_MSBLQL = '1' THEN 'S' ELSE 'N' END AS bloqueado
		,'' AS grupoCliente
		,'' AS descricaoGrupoCliente
		,IIF(US_DTCAD <> '',convert(varchar,convert(date,US_DTCAD,101),121),'') AS dataCadastro
		,'N' AS protestar
		,'' risco
		,RTRIM(US_CNAE) cnae
		,COALESCE(RTRIM(CC3_DESC),'') descricaoCnae
		,COALESCE(RTRIM(CNAE_SEC.ZX2_CNAE),'') cnaeSecundario
		,COALESCE(RTRIM(CNAE_SEC.ZX2_DESC),'') descricaoCnaeSecundario
		,US_LC AS limiteCredito
		,0 AS saldoLimiteCredito
		,IIF(US_VENCLC <> '',convert(varchar,convert(date,US_VENCLC,101),121),'') AS dataLimiteCredito
		,0 AS mediaAtrasos
		,0 AS saldoAtrasos
		,'' AS codigoSegmento
		,'' AS descricaoSegmento
		,0 AS diasEmAtraso
		,RTRIM(US_VEND) AS codigoVendedor
		,RTRIM(ISNULL(SA3.A3_NOME,'')) AS nomeVendedor
		,RTRIM(ISNULL(SA3.A3_EMAIL,'')) AS mailVendedor	
		,RTRIM(US_XVEND2) AS codigoVendedor2
		,RTRIM(ISNULL(SA3_2.A3_NOME,'')) AS nomeVendedor2
		,RTRIM(ISNULL(SA3_2.A3_EMAIL,'')) AS mailVendedor2
		,0 AS pedidosLiberados
		,0 AS saldoPedidos
		,IIF(US_DTCAD <> '',convert(varchar,convert(date,US_DTCAD,101),121),'') AS dataFundacao
		,US_TABPRE AS tabelaPreco
		,US_XTABPR2 AS tabelaPreco2
		,'' AS obsFinanceiro 
		,'' AS obsLogistica
		,'' AS obsComercial
		,IIF(US_XDTRECF <> '',convert(varchar,convert(date,US_XDTRECF,101),121),'') AS dataReceita
		,COALESCE(CASE 
			WHEN US_XSITREC = '1' THEN 'Ativa' 
			WHEN US_XSITREC = '2' THEN 'Habilitada' 
			WHEN US_XSITREC = '3' THEN 'Não Habilitada' 
			WHEN US_XSITREC = '4' THEN 'Não Localizada' 
			WHEN US_XSITREC = '5' THEN 'Suspensa' 
			WHEN US_XSITREC = '6' THEN 'Inapta' 
			WHEN US_XSITREC = '7' THEN 'Baixada' 
			WHEN US_XSITREC = '8' THEN 'Impedida' 
			WHEN US_XSITREC = '9' THEN 'Inativa' 
			WHEN US_XSITREC = 'A' THEN 'Cancelada' 
			WHEN US_XSITREC = 'B' THEN 'Nula' 
		END,'') AS situacaoReceita
		,IIF(US_XDTSINT <> '',convert(varchar,convert(date,US_XDTSINT,101),121),'') AS dataSintegra
		,COALESCE(CASE 
			WHEN US_XSITSIN = '1' THEN 'Ativa' 
			WHEN US_XSITSIN = '2' THEN 'Habilitada' 
			WHEN US_XSITSIN = '3' THEN 'Não Habilitada' 
			WHEN US_XSITSIN = '4' THEN 'Não Localizada' 
			WHEN US_XSITSIN = '5' THEN 'Suspensa' 
			WHEN US_XSITSIN = '6' THEN 'Inapta' 
			WHEN US_XSITSIN = '7' THEN 'Baixada' 
			WHEN US_XSITSIN = '8' THEN 'Impedida' 
			WHEN US_XSITSIN = '9' THEN 'Inativa' 
			WHEN US_XSITSIN = 'A' THEN 'Cancelada' 
			WHEN US_XSITSIN = 'B' THEN 'Nula' 
		END,'') AS situacaoSintegra
		,IIF(US_XDTSUFR <> '',convert(varchar,convert(date,US_XDTSUFR,101),121),'') AS dataSuframa
		,COALESCE(CASE 
			WHEN US_XSITSUF = '1' THEN 'Ativa' 
			WHEN US_XSITSUF = '2' THEN 'Habilitada' 
			WHEN US_XSITSUF = '3' THEN 'Não Habilitada' 
			WHEN US_XSITSUF = '4' THEN 'Não Localizada' 
			WHEN US_XSITSUF = '5' THEN 'Suspensa' 
			WHEN US_XSITSUF = '6' THEN 'Inapta' 
			WHEN US_XSITSUF = '7' THEN 'Baixada' 
			WHEN US_XSITSUF = '8' THEN 'Impedida' 
			WHEN US_XSITSUF = '9' THEN 'Inativa' 
			WHEN US_XSITSUF = 'A' THEN 'Cancelada' 
			WHEN US_XSITSUF = 'B' THEN 'Nula' 
		END,'') AS situacaoSuframa
		,IIF(US_XDTSIMP <> '',convert(varchar,convert(date,US_XDTSIMP,101),121),'') AS dataSimples
		,US_XSITSIM AS situacaoSimples
		,'' AS dataUltimaCompra
		,'' AS situacaoCompra
		,'' AS dataAnvisa
		,CASE 
			WHEN US_CONTRIB = '1' THEN 
				'Sim' 
			ELSE 
				'Não' 
		END AS contribuinte
		,'' AS grupoColigado
		,'prospect' tipoRegistro
	FROM [LABOR-PROD12]..SUS040 SUS (NOLOCK)
	LEFT JOIN [LABOR-PROD12]..SA3040 SA3 (NOLOCK)
		ON SA3.A3_FILIAL = ' '
		AND SA3.A3_COD = SUS.US_VEND
		AND SA3.D_E_L_E_T_ = ' '
	LEFT JOIN [LABOR-PROD12]..SA3040 SA3_2 (NOLOCK)
		ON SA3_2.A3_FILIAL = ' '
		AND SA3_2.A3_COD = SUS.US_XVEND2
		AND SA3_2.D_E_L_E_T_ = ' '
	LEFT JOIN [LABOR-PROD12]..CC3040 CC3 (NOLOCK)
		ON CC3.CC3_FILIAL = ' '
		AND CC3.CC3_COD = SUS.US_CNAE
		AND CC3.D_E_L_E_T_ = ' '
	OUTER APPLY( 
		SELECT 
			TOP 1 
			ZX2.ZX2_CNAE,
			ZX2.ZX2_DESC
		FROM 
			[LABOR-PROD12]..ZX2040 ZX2 (NOLOCK)
		WHERE 
			ZX2.ZX2_FILIAL = '' AND 
			ZX2.ZX2_CGC = SUS.US_CGC AND 
			ZX2.D_E_L_E_T_ = ''
	)CNAE_SEC
	WHERE
		SUS.US_FILIAL = ' '
		AND SUS.US_MSEXP = '' 
		AND SUS.US_CODCLI = ''
		AND SUS.US_LOJACLI = ''
		AND NOT EXISTS( 
						SELECT 
							A1_CGC 
						FROM 
							[LABOR-PROD12]..SA1040 A1 (NOLOCK)
						WHERE 
							A1.A1_FILIAL = '' 
							AND A1.A1_CGC = SUS.US_CGC 
							AND A1.D_E_L_E_T_ = ''
		) 
		AND SUS.D_E_L_E_T_ = ''
)CLI_PROSPECTS 
GO



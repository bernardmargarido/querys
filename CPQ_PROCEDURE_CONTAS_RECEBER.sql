USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_contas_receber]    Script Date: 16/09/2022 12:25:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cpq_contas_receber]
	-- Add the parameters for the stored procedure here
@IDPAGESIZE int,
@IDPAGE int,
@IDCLIENTE int,
@TP_TITULO varchar(10),
@DTA_DE varchar(10),
@DTA_ATE varchar(10)

AS
BEGIN

IF @IDCLIENTE > 0 
	IF @TP_TITULO = 'aberto' 

		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial,
			clienteID,
			titulo, 
			prefixo, 
			parcela, 
			pedido, 
			dataEmissao,
			dataVencimento, 
			valorTitulo, 
			dataBaixa,
			statusTitulo
		FROM(
			SELECT 
				ROW_NUMBER() OVER(ORDER BY E1.E1_NUM DESC) rNum,
				E1.E1_FILIAL codigoFilial, 
				A1.R_E_C_N_O_ clienteID,
				E1.E1_NUM titulo, 
				E1.E1_PREFIXO prefixo, 
				E1.E1_PARCELA parcela, 
				C5.C5_NUM pedido, 
				convert(varchar,convert(date,E1.E1_EMISSAO,101),121) dataEmissao,
				convert(varchar,convert(date,E1.E1_VENCREA,101),121) dataVencimento, 
				E1.E1_VALOR valorTitulo, 
				case when E1.E1_BAIXA <> '' then convert(varchar,convert(date,E1.E1_BAIXA,101),121) else '' end dataBaixa,
				case when E1.E1_BAIXA = '' then 'aberto' else 'baixado' end statusTitulo
			FROM 
				[LABOR-PROD12]..SE1040 E1 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '' AND A1.R_E_C_N_O_ = @IDCLIENTE AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) ON C5.C5_FILIAL = E1.E1_FILIAL AND C5.C5_NUM = E1.E1_PEDIDO AND E1.D_E_L_E_T_ = '' 
			WHERE 
				E1.E1_CLIENTE = A1.A1_COD AND 
				E1.E1_LOJA = A1.A1_LOJA AND 
				E1.E1_EMISSAO BETWEEN convert(varchar,convert(date,@DTA_DE,102),112) AND convert(varchar,convert(date,@DTA_ATE,102),112) AND
				E1.E1_BAIXA = '' AND
				E1.D_E_L_E_T_ = '' 
		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	ELSE IF @TP_TITULO = 'baixado'
	
			SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			clienteID,
			titulo, 
			prefixo, 
			parcela, 
			pedido, 
			dataEmissao,
			dataVencimento, 
			valorTitulo, 
			dataBaixa,
			statusTitulo
		FROM(
			SELECT 
				ROW_NUMBER() OVER(ORDER BY E1.E1_NUM DESC) rNum,
				E1.E1_FILIAL codigoFilial, 
				A1.R_E_C_N_O_ clienteID,
				E1.E1_NUM titulo, 
				E1.E1_PREFIXO prefixo, 
				E1.E1_PARCELA parcela, 
				C5.C5_NUM pedido, 
				convert(varchar,convert(date,E1.E1_EMISSAO,101),121) dataEmissao,
				convert(varchar,convert(date,E1.E1_VENCREA,101),121) dataVencimento, 
				E1.E1_VALOR valorTitulo, 
				case when E1.E1_BAIXA <> '' then convert(varchar,convert(date,E1.E1_BAIXA,101),121) else '' end dataBaixa,
				case when E1.E1_BAIXA = '' then 'aberto' else 'baixado' end statusTitulo
			FROM 
				[LABOR-PROD12]..SE1040 E1 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '' AND A1.R_E_C_N_O_ = @IDCLIENTE AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) ON C5.C5_FILIAL = E1.E1_FILIAL AND C5.C5_NUM = E1.E1_PEDIDO AND E1.D_E_L_E_T_ = '' 
			WHERE 
				E1.E1_CLIENTE = A1.A1_COD AND 
				E1.E1_LOJA = A1.A1_LOJA AND 
				E1.E1_EMISSAO BETWEEN convert(varchar,convert(date,@DTA_DE,102),112) AND convert(varchar,convert(date,@DTA_ATE,102),112) AND
				E1.E1_BAIXA <> '' AND
				E1.D_E_L_E_T_ = '' 
	
		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	ELSE 

		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			clienteID,
			titulo, 
			prefixo, 
			parcela, 
			pedido, 
			dataEmissao,
			dataVencimento, 
			valorTitulo, 
			dataBaixa,
			statusTitulo
		FROM(
			SELECT 
				ROW_NUMBER() OVER(ORDER BY E1.E1_NUM DESC) rNum,
				E1.E1_FILIAL codigoFilial, 
				A1.R_E_C_N_O_ clienteID,
				E1.E1_NUM titulo, 
				E1.E1_PREFIXO prefixo, 
				E1.E1_PARCELA parcela, 
				C5.C5_NUM pedido, 
				convert(varchar,convert(date,E1.E1_EMISSAO,101),121) dataEmissao,
				convert(varchar,convert(date,E1.E1_VENCREA,101),121) dataVencimento, 
				E1.E1_VALOR valorTitulo, 
				case when E1.E1_BAIXA <> '' then convert(varchar,convert(date,E1.E1_BAIXA,101),121) else '' end dataBaixa,
				case when E1.E1_BAIXA = '' then 'aberto' else 'baixado' end statusTitulo
			FROM 
				[LABOR-PROD12]..SE1040 E1 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '' AND A1.R_E_C_N_O_ = @IDCLIENTE AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) ON C5.C5_FILIAL = E1.E1_FILIAL AND C5.C5_NUM = E1.E1_PEDIDO AND E1.D_E_L_E_T_ = '' 
			WHERE 
				E1.E1_CLIENTE = A1.A1_COD AND 
				E1.E1_LOJA = A1.A1_LOJA AND 
				E1.E1_EMISSAO BETWEEN convert(varchar,convert(date,@DTA_DE,102),112) AND convert(varchar,convert(date,@DTA_ATE,102),112) AND
				E1.D_E_L_E_T_ = '' 
	
		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	--ORDER BY codigoFilial, titulo, prefixo, dataEmissao
ELSE
	IF @TP_TITULO = 'aberto' 

		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			clienteID,
			titulo, 
			prefixo, 
			parcela, 
			pedido, 
			dataEmissao,
			dataVencimento, 
			valorTitulo, 
			dataBaixa,
			statusTitulo
		FROM(
			SELECT 
				ROW_NUMBER() OVER(ORDER BY E1.E1_NUM DESC) rNum,
				E1.E1_FILIAL codigoFilial, 
				A1.R_E_C_N_O_ clienteID,
				E1.E1_NUM titulo, 
				E1.E1_PREFIXO prefixo, 
				E1.E1_PARCELA parcela, 
				C5.C5_NUM pedido, 
				convert(varchar,convert(date,E1.E1_EMISSAO,101),121) dataEmissao,
				convert(varchar,convert(date,E1.E1_VENCREA,101),121) dataVencimento, 
				E1.E1_VALOR valorTitulo, 
				case when E1.E1_BAIXA <> '' then convert(varchar,convert(date,E1.E1_BAIXA,101),121) else '' end dataBaixa,
				case when E1.E1_BAIXA = '' then 'aberto' else 'baixado' end statusTitulo
			FROM 
				[LABOR-PROD12]..SE1040 E1 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '' AND A1.A1_COD = E1.E1_CLIENTE AND A1.A1_LOJA = E1.E1_LOJA AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) ON C5.C5_FILIAL = E1.E1_FILIAL AND C5.C5_NUM = E1.E1_PEDIDO AND E1.D_E_L_E_T_ = '' 
			WHERE 
				E1.E1_EMISSAO BETWEEN convert(varchar,convert(date,@DTA_DE,102),112) AND convert(varchar,convert(date,@DTA_ATE,102),112) AND
				E1.E1_BAIXA = '' AND
				E1.D_E_L_E_T_ = '' 

		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	ELSE IF @TP_TITULO = 'baixado'
	
		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			clienteID,
			titulo, 
			prefixo, 
			parcela, 
			pedido, 
			dataEmissao,
			dataVencimento, 
			valorTitulo, 
			dataBaixa,
			statusTitulo
		FROM(
			SELECT 
				ROW_NUMBER() OVER(ORDER BY E1.E1_NUM DESC) rNum,
				E1.E1_FILIAL codigoFilial, 
				A1.R_E_C_N_O_ clienteID,
				E1.E1_NUM titulo, 
				E1.E1_PREFIXO prefixo, 
				E1.E1_PARCELA parcela, 
				C5.C5_NUM pedido, 
				convert(varchar,convert(date,E1.E1_EMISSAO,101),121) dataEmissao,
				convert(varchar,convert(date,E1.E1_VENCREA,101),121) dataVencimento, 
				E1.E1_VALOR valorTitulo, 
				case when E1.E1_BAIXA <> '' then convert(varchar,convert(date,E1.E1_BAIXA,101),121) else '' end dataBaixa,
				case when E1.E1_BAIXA = '' then 'aberto' else 'baixado' end statusTitulo
			FROM 
				[LABOR-PROD12]..SE1040 E1 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '' AND A1.A1_COD = E1.E1_CLIENTE AND A1.A1_LOJA = E1.E1_LOJA AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) ON C5.C5_FILIAL = E1.E1_FILIAL AND C5.C5_NUM = E1.E1_PEDIDO AND E1.D_E_L_E_T_ = '' 
			WHERE 
				E1.E1_EMISSAO BETWEEN convert(varchar,convert(date,@DTA_DE,102),112) AND convert(varchar,convert(date,@DTA_ATE,102),112) AND
				E1.E1_BAIXA <> '' AND
				E1.D_E_L_E_T_ = '' 
		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 
	ELSE 

		SELECT 
			TOP(@IDPAGESIZE) rNum, 
			codigoFilial, 
			clienteID,
			titulo, 
			prefixo, 
			parcela, 
			pedido, 
			dataEmissao,
			dataVencimento, 
			valorTitulo, 
			dataBaixa,
			statusTitulo
		FROM(
			SELECT 
				ROW_NUMBER() OVER(ORDER BY E1.E1_NUM DESC) rNum,
				E1.E1_FILIAL codigoFilial, 
				A1.R_E_C_N_O_ clienteID,
				E1.E1_NUM titulo, 
				E1.E1_PREFIXO prefixo, 
				E1.E1_PARCELA parcela, 
				C5.C5_NUM pedido, 
				convert(varchar,convert(date,E1.E1_EMISSAO,101),121) dataEmissao,
				convert(varchar,convert(date,E1.E1_VENCREA,101),121) dataVencimento, 
				E1.E1_VALOR valorTitulo, 
				case when E1.E1_BAIXA <> '' then convert(varchar,convert(date,E1.E1_BAIXA,101),121) else '' end dataBaixa,
				case when E1.E1_BAIXA = '' then 'aberto' else 'baixado' end statusTitulo
			FROM 
				[LABOR-PROD12]..SE1040 E1 WITH(NOLOCK) 
				INNER JOIN [LABOR-PROD12]..SA1040 A1 WITH(NOLOCK) ON A1.A1_FILIAL = '' AND A1.A1_COD = E1.E1_CLIENTE AND A1.A1_LOJA = E1.E1_LOJA AND A1.D_E_L_E_T_ = '' 
				INNER JOIN [LABOR-PROD12]..SC5040 C5 WITH(NOLOCK) ON C5.C5_FILIAL = E1.E1_FILIAL AND C5.C5_NUM = E1.E1_PEDIDO AND E1.D_E_L_E_T_ = '' 
			WHERE 
				E1.E1_EMISSAO BETWEEN convert(varchar,convert(date,@DTA_DE,102),112) AND convert(varchar,convert(date,@DTA_ATE,102),112) AND
				E1.D_E_L_E_T_ = '' 
		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	--ORDER BY codigoFilial, titulo, prefixo, dataEmissao

END
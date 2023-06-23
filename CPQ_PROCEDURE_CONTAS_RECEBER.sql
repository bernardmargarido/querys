USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_contas_receber]    Script Date: 15/05/2023 11:44:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[cpq_contas_receber]
	-- Add the parameters for the stored procedure here
@IDPAGESIZE int,
@IDPAGE int,
@IDCLIENTE int,
@TP_TITULO int, -- 1-aberto; 2-baixado; 3-vencidos; 4-a vencer
@DTA_DE varchar(10),
@DTA_ATE varchar(10)

AS

BEGIN

-- ID cliente informado
IF @IDCLIENTE > 0 
	-- Titulos em aberto
	IF @TP_TITULO = 1 
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

	-- Titulos baixados
	ELSE IF @TP_TITULO = 2
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

	-- Titulos vencidos
	ELSE IF @TP_TITULO = 3 
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
				E1.E1_VENCREA <= convert(varchar,convert(date, GETDATE(),102),112) AND
				E1.E1_BAIXA = '' AND
				E1.E1_SALDO > 0 AND 
				E1.D_E_L_E_T_ = '' 
			)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	-- Titulos a vencer
	ELSE IF @TP_TITULO = 4 
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
				E1.E1_VENCREA > convert(varchar,convert(date, GETDATE(),102),112) AND
				E1.E1_BAIXA = '' AND
				E1.E1_SALDO > 0 AND 
				E1.D_E_L_E_T_ = '' 
			)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	-- Todos os titulos do cliente
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
				--E1.E1_EMISSAO BETWEEN convert(varchar,convert(date,@DTA_DE,102),112) AND convert(varchar,convert(date,@DTA_ATE,102),112) AND
				E1.D_E_L_E_T_ = '' 
	
		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	--ORDER BY codigoFilial, titulo, prefixo, dataEmissao

-- Sem ID do cliente informado
ELSE
	-- Titulos em aberto 
	IF @TP_TITULO = 1 
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
				E1.E1_SALDO > 0 AND
				E1.D_E_L_E_T_ = '' 

		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	-- Titulos baixados 
	ELSE IF @TP_TITULO = 2
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

	-- Titulos vencidos 
	ELSE IF @TP_TITULO = 3
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
				E1.E1_VENCREA <= convert(varchar,convert(date, GETDATE(),102),112) AND
				E1.E1_BAIXA = '' AND
				E1.E1_SALDO > 0 AND 
				E1.D_E_L_E_T_ = '' 
		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	-- Titulos a vencer
	ELSE IF @TP_TITULO = 4
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
				E1.E1_VENCREA > convert(varchar,convert(date, GETDATE(),102),112) AND
				E1.E1_BAIXA = '' AND
				E1.E1_SALDO > 0 AND 
				E1.D_E_L_E_T_ = '' 
		)CONTAS_RECEBER
		WHERE	
			rNum > @IDPAGESIZE * (@IDPAGE - 1) 

	-- Todos os titulos
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

--exec dbo.cpq_contas_receber 10000,1,0,3,'',''
EXEC cpq_contas_receber 1000000, 1, 35257,5,'',''
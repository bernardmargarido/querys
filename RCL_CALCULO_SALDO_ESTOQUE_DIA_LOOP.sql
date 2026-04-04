CREATE OR ALTER PROC [dbo].[CORP_CALCSALDO_RANGE]
    @DATAFIM_FINAL VARCHAR(10),
    @FILIAL  VARCHAR(4),
    @LOCAL   VARCHAR(2),
	@TIPO_CALC CHAR(1) = 'M' 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @DATA_ATUAL DATE,
        @DATA_FIM_MES DATE,
		@DATA_INI DATE,
		@MES_ATUAL CHAR(6),
        @MES_REFERENCIA CHAR(6),
		@DATAINI_STR VARCHAR(8),
        @DATAFIM_STR VARCHAR(8);

    -- Cria tabela fixa caso não exista
    IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'inventory_corp')
    BEGIN
        CREATE TABLE dbo.inventory_corp (
            ID_HISTORICO INT IDENTITY(1,1) PRIMARY KEY,
            ID_Business VARCHAR(20),
            filial VARCHAR(4),
            ID_SKU VARCHAR(40),
            produto VARCHAR(40),
            armazem VARCHAR(10),
            saldo DECIMAL(18,4),
            valor_atual DECIMAL(18,4),
            custo_medio DECIMAL(18,6),
            data_estoque DATE,
			data_calculo DATE,
            R_E_C_N_O_ INT,
            data_execucao DATETIME DEFAULT GETDATE()
        );

        CREATE INDEX IX_CORP_SALDO_HISTORICO ON dbo.inventory_corp (filial, armazem, produto, data_estoque);
    END;

	--------------------------------------
	-- Cálculo diario, somente uma vez 
	---------------------------------------
	IF @TIPO_CALC = 'D'
	BEGIN
        SET @DATA_ATUAL = CAST(@DATAFIM_FINAL AS DATE);
        SET @DATA_INI = EOMONTH(DATEADD(MONTH, -1, @DATA_ATUAL));

        SET @DATAINI_STR = CONVERT(VARCHAR(8), @DATA_INI, 112);
        SET @DATAFIM_STR = CONVERT(VARCHAR(8), @DATA_ATUAL, 112);

        PRINT CONCAT('Cálculo diário de ', @DATAINI_STR, ' até ', @DATAFIM_STR);

        -- Remove registros anteriores (reprocessamento)
        DELETE FROM dbo.inventory_corp
        WHERE filial = @FILIAL
          AND armazem = @LOCAL
          AND data_estoque = @DATA_INI
          AND data_calculo = @DATA_ATUAL;

        -- Insere novos resultados
        INSERT INTO dbo.inventory_corp
            (ID_Business, filial, ID_SKU, produto, armazem, saldo, valor_atual, 
             custo_medio, data_estoque, data_calculo, R_E_C_N_O_)
        EXEC [dbo].[CORP_CALCSALDO]
            @DATAINI = @DATAINI_STR,
            @DATAFIM = @DATAFIM_STR,
            @FILIAL  = @FILIAL,
            @LOCAL   = @LOCAL;

        PRINT 'Cálculo diário finalizado com sucesso!';
        RETURN;
    END;

	----------------------------------
	-- Modo mensal (loop dia a dia)
	----------------------------------

	-- Pega o último dia do mês anterior à data inicial
	--SET @DATA_ATUAL = DATEFROMPARTS(YEAR(DATEADD(DAY, 1-DAY(@DATAFIM_FINAL), @DATAFIM_FINAL)), 1, 1);
    
	SET @DATA_ATUAL = DATEADD(DAY, 1, EOMONTH(DATEADD(MONTH, -1, @DATAFIM_FINAL)));
    SET @MES_REFERENCIA = FORMAT(@DATA_ATUAL, 'yyyyMM');
    SET @DATA_INI = EOMONTH(DATEADD(MONTH, -1, @DATA_ATUAL));


	-- Inicializa a data de cálculo (primeiro dia após o fechamento anterior)
	--SET @DATA_ATUAL = DATEADD(DAY, 1, @DATA_INI);

    -- Loop de cálculo mês a mês
    WHILE @DATA_ATUAL <= CAST(@DATAFIM_FINAL AS DATE)
    BEGIN
        SET @MES_ATUAL = FORMAT(@DATA_ATUAL, 'yyyyMM');

        -- Se o mês mudou, muda a data inicial para o fechamento do mês anterior
        IF @MES_ATUAL <> @MES_REFERENCIA
		BEGIN
            SET @DATA_INI = EOMONTH(DATEADD(MONTH, -1, @DATA_ATUAL));
            SET @MES_REFERENCIA = @MES_ATUAL;
        END;

        PRINT CONCAT('Calculando de ', CONVERT(VARCHAR(10), @DATA_INI, 103),
                     ' até ', CONVERT(VARCHAR(10), @DATA_ATUAL, 103));

        -- Remove saldos já calculados (caso reprocessar o mesmo período)
        DELETE FROM dbo.inventory_corp
        WHERE filial = @FILIAL
          AND armazem = @LOCAL
          AND data_estoque = @DATA_INI
		  AND data_calculo = @DATA_ATUAL;

		-- 5. Prepara as datas no formato esperado (YYYYMMDD)
		SET @DATAINI_STR = CONVERT(VARCHAR(8), @DATA_INI, 112);
        SET @DATAFIM_STR = CONVERT(VARCHAR(8), @DATA_ATUAL, 112);

        -- Insere novos resultados do período
		INSERT INTO dbo.inventory_corp
			(ID_Business, filial, ID_SKU, produto, armazem, saldo, valor_atual, custo_medio, data_estoque, data_calculo, R_E_C_N_O_ )
		EXEC [dbo].[CORP_CALCSALDO]
			@DATAINI = @DATAINI_STR,
			@DATAFIM = @DATAFIM_STR,
			@FILIAL  = @FILIAL,
			@LOCAL   = @LOCAL
						
        -- Avança para o próximo dia
        SET @DATA_ATUAL = DATEADD(DAY, 1, @DATA_ATUAL);
    END;

    PRINT 'Processamento finalizado com sucesso!';
END;
GO


EXEC [dbo].[CORP_CALCSALDO_RANGE]
    @DATAFIM_FINAL = '20251008',
    @FILIAL = '0101',
    @LOCAL = '01',
	@TIPO_CALC = 'M';

select * from inventory_corp where produto = '0011303-015' and data_calculo between '2025-10-01' and '2025-10-08' order by R_E_C_N_O_


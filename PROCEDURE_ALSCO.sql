CREATE PROCEDURE [dbo].[LOCAL_MARCA_EXPORTADO]
    @A1_FILIAL  VARCHAR(4),
    @A1_COD     VARCHAR(6),
    @A1_LOJA    VARCHAR(4)  = '0001',
    @RESULTADO  INT         OUTPUT,
    @MENSAGEM   NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    -- Data de exportação no formato AAAAMMDD exigido pelo Protheus
    DECLARE @DATA_EXPORT VARCHAR(8);
    SET @DATA_EXPORT = CONVERT(VARCHAR(8), GETDATE(), 112);  -- 112 = yyyymmdd

    -- Validação dos parâmetros obrigatórios
    IF LTRIM(RTRIM(ISNULL(@A1_COD, ''))) = ''
    BEGIN
        SET @RESULTADO = 2;
        SET @MENSAGEM  = 'Parâmetro A1_COD não informado.';
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica se o cliente existe e está ativo
        IF NOT EXISTS (
            SELECT 1
            FROM   dbo.SA1990
            WHERE A1_FILIAL = @A1_FILIAL  
                AND A1_COD     = @A1_COD
                AND  A1_LOJA    = @A1_LOJA
        )
        BEGIN
            ROLLBACK TRANSACTION;
            SET @RESULTADO = 1;
            SET @MENSAGEM  = CONCAT(
                'Cliente não encontrado ou inativo: A1_COD=', @A1_COD,
                ' / A1_LOJA=', @A1_LOJA
            );
            RETURN;
        END

        -- Atualiza o campo de controle de exportação
        UPDATE dbo.SA1990
        SET    A1_MSEXP      = @DATA_EXPORT
        WHERE  
            A1_FILIAL       = @A1_FILIAL
            AND A1_COD      = @A1_COD
            AND  A1_LOJA    = @A1_LOJA;
          

        COMMIT TRANSACTION;

        SET @RESULTADO = 0;
        SET @MENSAGEM  = CONCAT(
            'Cliente exportado com sucesso: A1_COD=', @A1_COD,
            ' / A1_LOJA=', @A1_LOJA,
            ' / DATA=', @DATA_EXPORT
        );

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @RESULTADO = 2;
        SET @MENSAGEM  = CONCAT(
            'Erro ao marcar exportação: ',
            ERROR_MESSAGE(),
            ' (Linha: ', ERROR_LINE(), ')'
        );
    END CATCH
END;
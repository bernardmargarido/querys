CREATE FUNCTION [dbo].[fncMostra_Caracteres_Ocultos](
    @String VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN

    DECLARE 
        @Result VARCHAR(MAX) = '', 
        @Contador INT = 1,
        @Total INT,
        @AdicionarBarra BIT = 0
    
    
    SET @Total = LEN(@String)

    WHILE(@Contador <= @Total)
    BEGIN
        
        IF (PATINDEX('%[^ !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ\^_`abcdefghijklmnopqrstuvwxyz|{}~€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ[[]%', SUBSTRING(REPLACE(@String, ']', ''), @Contador, 1)) > 0)
        BEGIN
            SET @Result += (CASE WHEN @AdicionarBarra = 1 THEN ' | ' ELSE '' END) + 'Pos ' + CAST(@Contador AS VARCHAR(100)) + ': CHAR(' + CAST(ASCII(SUBSTRING(@String, @Contador, 1)) AS VARCHAR(5)) + ')'
            SET @AdicionarBarra = 1
        END

        SET @Contador += 1

    END
    
    RETURN @Result

END
GO
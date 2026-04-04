SELECT
cNmColuna = C.name
    ,cTpColuna = UPPER(TYPE_NAME(C.user_type_id))
    ,iMaxDigit = CASE
                    WHEN T.precision = 0
                    THEN C.max_length
                    ELSE T.precision
                 END
FROM sys.all_columns C WITH(NOLOCK)
    INNER JOIN sys.types T WITH(NOLOCK) ON T.user_type_id = C.user_type_id
    WHERE C.object_id = Object_Id('TMS_NOTAS')




ALTER TABLE dbo.TMS_NOTAS ALTER COLUMN nota_operacao_fiscal VARCHAR(50)


SELECT * FROM TMS_COLETA WHERE coleta_numero in('603162','606207','606346','606141','606189','606178')
delete FROM TMS_COLETA WHERE coleta_numero = '606178' 
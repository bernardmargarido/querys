USE msdb;
GO

EXEC dbo.sp_add_job
    @job_name = 'atualizar_saldos_contabeis',
    @enabled = 1,
    @description = 'Executa a procedure de atualização de saldos contábeis mensalmente',
    @start_step_id = 1;
GO

EXEC sp_add_jobstep
    @job_name = 'atualizar_saldos_contabeis',
    @step_name = 'Executar Procedure',
    @subsystem = 'TSQL',
    @command = '
DECLARE @ANO CHAR(4) = CAST(YEAR(GETDATE()) AS CHAR(4));
DECLARE @MES CHAR(2) = FORMAT(DATEADD(MONTH, -1, GETDATE()), ''MM'');
EXEC dbo.bunzl_saldoscontacontabil @ANO, @MES;
',
    @database_name = 'protheus-prod-db',  -- Substitua pelo nome do seu banco
    @retry_attempts = 0,
    @retry_interval = 0;
GO

EXEC sp_attach_schedule
    @job_name = 'atualizar_saldos_contabeis',
    @schedule_name = 'Todo dia 5 às 07:00';
GO

EXEC sp_add_jobserver
    @job_name = 'atualizar_saldos_contabeis';
GO
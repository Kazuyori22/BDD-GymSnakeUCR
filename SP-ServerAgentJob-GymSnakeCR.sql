------------------------------------SQL Server Agent Job----------------------------------------------------------

USE msdb;
GO

EXEC sp_add_job  
    @job_name = N'ActualizarMembresiasVencidas';  

EXEC sp_add_jobstep  
    @job_name = N'ActualizarMembresiasVencidas',  
    @step_name = N'Expirar Membresías',  
    @subsystem = N'TSQL',  
    @command = N'UPDATE Membresia SET estado = ''Expirada'' WHERE fechaFin < CAST(GETDATE() AS DATE) AND estado = ''Activa'';',  
    @database_name = N'GymSnake';  

EXEC sp_add_schedule  
    @schedule_name = N'EjecucionDiaria',  
    @freq_type = 4,  -- diario
    @freq_interval = 1,  
    @active_start_time = 000000;  -- 12:00 AM  

EXEC sp_attach_schedule  
    @job_name = N'ActualizarMembresiasVencidas',  
    @schedule_name = N'EjecucionDiaria';  

EXEC sp_add_jobserver  
    @job_name = N'ActualizarMembresiasVencidas';  
GO
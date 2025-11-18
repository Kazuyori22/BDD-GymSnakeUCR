------------------------------------PROCEDIMIENTOS ALMACENADOS CLIENTE-----------------------------------------------------------------------

INSERT INTO Cliente (cedulaCliente, nombre, primerApellido, segundoApellido, fechaNacimiento, correo, telefono, fechaRegistro, rutaFotoCliente) VALUES
(234567890, 'Cliente2', 'Perez', 'Gomez', '1995-07-15', 'cliente2@gmail.com', 87654321, '2025-10-09', NULL),
(345678901, 'Cliente3', 'Rodriguez', 'Lopez', '1988-11-23', 'cliente3@gmail.com', 23456789, '2025-10-09', NULL),
(456789012, 'Cliente4', 'Martinez', 'Sanchez', '2000-02-10', 'cliente4@gmail.com', 34567890, '2025-10-09', NULL),
(567890123, 'Cliente5', 'Gonzalez', 'Ramirez', '1992-05-05', 'cliente5@gmail.com', 45678901, '2025-10-09', NULL),
(678901234, 'Cliente6', 'Hernandez', 'Vargas', '1998-08-18', 'cliente6@gmail.com', 56789012, '2025-10-09', NULL),
(789012345, 'Cliente7', 'Lopez', 'Molina', '1985-01-30', 'cliente7@gmail.com', 67890123, '2025-10-09', NULL),
(890123456, 'Cliente8', 'Diaz', 'Ortiz', '1999-09-12', 'cliente8@gmail.com', 78901234, '2025-10-09', NULL),
(901234567, 'Cliente9', 'Torres', 'Castillo', '2001-12-25', 'cliente9@gmail.com', 89012345, '2025-10-09', NULL),
(112345678, 'Cliente10', 'Alvarado', 'Jimenez', '1997-04-07', 'cliente10@gmail.com', 90123456, '2025-10-09', NULL);

--------------------------------------------------INSERTAR-----------------------------------------------------------------------------------
CREATE PROCEDURE InsertCliente
    @CedulaCliente INT,
    @Nombre VARCHAR(30),
    @PrimerApellido VARCHAR(30),
    @SegundoApellido VARCHAR(30) = NULL,
    @FechaNacimiento DATE = NULL,
    @Correo VARCHAR(100) = NULL,
	@Contrasenia VARCHAR(255),
    @Telefono VARCHAR(20) = NULL,
    @RutaFotoCliente VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO Cliente (
            cedulaCliente,
            nombre,
            primerApellido,
            segundoApellido,
            fechaNacimiento,
            correo,
			contrasenia,
            telefono,
            fechaRegistro,
            rutaFotoCliente
        )
        VALUES (
            @CedulaCliente,
            @Nombre,
            @PrimerApellido,
            @SegundoApellido,
            @FechaNacimiento,
            @Correo,
			@Contrasenia,
            @Telefono,
            GETDATE(), -- FechaRegistro autom�tica
            @RutaFotoCliente
        );

        -- Retornar 1 = �xito
        SELECT CAST(1 AS BIT) AS Resultado;
    END TRY
    BEGIN CATCH
        -- Retornar 0 = error (por ejemplo, cedula duplicada)
        SELECT CAST(0 AS BIT) AS Resultado;
    END CATCH
END
GO
----------------------------------------------------------------LEER--------------------------------------------------------------------------
CREATE PROCEDURE GETALLClientes
AS
BEGIN
    SET NOCOUNT ON;

    -- Clientes
    SELECT
        idCliente,
        cedulaCliente,
        nombre,
        primerApellido,
        segundoApellido,
        fechaNacimiento,
        correo,
        telefono,
        fechaRegistro,
        rutaFotoCliente
    FROM Cliente;

    -- Medidas corporales
    SELECT
        idMedidaCorporal,
        cedulaCliente,
        altura,
        peso,
        fechaCreacion,
        rutaArchivoMedida
    FROM MedidaCorporal;

    -- Rutinas
    SELECT
        idRutina,
        cedulaEntrenador,
        cedulaCliente,
        nombreRutina,
        descripcion,
        fechaCreacion,
        fechaVencimiento,
        objetivo,
        archivoRutina
    FROM Rutina;

    -- Membres�as
    SELECT
        idMembresia,
        cedulaCliente,
        precio,
        fechaInicio,
        fechaFin,
        estado,
        cedulaEntrenador
    FROM Membresia;

    -- Citas de medici�n
    SELECT
        idCita,
        cedulaCliente,
        cedulaEntrenador,
        fecha,
        hora,
        estado
    FROM CitaMedicion;
END
GO

--------------------------------------------------ACTUALIZAR----------------------------------------------------------------------------------
CREATE PROCEDURE UpdateCliente
    @CedulaCliente INT,
    @Nombre VARCHAR(30),
    @PrimerApellido VARCHAR(30),
    @SegundoApellido VARCHAR(30) = NULL,
    @FechaNacimiento DATE = NULL,
    @Correo VARCHAR(100) = NULL,
    @Contrasenia VARCHAR(255),
    @Telefono VARCHAR(20) = NULL,
    @RutaFotoCliente VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE Cliente
        SET
            nombre = @Nombre,
            primerApellido = @PrimerApellido,
            segundoApellido = @SegundoApellido,
            fechaNacimiento = @FechaNacimiento,
            correo = @Correo,
            contrasenia = @Contrasenia,
            telefono = @Telefono,
            rutaFotoCliente = @RutaFotoCliente
        WHERE cedulaCliente = @CedulaCliente;

        -- Verifica si se actualiz� alg�n registro
        IF @@ROWCOUNT > 0
            SELECT CAST(1 AS BIT) AS Resultado; -- �xito
        ELSE
            SELECT CAST(0 AS BIT) AS Resultado; -- No se encontr� el cliente
    END TRY
    BEGIN CATCH
        SELECT CAST(0 AS BIT) AS Resultado; -- Error
    END CATCH
END
GO

------------------------------------------------ELIMINAR--------------------------------------------------------------------------------------
CREATE PROCEDURE DeleteCliente
    @CedulaCliente INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM Cliente
        WHERE cedulaCliente = @CedulaCliente;

        -- Verifica si se elimin� alg�n registro
        IF @@ROWCOUNT > 0
            SELECT CAST(1 AS BIT) AS Resultado; -- �xito
        ELSE
            SELECT CAST(0 AS BIT) AS Resultado; -- No se encontr� el cliente
    END TRY
    BEGIN CATCH
        SELECT CAST(0 AS BIT) AS Resultado; -- Error
    END CATCH
END
GO
---------------------------------FIN PROCEDIMIENTOS ALMACENADOS CLIENTE------------------------------------------------------------------------



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
    @freq_type = 4,  
    @freq_interval = 1,  
    @active_start_time = 000000; 

EXEC sp_attach_schedule  
    @job_name = N'ActualizarMembresiasVencidas',  
    @schedule_name = N'EjecucionDiaria';  

EXEC sp_add_jobserver  
    @job_name = N'ActualizarMembresiasVencidas';  
GO


------------------------------------SQL Server Agent Job----------------------------------------------------------



------------------------------------Nuevos----------------------------------------------------------


CREATE OR ALTER PROCEDURE ResetPassword
(
    @Correo VARCHAR(100),
    @NewPassword VARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar si el correo existe
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE correo = @Correo)
    BEGIN
        SELECT 0 AS Exito, 'El correo no está registrado.' AS Mensaje;
        RETURN;
    END

    -- Actualizar contraseña (hash)
    UPDATE Cliente
    SET contrasenia = @NewPassword
    WHERE correo = @Correo;

    SELECT 1 AS Exito, 'Contraseña actualizada correctamente.' AS Mensaje;
END


CREATE PROCEDURE GetClienteByEmail
(
    @Correo VARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        cedulaCliente,
        nombre,
        primerApellido,
        segundoApellido,
        fechaNacimiento,
        correo,
        contrasenia,
        telefono,
        fechaRegistro,
        rutaFotoCliente
    FROM Cliente
    WHERE correo = @Correo;
END

ALTER TABLE Cliente
ALTER COLUMN contrasenia VARCHAR(255);

DROP PROCEDURE InsertCliente
DROP PROCEDURE UpdateCliente
--Eliminar esos 2 procedimietos y volver a correrlos (Ya están actualizados) Gracias


CREATE PROCEDURE GetClienteByCedula
    @CedulaCliente INT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1) Cliente
    SELECT 
        c.idCliente,
        c.cedulaCliente,
        c.nombre,
        c.primerApellido,
        c.segundoApellido,
        c.fechaNacimiento,
        c.correo,
        c.contrasenia,
        c.telefono,
        c.fechaRegistro,
        c.rutaFotoCliente
    FROM dbo.Cliente AS c
    WHERE c.cedulaCliente = @CedulaCliente;

    -- Membresías del cliente
    SELECT 
        mb.idMembresia,
        mb.cedulaCliente,
        mb.precio,
        mb.fechaInicio,
        mb.fechaFin,
        mb.estado,
        mb.cedulaEntrenador
    FROM dbo.Membresia AS mb
    WHERE mb.cedulaCliente = @CedulaCliente
    ORDER BY mb.fechaInicio DESC;
END
GO
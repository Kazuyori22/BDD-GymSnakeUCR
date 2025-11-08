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
	@Contrasenia VARCHAR(50),
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
            GETDATE(), -- FechaRegistro automática
            @RutaFotoCliente
        );

        -- Retornar 1 = éxito
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

    -- Membresías
    SELECT
        idMembresia,
        cedulaCliente,
        precio,
        fechaInicio,
        fechaFin,
        estado,
        cedulaEntrenador
    FROM Membresia;

    -- Citas de medición
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
    @Contrasenia VARCHAR(50),
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

        -- Verifica si se actualizó algún registro
        IF @@ROWCOUNT > 0
            SELECT CAST(1 AS BIT) AS Resultado; -- Éxito
        ELSE
            SELECT CAST(0 AS BIT) AS Resultado; -- No se encontró el cliente
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

        -- Verifica si se eliminó algún registro
        IF @@ROWCOUNT > 0
            SELECT CAST(1 AS BIT) AS Resultado; -- Éxito
        ELSE
            SELECT CAST(0 AS BIT) AS Resultado; -- No se encontró el cliente
    END TRY
    BEGIN CATCH
        SELECT CAST(0 AS BIT) AS Resultado; -- Error
    END CATCH
END
GO
---------------------------------FIN PROCEDIMIENTOS ALMACENADOS CLIENTE------------------------------------------------------------------------
---------------------------------PROCEDIMIENTOS ALMACENADOS MEMBRESIA-------------------------------

--------------------------------------------INSERTAR-------------------------------------

CREATE OR ALTER PROCEDURE InsertarMembresia
    @idMembresia INT,              -- Se recibe, pero no se usa para insertar
    @cedulaCliente INT,
    @precio FLOAT,
    @fechaInicio DATE,
    @fechaFin DATE,
    @estado VARCHAR(10),
    @cedulaEntrenador INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevoId INT;

    BEGIN TRY
        -- Validar que exista el cliente
        IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cedulaCliente = @cedulaCliente)
        BEGIN
            RAISERROR('El cliente no existe.', 16, 1);
            RETURN;
        END;

        -- Validar que exista el entrenador
        IF NOT EXISTS (SELECT 1 FROM Entrenador WHERE cedulaEntrenador = @cedulaEntrenador)
        BEGIN
            RAISERROR('El entrenador no existe.', 16, 1);
            RETURN;
        END;

        -- Calcular el nuevo ID secuencial
        SELECT @nuevoId = ISNULL(MAX(idMembresia), 0) + 1 FROM Membresia;

        -- Insertar la membresía
        INSERT INTO Membresia (idMembresia, cedulaCliente, precio, fechaInicio, fechaFin, estado, cedulaEntrenador)
        VALUES (@nuevoId, @cedulaCliente, @precio, @fechaInicio, @fechaFin, @estado, @cedulaEntrenador);

        -- Devolver la membresía recién creada
        SELECT 
            m.idMembresia,
            m.cedulaCliente,
            m.precio,
            m.fechaInicio,
            m.fechaFin,
            m.estado,
            m.cedulaEntrenador
        FROM Membresia m
        WHERE m.idMembresia = @nuevoId;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH;
END;
GO
--------------------------------------------LERR-------------------------------------
--------------------------------------------ACTUALIZAR-------------------------------------
--------------------------------------------ELIMINAR-------------------------------------

CREATE OR ALTER PROCEDURE EliminarMembresiaPorId
    @idMembresia INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @resultado INT = 0;

    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Membresia WHERE idMembresia = @idMembresia)
        BEGIN
            DELETE FROM Membresia WHERE idMembresia = @idMembresia;
            SET @resultado = 1;
        END
    END TRY
    BEGIN CATCH
        SET @resultado = 0;
    END CATCH;

    RETURN @resultado;
END;
GO


-------------------------------FIN PROCEDIMIENTOS ALMACENADOS MEMBRESIA-----------------------------

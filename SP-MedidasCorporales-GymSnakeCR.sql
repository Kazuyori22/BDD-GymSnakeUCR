USE GYMSNAKE 

CREATE PROCEDURE spObtenerMedidasPorCliente
    @cedulaCliente INT
AS
BEGIN
    SELECT 
        idMedidaCorporal,
        cedulaCliente,
        altura,
        peso,
        fechaCreacion,
        rutaArchivoMedida
    FROM MedidaCorporal
    WHERE cedulaCliente = @cedulaCliente
    ORDER BY fechaCreacion DESC;
END;
GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE sp_RegistrarMedicionCorporal
    @CedulaCliente INT,
    @Altura DECIMAL(6,2),
    @Peso DECIMAL(5,2),
    @RutaArchivoMedida NVARCHAR(300),
    @IdCita INT,
    @IdMedidaGenerada INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar medición corporal
    INSERT INTO MedidaCorporal (cedulaCliente, altura, peso, rutaArchivoMedida, fechaCreacion)
    VALUES (@CedulaCliente, @Altura, @Peso, @RutaArchivoMedida, GETDATE());

    -- Recuperar el ID generado
    SET @IdMedidaGenerada = SCOPE_IDENTITY();

    -- Actualizar estado de la cita a Completada
    UPDATE CitaMedicion
    SET estado = 'Completada'
    WHERE idCita = @IdCita;
END;
GO


----------------------------------------------------------------------------------------------------
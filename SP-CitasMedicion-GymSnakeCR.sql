
-- Procedimeinto almacenado para crear las citas de medicion por parte del cliente
CREATE PROCEDURE sp_CrearCitaMedicion
    @CedulaCliente INT,
    @CedulaEntrenador INT,
    @Fecha DATE,
    @Hora TIME,
    @Estado VARCHAR(30) = 'Pendiente',
    @IdCitaGenerada INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO CitaMedicion (cedulaCliente, cedulaEntrenador, fecha, hora, estado)
    VALUES (@CedulaCliente, @CedulaEntrenador, @Fecha, @Hora, @Estado);

    SET @IdCitaGenerada = SCOPE_IDENTITY();
END;

----------------------------------------------------------------------------------------------------
-- El administrados obtendrá las citas pendientes para verlas
CREATE OR ALTER PROCEDURE sp_ObtenerCitasPendientes
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.idCita,
        c.cedulaCliente,
        cli.nombre AS NombreCliente,
        cli.primerApellido AS PrimerApellidoCliente,
        cli.segundoApellido AS SegundoApellidoCliente,
        c.cedulaEntrenador,
        e.nombre AS NombreEntrenador,
        e.primerApellido AS PrimerApellidoEntrenador,
        e.segundoApellido AS SegundoApellidoEntrenador,
        c.fecha,
        c.hora,
        c.estado
    FROM CitaMedicion c
    INNER JOIN Cliente cli ON c.cedulaCliente = cli.cedulaCliente
    INNER JOIN Entrenador e ON c.cedulaEntrenador = e.cedulaEntrenador
    WHERE c.estado = 'Pendiente'
    ORDER BY c.fecha, c.hora;
END;
GO

EXEC sp_ObtenerCitasPendientes;

----------------------------------------------------------------------------------------------------
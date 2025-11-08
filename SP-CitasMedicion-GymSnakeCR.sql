

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

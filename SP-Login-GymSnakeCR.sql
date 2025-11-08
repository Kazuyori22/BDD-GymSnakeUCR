-------------------------------LOGIN-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE ObtenerClientePorCorreo
    @Correo NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 *
    FROM Cliente
    WHERE Correo = @Correo;
END

-----------------------------------------------------------------------------------------

CREATE PROCEDURE ValidarLoginCliente
    @Correo NVARCHAR(100),
    @Contrasenia NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        CedulaCliente,
        Nombre,
        PrimerApellido,
        SegundoApellido,
        FechaNacimiento,
        Correo,
        Telefono,
        FechaRegistro,
        RutaFotoCliente
    FROM Cliente
    WHERE Correo = @Correo
      AND Contrasenia = @Contrasenia;
END;
GO

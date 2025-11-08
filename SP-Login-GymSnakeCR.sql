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
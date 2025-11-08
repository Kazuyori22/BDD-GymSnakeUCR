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

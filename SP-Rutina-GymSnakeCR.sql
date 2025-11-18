---------------------------------PROCEDIMIENTOS ALMACENADOS RUTINA-------------------------------------------------------------------------------
--------------------------------------------INSERTAR---------------------------------------------------------------------------------------------
Create procedure spRegistrarRutina 
                @cedulaEntrenador int,
                @cedulaCliente int,
			    @nombreRutina varchar(30),
                @descripcion varchar(100),
                @fechaCreacion date,
				@objetivo varchar(50),  
                @archivoRutina varchar(255),
                @fechaVencimiento date
as
begin
	insert into Rutina(
                    cedulaEntrenador,   
                    cedulaCliente,
                    nombreRutina,
                    descripcion,
                    fechaCreacion,
					objetivo,
                    archivoRutina,
                    fechaVencimiento)
		        values(
                    @cedulaEntrenador,
                    @cedulaCliente,
                    @nombreRutina,
                    @descripcion,
                    @fechaCreacion,
					@objetivo,
                    @archivoRutina,
                    @fechaVencimiento);
end;

-------------------------------------------ACTUALIZAR--------------------------------------------------------------------------------------------
Create procedure spActualizarRutina 
                    @idRutina int,
                    @cedulaEntrenador int,
                    @cedulaCliente int,
					@nombreRutina varchar(30),
                    @descripcion varchar(100),
                    @fechaCreacion date,
					@objetivo varchar(50),
                    @archivoRutina varchar(255),
                    @fechaVencimiento date
as
begin
	UPDATE Rutina
	SET 
        cedulaEntrenador=@cedulaEntrenador,
        cedulaCliente=@cedulaCliente,
		nombreRutina=@nombreRutina,
        descripcion=@descripcion,
        fechaCreacion=@fechaCreacion,
        objetivo=@objetivo,
		archivoRutina=@archivoRutina,
        fechaVencimiento=@fechaVencimiento
    WHERE idRutina=@idRutina;
END;

--------------------------------------------ELIMINAR---------------------------------------------------------------------------------------------
Create procedure spEliminarRutina  
                    @idRutina int
as
begin
	DELETE FROM Rutina
		WHERE  idRutina=@idRutina;
end;

--------------------------------------------BUSCAR-----------------------------------------------------------------------------------------------
CREATE PROCEDURE spObtenerRutina
AS
BEGIN
    SELECT 
        idRutina,
        cedulaEntrenador,
        cedulaCliente,
        nombreRutina,
        descripcion,
        fechaCreacion,
        objetivo,
        archivoRutina,
        fechaVencimiento
		FROM Rutina;
END;

-----------------------------------------BUSCAR POR ID------------------------------------------------------------------------------------------
CREATE PROCEDURE spObtenerRutinaPorID 
                    @idRutina int
AS
BEGIN
    SELECT 
        idRutina,
        cedulaEntrenador,
        cedulaCliente,
        nombreRutina,
        descripcion,
        fechaCreacion,
        objetivo,
        archivoRutina,
        fechaVencimiento
		FROM Rutina
		where idRutina=@idRutina;
END;

-----------------------------------------BUSCAR POR Cedula Cliente ---------------------------------------------------------------------------------------
CREATE PROCEDURE spObtenerRutinaPorCedulaCliente 
                    @cedulaCliente int
AS
BEGIN
    SELECT 
        idRutina,
        cedulaEntrenador,
        cedulaCliente,
        nombreRutina,
        descripcion,
        fechaCreacion,
        objetivo,
        archivoRutina,
        fechaVencimiento
		FROM Rutina
		where cedulaCliente=@cedulaCliente;
END;

-------------------------------FIN PROCEDIMIENTOS ALMACENADOS RUTINA---------------------------------------------------------------------------

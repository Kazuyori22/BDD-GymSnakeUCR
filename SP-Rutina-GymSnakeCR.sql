---------------------------------PROCEDIMIENTOS ALMACENADOS RUTINA-------------------------------------------------------------------------------
--------------------------------------------INSERTAR---------------------------------------------------------------------------------------------
Create procedure spRegistrarRutina @idRutina int,@cedulaEntrenador int,@cedulaCliente int,
					@nombreRutina varchar(30),@descripcion varchar(100),@fechaCreacion date,
					@objetivo varchar(50),@archivoRutina varchar(255),@fechaVencimiento date
as
begin
    set nocount on;
	insert into Rutina(idRutina,cedulaEntrenador,cedulaCliente,nombreRutina,descripcion,fechaCreacion,
					objetivo,archivoRutina,fechaVencimiento)
		values(@idRutina,@cedulaEntrenador,@cedulaCliente,@nombreRutina,@descripcion,@fechaCreacion,
					@objetivo,@archivoRutina,@fechaVencimiento);
end;

-------------------------------------------ACTUALIZAR--------------------------------------------------------------------------------------------
Create procedure spActualizarRutina @idRutina int,@cedulaEntrenador int,@cedulaCliente int,
					@nombreRutina varchar(30),@descripcion varchar(100),@fechaCreacion date,
					@objetivo varchar(50),@archivoRutina varchar(255),@fechaVencimiento date
as
begin
    set nocount on;
	UPDATE Rutina
	SET idRutina=@idRutina,cedulaEntrenador=@cedulaEntrenador,cedulaCliente=@cedulaCliente,
		nombreRutina=@nombreRutina,descripcion=@descripcion,fechaCreacion=@fechaCreacion,objetivo=@objetivo,
		archivoRutina=@archivoRutina,fechaVencimiento=@fechaVencimiento
    WHERE idRutina=@idRutina;
END;

--------------------------------------------ELIMINAR---------------------------------------------------------------------------------------------
Create procedure spEliminarRutina  @idRutina int
as
begin
    set nocount on;
	DELETE FROM Rutina
		WHERE  idRutina=@idRutina;
end;

--------------------------------------------BUSCAR-----------------------------------------------------------------------------------------------
CREATE PROCEDURE spObtenerRutina
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idRutina,cedulaEntrenador,cedulaCliente,nombreRutina,descripcion,fechaCreacion,objetivo,archivoRutina,fechaVencimiento
		FROM Rutina;
END;

-----------------------------------------BUSCAR POR ID------------------------------------------------------------------------------------------
CREATE PROCEDURE spObtenerRutinaPorID @idRutina int
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idRutina,cedulaEntrenador,cedulaCliente,nombreRutina,descripcion,fechaCreacion,objetivo,archivoRutina,fechaVencimiento
		FROM Rutina
		where idRutina=@idRutina;
END;

-------------------------------FIN PROCEDIMIENTOS ALMACENADOS RUTINA---------------------------------------------------------------------------
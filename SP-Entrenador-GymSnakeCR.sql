---------------------------------PROCEDIMIENTOS ALMACENADOS ENTRENADOR-------------------------------------------------------------------------
--------------------------------------------INSERTAR-------------------------------------------------------------------------------------------
Create procedure spRegistrarEntrenador 
                    @cedulaEntrenador int,
                    @nombre varchar(30),
                    @primerApellido varchar(30),
				    @segundoApellido varchar(30),
                    @especialidad varchar(30),
                    @correo varchar(30),
                    @telefono int,
                    @fotoRuta varchar(300)
as
begin
	insert into Entrenador(
                    cedulaEntrenador,
                    nombre,
                    primerApellido,
                    segundoApellido,
                    especialidad,
                    correo,
                    telefono,
                    fotoRuta)
		        values(
                    @cedulaEntrenador,
                    @nombre,
                    @primerApellido,
                    @segundoApellido,
                    @especialidad,
                    @correo,
                    @telefono,
                    @fotoRuta);
end;

-------------------------------------------ACTUALIZAR-------------------------------------------------------------------------------------------
Create procedure spActualizarEntrenador @cedulaEntrenador int,@nombre varchar(30),@primerApellido varchar(30),
				@segundoApellido varchar(30),@especialidad varchar(30),@correo varchar(30),@telefono int
as
begin
	UPDATE Entrenador
	SET cedulaEntrenador=@cedulaEntrenador,nombre=@nombre,primerApellido=@primerApellido,
		segundoApellido=@segundoApellido,especialidad=@especialidad,correo=@correo,telefono=@telefono
    WHERE cedulaEntrenador=@cedulaEntrenador;
END;

--------------------------------------------ELIMINAR---------------------------------------------------------------------------------------------
Create procedure spEliminarEntrenador @cedulaEntrenador int
as
begin
	DELETE FROM Entrenador
		WHERE cedulaEntrenador=@cedulaEntrenador;
end;
--------------------------------------------BUSCAR-----------------------------------------------------------------------------------------------
CREATE PROCEDURE spObtenerEntrenadores
AS
BEGIN
    SELECT cedulaEntrenador,nombre,primerApellido,segundoApellido,especialidad,correo,telefono
		FROM Entrenador;
END;

-----------------------------------------BUSCAR POR ID-------------------------------------------------------------------------------------------
CREATE PROCEDURE spObtenerEntrenadorPorID @cedulaEntrenador int
AS
BEGIN
    SELECT cedulaEntrenador,nombre,primerApellido,segundoApellido,especialidad,correo,telefono
		FROM Entrenador
		where cedulaEntrenador=@cedulaEntrenador;
END;
-------------------------------FIN PROCEDIMIENTOS ALMACENADOS ENTRENADOR-------------------------------------------------------------------------

-----------------------------------------PROCEDIMIENTOS ALMACENADOS PRODUCTOS------------------------------------------------------------------
--------------------------------------------INSERTAR-------------------------------------------------------------------------------------------
Create procedure spRegistrarProducto
	@nombreProducto varchar(30), 
	@descripcion varchar(100), 
	@precio float,
	@archivoAdjunto varchar(255)
as
begin
   
	insert into Producto(
	
	nombreProducto, 
	descripcion, 
	precio,
	archivoAdjunto
	) 
values(
	
	@nombreProducto, 
	@descripcion, 
	@precio,
	@archivoAdjunto
		);
end;

-------------------------------------------ACTUALIZAR------------------------------------------------------------------------------------------
Create procedure spActualizarProducto
	@idProducto int, 
	@nombreProducto varchar(30), 
	@descripcion varchar(100), 
	@precio float,
	@archivoAdjunto varchar(255)
as
begin
    
	UPDATE Producto 
	SET 
	nombreProducto=@nombreProducto, 
	descripcion=@descripcion, 
	precio=@precio,
	archivoAdjunto= @archivoAdjunto

    WHERE idProducto=@idProducto;
END;

--------------------------------------------ELIMINAR---------------------------------------------------------------------------------------------
create procedure spEliminarProducto  @idProducto int
as
begin
   
	DELETE FROM Producto
		WHERE  idProducto=@idProducto;
end;

--------------------------------------------BUSCAR-----------------------------------------------------------------------------------------------
CREATE PROCEDURE spObtenerProducto
AS
BEGIN
   
    SELECT idProducto, 
	nombreProducto, 
	descripcion, 
	precio,
	archivoAdjunto
		FROM Producto;
END;

-----------------------------------------BUSCAR POR ID-------------------------------------------------------------------------------------------
CREATE PROCEDURE spObtenerProductoPorID @idProducto int
AS
BEGIN
    
    SELECT 
	idProducto, 
	nombreProducto, 
	descripcion, 
	precio,
	archivoAdjunto
		FROM Producto
		where idProducto=@idProducto;
END;

-------------------------------FIN PROCEDIMIENTOS ALMACENADOS PRODUCTOS--------------------------------------------------------------------------
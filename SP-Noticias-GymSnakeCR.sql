---------------------------------PROCEDIMIENTOS ALMACENADOS NOTICIA-------------------------------
create procedure spInsertarNoticia
    @IdNoticia INT = NULL,
    @NombreNoticia NVARCHAR(30),
    @Descripcion NVARCHAR(100),
    @ArchivoAdjunto NVARCHAR(255),
    @FechaCreacion date
as
begin
    insert into noticia (nombrenoticia, descripcion, archivoadjunto, fechacreacion)
    values (@nombrenoticia, @descripcion, @archivoadjunto, @fechacreacion);
end;
--------------------------------------------INSERTAR-------------------------------------
create procedure spInsertarNoticia
    @IdNoticia INT = NULL,
    @NombreNoticia NVARCHAR(30),
    @Descripcion NVARCHAR(100),
    @ArchivoAdjunto NVARCHAR(255),
    @FechaCreacion date
as
begin
    insert into noticia (nombrenoticia, descripcion, archivoadjunto, fechacreacion)
    values (@nombrenoticia, @descripcion, @archivoadjunto, @fechacreacion);
end;
--------------------------------------------LERR-------------------------------------
create procedure spObtenerTodasLasNoticias
as
begin
    select * from noticia;
end;
--------------------------------------------ACTUALIZAR-------------------------------------
create procedure spActualizarNoticia
	@IdNoticia INT,
    @NombreNoticia NVARCHAR(30),
    @Descripcion NVARCHAR(100),
    @ArchivoAdjunto NVARCHAR(255),
    @FechaCreacion DATE
as
begin
    update Noticia
    set 
        NombreNoticia = @NombreNoticia,
        Descripcion = @Descripcion,
        ArchivoAdjunto = @ArchivoAdjunto,
        FechaCreacion = @FechaCreacion
    where IdNoticia = @IdNoticia;
end;
--------------------------------------------ELIMINAR-------------------------------------
CREATE PROCEDURE spEliminarNoticiaPorID
    @id INT
AS
BEGIN
    DELETE FROM Noticia
    WHERE IdNoticia = @id;
END;

--------------------------------------------LEER POR ID -------------------------------------
create procedure spBuscarNoticiaPorID
    @id int
as
begin
    select nombrenoticia, descripcion, archivoadjunto, fechacreacion
    from noticia
    where idNoticia = @id;
end;
-------------------------------FIN PROCEDIMIENTOS ALMACENADOS NOTICIA-----------------------------

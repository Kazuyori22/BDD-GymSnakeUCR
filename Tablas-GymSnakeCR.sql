create database GYMSNAKE
USE GYMSNAKE 

CREATE TABLE Cliente (
	idCliente INT IDENTITY(1,1),
    cedulaCliente INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    primerApellido VARCHAR(30) NOT NULL,
    segundoApellido VARCHAR(30) NULL,
    fechaNacimiento DATE NULL,
    correo VARCHAR(100) NULL,
	contrasenia VARCHAR(50),
    telefono VARCHAR(20) NULL,
    fechaRegistro DATE NOT NULL DEFAULT GETDATE(),
    rutaFotoCliente VARCHAR(255) NULL
);

create table Entrenador(
	idEntrenador INT IDENTITY(1,1),
	cedulaEntrenador INT PRIMARY KEY,
	nombre varchar(30) NOT NULL,
	primerApellido varchar(30) NOT NULL,
	segundoApellido varchar(30) NULL,
	especialidad varchar(30) NULL,
	correo varchar(30) NOT NULL,
	telefono int NOT NULL
);

create table Membresia(
	idMembresia int primary key,
	cedulaCliente int FOREIGN KEY REFERENCES Cliente(cedulaCliente),
	precio float not null,
	fechaInicio date not null,
	fechaFin date not null,
	estado varchar(10) not null,
	cedulaEntrenador int FOREIGN KEY REFERENCES Entrenador(cedulaEntrenador)
);

create table Rutina(
	idRutina int primary key,
	cedulaEntrenador int FOREIGN KEY REFERENCES Entrenador(cedulaEntrenador),
	cedulaCliente int FOREIGN KEY REFERENCES Cliente(cedulaCliente),
	nombreRutina varchar(30) not null,
	descripcion varchar(100) null,
	fechaCreacion date not null,
	objetivo varchar(50) not null,
	archivoRutina varchar(255) not null,
	fechaVencimiento date not null
);

CREATE TABLE MedidaCorporal (
    idMedidaCorporal INT IDENTITY(1,1) PRIMARY KEY,
    cedulaCliente INT NOT NULL,
    altura DECIMAL(6,2) NOT NULL,
    peso DECIMAL(5,2) NOT NULL,
    fechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    rutaArchivoMedida NVARCHAR(300) NOT NULL
);


create table CitaMedicion(
	idCita INT IDENTITY(1,1) PRIMARY KEY,
	cedulaCliente int FOREIGN KEY REFERENCES Cliente(cedulaCliente),
	cedulaEntrenador int FOREIGN KEY REFERENCES Entrenador(cedulaEntrenador),
	fecha date not null,
	hora time not null,
	estado varchar(30) not null
);

create table Noticia(
	idNoticia int Identity(1,1) primary key,
	nombreNoticia varchar(30) not null,
	descripcion varchar(100) not null,
	archivoAdjunto varchar(255) null,
	fechaCreacion date not null
);

create table Producto(
	idProducto int Identity(1,1) primary key,
	nombreProducto varchar(30) not null,
	descripcion varchar(100) null,
	precio float null,
	archivoAdjunto varchar(255) null
);
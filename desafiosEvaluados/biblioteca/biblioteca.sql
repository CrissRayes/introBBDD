\c CrissRayes
DROP DATABASE biblioteca;
-- 1.- Crear el modelo en una base de datos llamada biblioteca, considerando las tablas definidas y sus atributos. (2 puntos).

-- Primero se crea la base de datos
CREATE DATABASE biblioteca;

-- Luego nos movemos hacia la base de datos creada
\c biblioteca

-- Se crea la tabla socios
CREATE TABLE socios(
  rut VARCHAR(10) NOT NULL UNIQUE,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(9) NOT NULL,
  PRIMARY KEY(rut)
);

-- Se crea la tabla libros
CREATE TABLE libros(
  isbn VARCHAR(15) NOT NULL UNIQUE,
  titulo VARCHAR(100) NOT NULL,
  paginas INT NOT NULL,
  PRIMARY KEY (isbn)
);

-- Se crea la tabla préstamos
CREATE TABLE prestamos(
  socio_id VARCHAR,
  libro_id VARCHAR,
  fecha_prestamo DATE NOT NULL,
  fecha_devolucion DATE,
  FOREIGN KEY (socio_id) REFERENCES socios(rut),
  FOREIGN KEY (libro_id) REFERENCES libros(isbn)
);

-- Se crea la tabla autores
CREATE TABLE autores(
  id INT NOT NULL UNIQUE,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  fecha_muerte DATE,
  PRIMARY KEY(id)
);

-- Se crea la tabla tipos_autor
CREATE TABLE tipos_autor(
  id INT NOT NULL UNIQUE,
  tipo_autor VARCHAR(10) NOT NULL,
  PRIMARY KEY(id)
);

-- Se crea la tabla autores_libros
CREATE TABLE autores_libros(
  libro_id VARCHAR,
  autor_id INT,
  tipo_autor_id INT,
  FOREIGN KEY (libro_id) REFERENCES libros(isbn),
  FOREIGN KEY (autor_id) REFERENCES autores(id),
  FOREIGN KEY (tipo_autor_id) REFERENCES tipos_autor(id)
);

-- 2. Se deben insertar los registros en las tablas correspondientes (1 punto).

-- Insertando datos en la tabla socios
INSERT INTO socios (rut, nombre, apellido, direccion, telefono)
VALUES ('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1, SANTIAGO', '911111111');

INSERT INTO socios (rut, nombre, apellido, direccion, telefono)
VALUES ('2222222-2', 'ANA', 'PÉREZ', 'PASAJE 2, SANTIAGO', '922222222');

INSERT INTO socios (rut, nombre, apellido, direccion, telefono)
VALUES ('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2, SANTIAGO', '933333333');

INSERT INTO socios (rut, nombre, apellido, direccion, telefono)
VALUES ('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3, SANTIAGO', '944444444');

INSERT INTO socios (rut, nombre, apellido, direccion, telefono)
VALUES ('5555555-5', 'SILVANA', 'MUÑOZ', 'PASAJE 3, SANTIAGO', '955555555');

-- Verificando datos insertados
SELECT * FROM socios;


-- -- Insertando datos en la tabla libros
INSERT INTO libros (isbn, titulo, paginas)
VALUES ('111-1111111-111', 'CUENTOS DE TERROR', 344);

INSERT INTO libros (isbn, titulo, paginas)
VALUES ('222-2222222-222', 'POESÍAS CONTEMPORANEAS', 167);

INSERT INTO libros (isbn, titulo, paginas)
VALUES ('333-3333333-333', 'HISTORIA DE ASIA', 511);

INSERT INTO libros (isbn, titulo, paginas)
VALUES ('444-4444444-444', 'MANUAL DE MECÁNICA', 298);

-- Verificando datos insertados
SELECT * FROM libros;

-- -- Insertando datos en la tabla préstamos
INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
VALUES('1111111-1', '111-1111111-111', '2020-01-20', '2020-01-27');

INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
VALUES('5555555-5', '222-2222222-222', '2020-01-20', '2020-01-30');

INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
VALUES('3333333-3', '333-3333333-333', '2020-01-22', '2020-01-30');

INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
VALUES('4444444-4', '444-4444444-444', '2020-01-23', '2020-01-30');

INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
VALUES('2222222-2', '111-1111111-111', '2020-01-27', '2020-02-04');

INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
VALUES('1111111-1', '444-4444444-444', '2020-01-31', '2020-02-12');

INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
VALUES('3333333-3', '222-2222222-222', '2020-01-31', '2020-02-12');

-- Verificando datos insertados
SELECT * FROM prestamos;

-- -- Insertando datos en la tabla autores
INSERT INTO autores(id, nombre, apellido, fecha_nacimiento, fecha_muerte)
VALUES(3, 'JOSE', 'SALGADO', '1968-01-01', '2020-01-01');

INSERT INTO autores(id, nombre, apellido, fecha_nacimiento)
VALUES(4, 'ANA', 'SALGADO', '1972-01-01');

INSERT INTO autores(id, nombre, apellido, fecha_nacimiento)
VALUES(1, 'ANDRÉS', 'ULLOA', '1982-01-01');

INSERT INTO autores(id, nombre, apellido, fecha_nacimiento, fecha_muerte)
VALUES(2, 'SERGIO', 'MARDONES', '1950-01-01', '2012-01-01');

INSERT INTO autores(id, nombre, apellido, fecha_nacimiento)
VALUES(5, 'MARTIN', 'PORTA', '1976-01-01');

-- Verificando datos insertados
SELECT * FROM autores;

-- -- Insertando datos en la tabla tipos_autor
INSERT INTO tipos_autor(id, tipo_autor)
VALUES(1, 'PRINCIPAL');

INSERT INTO tipos_autor(id, tipo_autor)
VALUES(2, 'COAUTOR');

-- Verificando datos insertados
SELECT * FROM tipos_autor;

-- -- Insertando datos en la tabla autores_libros
INSERT INTO autores_libros(libro_id, autor_id, tipo_autor_id)
VALUES('111-1111111-111', 3, 1);

INSERT INTO autores_libros(libro_id, autor_id, tipo_autor_id)
VALUES('111-1111111-111', 4, 2);

INSERT INTO autores_libros(libro_id, autor_id, tipo_autor_id)
VALUES('222-2222222-222', 1, 1);

INSERT INTO autores_libros(libro_id, autor_id, tipo_autor_id)
VALUES('333-3333333-333', 2, 1);

INSERT INTO autores_libros(libro_id, autor_id, tipo_autor_id)
VALUES('444-4444444-444', 5, 1);

-- Verificando datos insertados
SELECT * FROM autores_libros;

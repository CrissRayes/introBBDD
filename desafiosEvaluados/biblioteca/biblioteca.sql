CREATE DATABASE biblioteca;
\c biblioteca

CREATE TABLE socios(
  rut VARCHAR(10) NOT NULL UNIQUE,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(9) NOT NULL,
  PRIMARY KEY(rut)
);

CREATE TABLE libros(
  isbn INT(13) NOT NULL UNIQUE,
  titulo VARCHAR(100) NOT NULL,
  paginas INT NOT NULL,
  PRIMARY KEY (isbn)
);

CREATE TABLE prestamos(
  id SERIAL,
  socio_id VARCHAR,
  libro_id INT,
  fecha_prestamo DATE NOT NULL,
  fecha_devolucion DATE NOT NULL,
  PRIMARY KEY id,
  FOREIGN KEY socio_id REFERENCES socios(rut),
  FOREIGN KEY libro_id REFERENCES libros(isbn)
);

CREATE TABLE autores(
  id SERIAL,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  fecha_muerte DATE,
  PRIMARY KEY(id)
);

CREATE TABLE tipos_autor(
  id SERIAL,
  tipo_autor VARCHAR(10) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE autores_libros(
  libro_id INT,
  autor_id INT,
  tipo_autor INT,
  FOREIGN KEY libro_id REFERENCES libros(isbn),
  FOREIGN KEY autor_id REFERENCES autores(id),
  FOREIGN KEY tipo_autor REFERENCES tipos_autor(id),
);


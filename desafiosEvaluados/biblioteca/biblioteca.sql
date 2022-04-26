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
  isbn INT(13) NOT NULL UNIQUE,
  titulo VARCHAR(100) NOT NULL,
  paginas INT NOT NULL,
  PRIMARY KEY (isbn)
);

-- Se crea la tabla préstamos
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

-- Se crea la tabla autores
CREATE TABLE autores(
  id SERIAL,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  fecha_muerte DATE,
  PRIMARY KEY(id)
);

-- Se crea la tabla tipos_autor
CREATE TABLE tipos_autor(
  id SERIAL,
  tipo_autor VARCHAR(10) NOT NULL,
  PRIMARY KEY(id)
);

-- Se crea la tabla autores_libros
CREATE TABLE autores_libros(
  libro_id INT,
  autor_id INT,
  tipo_autor INT,
  FOREIGN KEY libro_id REFERENCES libros(isbn),
  FOREIGN KEY autor_id REFERENCES autores(id),
  FOREIGN KEY tipo_autor REFERENCES tipos_autor(id),
);



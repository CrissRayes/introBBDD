## Prueba Biblioteca

### Parte 1

1. Realizar el modelo conceptual, considerando las entidades y relaciones entre ellas.(1 Punto)
   ![Screenshot](img/modelo_conceptual.jpg)
2. Realizar el modelo lógico, considerando todas las entidades y las relaciones entre ellas, los atributos, normalización y creación de tablas intermedias de ser necesario. (2 Puntos)
   ![Screenshot](img/modelo_logico.jpeg)
3. Realizar el modelo físico, considerando la especificación de tablas y columnas, además de las claves externas. (2 Puntos)
   ![Screenshot](img/modelo_fisico.jpeg)

### Parte 2

1. Crear el modelo en una base de datos llamada biblioteca, considerando las tablas definidas y sus atributos. (2 puntos).

```

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


```

2. Se deben insertar los registros en las tablas correspondientes (1 punto).
3. Realizar las siguientes consultas:
   a. Mostrar todos los libros que posean menos de 300 páginas. (0.5 puntos)
   b. Mostrar todos los autores que hayan nacido después del 01-01-1970. (0.5 puntos)
   c. ¿Cuál es el libro más solicitado? (0.5 puntos).
   d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.(0.5 puntos)

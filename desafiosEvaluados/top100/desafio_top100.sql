\c CrissRayes
DROP DATABASE peliculas;
-- 1. Crear una base de datos llamada películas. (1 Punto)
CREATE DATABASE peliculas;
\c peliculas

-- 2. Cargar ambos archivos a su tabla correspondiente. (1 Punto)
CREATE TABLE peliculas(
  id SERIAL,
  movie VARCHAR(100),
  year_ INT,
  director VARCHAR(100),
  PRIMARY KEY(id)
);

\copy peliculas FROM 'peliculas.csv' csv header;
SELECT * FROM peliculas LIMIT 10;

CREATE TABLE reparto(
  id_movie INT,
  actors VARCHAR(100),
  FOREIGN KEY(id_movie) REFERENCES peliculas(id)
);

\copy reparto FROM 'reparto.csv' csv;
SELECT * FROM reparto LIMIT 10;

-- 3. Obtener el ID de la película “Titanic”. (1 Punto)
SELECT id FROM peliculas WHERE movie = 'Titanic';

-- 4. Listar a todos los actores que aparecen en la película "Titanic". (1 Puntos)
SELECT actors FROM reparto WHERE id_movie = 2;

-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford. (2 Puntos)
SELECT COUNT(*) FROM reparto WHERE actors = 'Harrison Ford';

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente. (1 punto)
SELECT movie FROM peliculas WHERE year_ BETWEEN 1990 AND 1999 ORDER BY movie ASC;

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”. (1 punto)

SELECT movie, LENGTH(movie) AS longitud_titulo FROM peliculas LIMIT 10;

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas. (2 punto)
SELECT MAX(LENGTH(movie))FROM peliculas;

-- Bonus Track: Mostrar el nombre de la pelicula que tiene el largo máximo
SELECT movie, LENGTH(movie) AS longitud_titulo FROM peliculas WHERE LENGTH(movie) = (SELECT MAX(LENGTH(movie))FROM peliculas); 


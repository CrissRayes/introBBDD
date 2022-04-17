-- EJERCICIO POKEMONES --
\c CrissRayes
-- solo para reinicializar el ejercicio
DROP DATABASE pokemones;

-- crear base de datos
CREATE DATABASE pokemones;
\c pokemones

-- Crear tabla pokemones
CREATE TABLE pokemones(
  pokedex SERIAL,
  nombre VARCHAR(30),
  tipo1 VARCHAR(20),
  tipo2 VARCHAR(20),
  PRIMARY KEY(pokedex)
);

-- importar csv
\copy pokemones FROM 'pokemonesKanto.csv' csv header;

-- verificar la carga de datos
-- SELECT * FROM pokemones LIMIT 20;

-- Crear tabla mis_pokemones
CREATE TABLE mis_pokemones(
  pokedex INT,
  fecha_captura DATE,
  lugar VARCHAR(30),
  huevo BOOLEAN,
  peso FLOAT,
  estatura FLOAT,
  FOREIGN KEY(pokedex) REFERENCES pokemones(pokedex)
);

-- importar csv
\copy mis_pokemones FROM 'mis_pokemones.csv' csv header;

-- verificar la carga de datos
-- SELECT * FROM mis_pokemones LIMIT 20;

-- consultar con alias
-- SELECT pokedex AS número FROM pokemones WHERE nombre = 'Eevee';

-- realizar 2 inserciones en la tabla mis_pokemones
-- INSERT INTO mis_pokemones (pokedex, fecha_captura, lugar, huevo, peso, estatura)
-- VALUES (133, '2021-04-12', 'Rancagua', false, 15.6, 0.3);

-- INSERT INTO mis_pokemones (pokedex, fecha_captura, lugar, huevo, peso, estatura)
-- VALUES (134, '2021-04-12', 'Rancagua', false, 25.6, 0.8);

-- verificar la inserción en tabla ordenada descendente mostrando solo 3 registros
-- SELECT * FROM mis_pokemones ORDER BY fecha_captura DESC LIMIT 3;

-- hacer una consulta con SUM
-- SELECT SUM(peso) FROM mis_pokemones;

-- agregar una columna a una tabla
-- ALTER TABLE pokemones
-- ADD rocket BOOLEAN;

-- verificar la nueva columna
-- SELECT * FROM pokemones LIMIT 20;

-- agregar un registro
-- INSERT INTO pokemones
-- (pokedex, nombre, tipo1, tipo2, rocket)
-- VALUES (152, 'pikachu', 'electrico','', false );

-- SELECT * FROM pokemones ORDER BY pokedex DESC LIMIT 1;

-- hacer una actualizacion
-- UPDATE pokemones SET rocket = false;

-- SELECT rocket AS capturado FROM pokemones LIMIT 2;

-- agrupar columnas en una tabla por tipo1 de pokemon
-- SELECT tipo1, COUNT(*) FROM pokemones GROUP BY tipo1 LIMIT 10; 

-- ejecutar consulta con order by
-- SELECT * FROM mis_pokemones ORDER BY peso DESC LIMIT 10;

-- agregar un indices a una columna
-- CREATE INDEX index_pokedex_pokemones ON pokemones(pokedex);
-- SELECT * FROM pg_indexes WHERE tablename = 'pokemones';

-- eliminar indice de la columna
-- DROP INDEX index_pokedex_pokemones;
-- SELECT * FROM pg_indexes WHERE tablename = 'pokemones';

-- ver que pokemones tengo y su informacion detallada
-- SELECT * FROM pokemones 
-- JOIN mis_pokemones 
-- ON pokemones.pokedex = mis_pokemones.pokedex;

-- saber que pokemones no tengo
-- por ende mostramos la info de pokemones
SELECT *
FROM pokemones
LEFT JOIN mis_pokemones
ON pokemones.pokedex = mis_pokemones.pokedex
WHERE mis_pokemones.pokedex IS NULL;

SELECT pokemones.*
FROM pokemones
LEFT JOIN mis_pokemones
ON pokemones.pokedex = mis_pokemones.pokedex
WHERE mis_pokemones.pokedex IS NULL;

SELECT nombre
FROM pokemones
WHERE pokedex
IN (SELECT DISTINCT pokedex
FROM mis_pokemones);


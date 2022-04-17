-- La academia está trabajando en mejorar su plataforma de estudio y planea crear un espacio
-- que sirva como una red social entre estudiantes y docentes, por lo que necesita almacenar
-- en una base de datos los post y comentarios que se generen.
-- Parte 1: Creación, inserciones, modificaciones y eliminaciones en la tabla “Posts”.
-- Parte 2: Creación e inserciones en la tabla “comentarios”.

-- ####### Parte 1 ##########
-- Primero salgo de la base de datos posts para entrar a la mia personal CrissRayes
\c CrissRayes

-- Ahora borro la base de datos posts para correr siempre todos los comandos desde cero cada vez que ejecuto el archivo en la terminal
DROP DATABASE posts;

-- 1. Crear una base de datos con nombre “Posts”. (1 Punto)
CREATE DATABASE posts;
\c posts

-- 2. Crear una tabla “post”, con los atributos id, nombre de usuario, fecha de creación,
-- contenido y descripción. (1 Punto)
CREATE TABLE post(
  id SERIAL, 
  userName VARCHAR(30), 
  createdAt DATE, 
  content VARCHAR, 
  descript VARCHAR(255),
  PRIMARY KEY (id)
  );
\dt

-- 3. Insertar 3 post, 2 para el usuario "Pamela" y uno para "Carlos". (0.6 Puntos)
INSERT INTO post (userName, createdAt, content, descript)
VALUES ('Pamela', '2021-04-08', 'Contenido del post 1 de Pamela', 'poca imaginacion 1');

INSERT INTO post (userName, createdAt, content, descript)
VALUES ('Pamela', '2021-05-25', 'Contenido del post 2 de Pamela', 'poca imaginacion 2');

INSERT INTO post (userName, createdAt, content, descript)
VALUES ('Carlos', '2021-12-20', 'Contenido del post 1 de Carlos', 'Menos imaginacion aún');

SELECT * FROM post;

-- 4. Modificar la tabla post, agregando la columna título. (1 Punto)
ALTER TABLE post
ADD title VARCHAR(100);

SELECT * FROM post;

-- 5. Agregar título a las publicaciones ya ingresadas. (1 Punto)
UPDATE post SET title = 'Dinosaurios' WHERE id = 1;
UPDATE post SET title = 'Planetas' WHERE id = 2;
UPDATE post SET title = 'Universo' WHERE id = 3;

SELECT * FROM post;

-- 6. Insertar 2 post para el usuario "Pedro". (0.4 Puntos)
INSERT INTO post (userName, createdAt, content, descript, title)
VALUES ('Pedro', '2022-01-05', 'Este libro es el mas recomendado', 'Una recomendación', 'Crímenes');

INSERT INTO post (userName, createdAt, content, descript, title)
VALUES ('Pedro', '2022-02-05', 'Este libro es el menos recomendado', 'Una mala recomendación', 'Novelas');

SELECT * FROM post;

-- 7. Eliminar el post de Carlos. (1 Punto)
DELETE FROM post WHERE userName='Carlos';

SELECT * FROM post;

-- 8. Ingresar un nuevo post para el usuario "Carlos". (0.6 Puntos)
INSERT INTO post (userName, createdAt, content, descript, title)
VALUES ('Carlos', '2022-02-28', 'Me habías eliminado, pero regresé', 'He vuelto', 'El Renacido');

SELECT * FROM post;


-- ####### Parte 2 ##########
-- 1. Crear una nueva tabla llamada “comentarios”, con los atributos id, fecha, hora de creación y contenido, que se relacione con la tabla posts. (1 Punto)
CREATE TABLE comments(
  id SERIAL,
  post_id INT,
  createdAt TIMESTAMP,
  content VARCHAR,
  FOREIGN KEY (post_id) REFERENCES post(id)
);

\dt
-- 2. Crear 2 comentarios para el post de "Pamela" y 4 para "Carlos". (0.4 Puntos)
INSERT INTO comments (post_id, createdAt, content)
VALUES (1, '2021-05-10 15:16:13', 'Esta vez la creatividad del sabado fluye');

INSERT INTO comments (post_id, createdAt, content)
VALUES (1, '2021-05-11 10:00:24', 'Vi matrix 4 y es la peor de la vida');

INSERT INTO comments (post_id, createdAt, content)
VALUES (6, '2021-06-11 09:00:24', 'La mejor serie es Breaking Bad');

INSERT INTO comments (post_id, createdAt, content)
VALUES (6, '2021-06-11 09:00:24', 'La segunda mejor serie es TWD');

INSERT INTO comments (post_id, createdAt, content)
VALUES (6, '2021-06-11 09:22:02', 'La tercera mejor serie es Ozark');

INSERT INTO comments (post_id, createdAt, content)
VALUES (6, '2021-06-11 09:33:19', 'Un bonus sería la serie FTWD');

SELECT * FROM comments;

-- 3. Crear un nuevo post para "Margarita". (1 Punto)
INSERT INTO post (userName, createdAt, content, descript, title)
VALUES ('Margarita', '2022-01-01', 'Creando un nuevo post ya sin imaginación', 'con sueño', 'Durmiendo con los ojos abiertos');

SELECT * FROM post;

-- 4. Ingresar 5 comentarios para el post de Margarita. (1 Punto)
INSERT INTO comments (post_id, createdAt, content)
VALUES (7, '2022-02-01 00:05:33', 'No podía dormir y se puso a comentar');

INSERT INTO comments (post_id, createdAt, content)
VALUES (7, '2022-02-01 00:30:33', 'Estoy en viendo una peli en HBO');

INSERT INTO comments (post_id, createdAt, content)
VALUES (7, '2022-02-01 02:23:33', 'Mala la peli así que me puse a estudiar programación...');

INSERT INTO comments (post_id, createdAt, content)
VALUES (7, '2022-02-01 05:18:33', 'Ahora si que me dio sueño, me voy a dormir');

INSERT INTO comments (post_id, createdAt, content)
VALUES (7, '2022-02-01 06:18:33', 'Estoy durmiendo...escribo en modo sonámbulo...');

SELECT * FROM comments;

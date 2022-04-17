\c CrissRayes
DROP DATABASE blog;
CREATE DATABASE blog;
\c blog


CREATE TABLE usuarios(
  id SERIAL PRIMARY KEY,
  email VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE posts(
  id SERIAL PRIMARY KEY,
  usuario_id INT NOT NULL REFERENCES usuarios(id),
  titulo VARCHAR(50) NOT NULL UNIQUE,
  fecha DATE NOT NULL
);

CREATE TABLE comentarios(
  id SERIAL PRIMARY KEY,
  post_id INT NOT NULL REFERENCES posts(id),
  usuario_id INT NOT NULL REFERENCES usuarios(id),
  texto VARCHAR(30) NOT NULL,
  fecha DATE NOT NULL
);

-- verificar la correcta creación de las tablas
SELECT * FROM usuarios;
SELECT * FROM posts;
SELECT * FROM comentarios;

INSERT INTO usuarios (email)
VALUES ('usuario01@hotmail.com');

INSERT INTO usuarios (email)
VALUES ('usuario02@gmail.com');

INSERT INTO usuarios (email)
VALUES ('usuario03@gmail.com');

INSERT INTO usuarios (email)
VALUES ('usuario04@hotmail.com');

INSERT INTO usuarios (email)
VALUES ('usuario05@yahoo.com');

INSERT INTO usuarios (email)
VALUES ('usuario06@hotmail.com');

INSERT INTO usuarios (email)
VALUES ('usuario07@yahoo.com');

INSERT INTO usuarios (email)
VALUES ('usuario08@yahoo.com');

INSERT INTO usuarios (email)
VALUES ('usuario09@yahoo.com');

SELECT * FROM usuarios;

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (1, 'Post 1: Esto es malo', '2020-06-29');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (5, 'Post 2: Esto es malo', '2020-06-20');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (1, 'Post 3: Esto es excelente', '2020-05-30');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (9, 'Post 4: Esto es bueno', '2020-05-09');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (7, 'Post 5: Esto es bueno', '2020-07-10');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (5, 'Post 6: Esto es excelente', '2020-07-18');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (8, 'Post 7: Esto es excelente', '2020-07-07');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (5, 'Post 8: Esto es excelente', '2020-05-14');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (2, 'Post 9: Esto es bueno', '2020-05-08');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (6, 'Post 10: Esto es bueno', '2020-06-02');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (4, 'Post 11: Esto es bueno', '2020-05-05');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (9, 'Post 12: Esto es malo', '2020-07-23');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (5, 'Post 13: Esto es excelente', '2020-05-30');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (8, 'Post 14: Esto es excelente', '2020-05-01');

INSERT INTO posts (usuario_id, titulo, fecha)
VALUES (7, 'Post 15: Esto es malo', '2020-06-17');

SELECT * FROM posts;

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(6, 3, 'Este es el comentario 1', '2020-07-08');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(2, 4, 'Este es el comentario 2', '2020-06-07');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(4, 6, 'Este es el comentario 3', '2020-06-16');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(13, 2, 'Este es el comentario 4', '2020-06-15');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(6, 6, 'Este es el comentario 5', '2020-05-14');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(3, 3, 'Este es el comentario 6', '2020-07-08');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(1, 6, 'Este es el comentario 7', '2020-05-22');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(7, 6, 'Este es el comentario 8', '2020-07-09');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(13, 8, 'Este es el comentario 9', '2020-06-30');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(6, 8, 'Este es el comentario 10', '2020-06-19');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(1, 5, 'Este es el comentario 11', '2020-05-09');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(15, 8, 'Este es el comentario 12', '2020-06-17');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(9, 1, 'Este es el comentario 13', '2020-05-01');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(5, 2, 'Este es el comentario 14', '2020-05-31');

INSERT INTO comentarios(post_id, usuario_id, texto, fecha )
VALUES(3, 4, 'Este es el comentario 15', '2020-06-28');

SELECT * FROM comentarios;

-- Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT usuarios.email, posts.id, posts.titulo
FROM usuarios
JOIN posts
ON usuarios.id = posts.usuario_id
WHERE usuarios.id = 5;

-- Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados
-- por el usuario con email usuario06@hotmail.com.
SELECT usuarios.email, comentarios.id, comentarios.texto
FROM usuarios
JOIN comentarios
ON usuarios.id = comentarios.usuario_id
WHERE usuarios.email != 'usuario06@hotmail.com';

-- Listar los usuarios que no han publicado ningún post
SELECT *
FROM usuarios
LEFT JOIN posts
ON usuarios.id = posts.usuario_id
WHERE posts.id IS NULL; 


-- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
-- esto tambien se podria haber logrado con un LEFT JOIN, siempre que se mantenga el orden de carga de las tablas
SELECT *
FROM posts
FULL OUTER JOIN comentarios
ON posts.id = comentarios.post_id;

-- Listar todos los usuarios que hayan publicado un post en Junio.
SELECT usuarios.*, posts.fecha
FROM usuarios
JOIN posts
ON usuarios.id = posts.usuario_id
WHERE posts.fecha BETWEEN '2020-06-01' AND '2020-06-30';

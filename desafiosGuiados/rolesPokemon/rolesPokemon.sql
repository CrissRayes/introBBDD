\c CrissRayes
DROP DATABASE pokerols;
CREATE DATABASE pokerols;
\c pokerols

CREATE TABLE rol(
  id SERIAL,
  nombre VARCHAR(50),
  descripcion VARCHAR,
  PRIMARY KEY(id)
);

-- SELECT * FROM rol;

CREATE TABLE usuario(
  rut VARCHAR(12),
  nombre VARCHAR(30),
  telefono INT,
  mail VARCHAR(30),
  genero VARCHAR(30),
  fecha_nacimiento DATE,
  rol_id INT,
  FOREIGN KEY (rol_id) REFERENCES rol (id)
);

-- SELECT * FROM usuario;

-- INSERTAR DATOS EN TABLA ROL
INSERT INTO rol(nombre, descripcion)
VALUES ('administrador', 'control total');

INSERT INTO rol(nombre, descripcion)
VALUES ('marketing', 'editar y crear anuncios');

INSERT INTO rol(nombre, descripcion)
VALUES ('editor', 'editar articulos');

INSERT INTO rol(nombre, descripcion)
VALUES ('subscriptor', 'leer articulos');

-- SELECT * FROM rol;

-- INSERTAR DATOS EN TABLA USUARIO
INSERT INTO usuario(rut, nombre, telefono, mail, genero, fecha_nacimiento, rol_id)
VALUES ('1-9', 'Juan Soto', 9999999, 'juan.soto@gmail.com', 'M', '2000-06-24', 1);

INSERT INTO usuario(rut, nombre, telefono, mail, genero, fecha_nacimiento, rol_id)
VALUES ('2-7', 'Jorge Perez', 8888888, 'jorge.perez@hotmail.com', 'M', '1998-03-12', 4);

INSERT INTO usuario(rut, nombre, telefono, mail, genero, fecha_nacimiento)
VALUES ('3-5', 'Sara Morales', 77777777, 'sara.morales@gmail.com', 'F', '1990-02-11');

INSERT INTO usuario(rut, nombre, telefono, mail, genero, fecha_nacimiento, rol_id)
VALUES ('4-6', 'Sarita Morales', 77777777, 'sarita.morales@gmail.com', 'F', '1990-02-11', 2);

INSERT INTO usuario(rut, nombre, telefono, mail, genero, fecha_nacimiento, rol_id)
VALUES ('1-8', 'Maria la del Barrio', 5555555, 'lamaria@gmail.com', 'F', '1990-02-11', 2);

-- SELECT * FROM usuario;

-- SELECCIONAR DATOS CON JOIN
-- SELECT * FROM rol INNER JOIN usuario ON rol.id = usuario.rol_id;

-- SELECT * FROM rol JOIN usuario ON rol.id = usuario.rol_id;

-- SELECT rol.nombre AS rol_ejemplo1 
-- FROM rol JOIN usuario 
-- ON rol.id = usuario.rol_id 
-- WHERE usuario.genero = 'M';

-- SELECT A.nombre AS rol_ejemplo2
-- FROM rol AS A
-- JOIN usuario AS B
-- ON A.id = B.rol_id
-- WHERE B.genero = 'M';

-- Left JOIN
SELECT * FROM rol
LEFT JOIN usuario
ON rol.id = usuario.rol_id;

SELECT * FROM usuario
LEFT JOIN rol
ON usuario.rol_id = rol.id;

-----------------------------
-- mostrar los roles que no tengan usuario
-- null es la ausencia de valor
-- blank es que esta en blanco, por ejemlo al borrar un dato de una tabla
SELECT rol.*
FROM rol
LEFT JOIN usuario
ON rol.id = usuario.rol_id
WHERE usuario.rol_id IS NULL;

----------------------------
-- Aplicar FULL OUTER JOIN
SELECT * 
FROM rol
FULL OUTER JOIN usuario
ON rol.id = usuario.rol_id;

 

















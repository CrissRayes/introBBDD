-- DESAFIO EVALUADO: ENTENDIENDO COMO SE COMPORTAN NUESTROS CLIENTES

-- 1. Cargar el respaldo de la base de datos unidad2.sql. (2 Puntos)
$ psql -- ingresar a consola psql
CREATE DATABASE desafiobilljobs; -- crear la base de datos
\l -- para verificar el listado de bases de datos y comprobar la correcta creación
\q -- salir de consola psql
$ psql -U CrissRayes desafiobilljobs < unidad2.sql -- El siguiente comando debe ser ejecutado desde la terminal
$ psql -- ingresar a consola psql
\c desafiobilljobs -- para moverse a la base de datos
\dt -- Verificar las tablas creadas desde el respaldo
\set AUTOCOMMIT off -- IMPORTANTE: Para cumplir los siguientes requerimientos, debes recordar tener desactivado el autocommit en tu base de datos.
\echo :AUTOCOMMIT -- verificar el estado de los autocommit


-- 2. El cliente usuario01 ha realizado la siguiente compra:
-- ● producto: producto9.
-- ● cantidad: 5.
-- ● fecha: fecha del sistema.
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este requerimiento y luego consulta la tabla producto para validar si fue efectivamente descontado en el stock. (3 Puntos)

BEGIN;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (33, 1, current_date);
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad)
VALUES (43, 9, 33, 5);
UPDATE producto SET stock = stock - 5 WHERE id = 9; 
COMMIT;
SAVEPOINT primera_compra; -- creamos un checkpoint.
-- Ahora consultamos la tabla producto y la tabla compra para ver el resulado de la transacción.
SELECT * FROM producto;
SELECT * FROM compra;

-- -- 3. El cliente usuario02 ha realizado la siguiente compra:
-- -- ● producto: producto1, producto 2, producto 8.
-- -- ● cantidad: 3 de cada producto.
-- -- ● fecha: fecha del sistema.
-- -- Mediante el uso de transacciones, realiza las consultas correspondientes para este requerimiento y luego consulta la tabla producto para validar que si alguno de ellos se queda sin stock, no se realice la compra. (3 Puntos)

BEGIN;
INSERT INTO compra(id, cliente_id, fecha)
VALUES(34, 2, current_date);
-- Producto1
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad)
VALUES(44, 1, 34, 3);
UPDATE producto SET stock = stock - 3 WHERE id = 1;
-- Producto2
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad)
VALUES(45, 2, 34, 3);
UPDATE producto SET stock = stock - 3 WHERE id = 2;
SAVEPOINT segunda_compra;
-- Producto8
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad)
VALUES(46, 8, 34, 3);
UPDATE producto SET stock = stock - 3 WHERE id = 8;
ROLLBACK TO segunda_compra;
COMMIT;

-- -- 4. Realizar las siguientes consultas (2 Puntos):
-- -- a. Deshabilitar el AUTOCOMMIT.
\set AUTOCOMMIT off
-- -- b. Insertar un nuevo cliente.
INSERT INTO cliente(id, nombre, email)
VALUES(11, 'usuario11', 'usuario11@gmail.com');
-- c. Confirmar que fue agregado en la tabla cliente.
SELECT * FROM cliente;
-- -- d. Realizar un ROLLBACK.
ROLLBACK;
-- -- e. Confirmar que se restauró la información, sin considerar la inserción del punto b.
SELECT * FROM cliente;
-- -- f. Habilitar de nuevo el AUTOCOMMIT.
\set AUTOCOMMIT on


-- -- el respaldo de la base se hace desde la terminal
\q -- para salir de la consola sql
$ pg_dump -U CrissRayes desafiobilljobs > respaldo_desafiobilljobs.sql -- respaldar la base de datos 



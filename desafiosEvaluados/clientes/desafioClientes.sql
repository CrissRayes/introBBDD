-- DESAFIO EVALUADO: ENTENDIENDO COMO SE COMPORTAN NUESTROS CLIENTES

-- IMPORTANTE: Para este ejercicio se debe tener el AUTOCOMMIT desactivado
\set AUTOCOMMIT off

-- 1. Cargar el respaldo de la base de datos unidad2.sql. (2 Puntos)
-- Primero creamos la base de datos clientes, que contendrá todas las tablas del desafío.
-- CREATE DATABASE desafiobilljobs; 
-- luego con este comando desde la terminal cargamos el respaldo de la base de datos hacia la base de datos clientes.
-- psql -U CrissRayes desafiobilljobs < unidad2.sql 

-- Para verificar que la restauración de la base ha sido exitosa, vamos ingresar a psql y vamos a mostrar las tablas que contiene la base de datos y el contenido de cada tabla:
\c desafiobilljobs
\dt
SELECT * FROM cliente;
SELECT * FROM compra;
SELECT * FROM producto;
SELECT * FROM detalle_compra;


-- 2. El cliente usuario01 ha realizado la siguiente compra:
-- ● producto: producto9.
-- ● cantidad: 5.
-- ● fecha: fecha del sistema.
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este requerimiento y luego consulta la tabla producto para validar si fue efectivamente descontado en el stock. (3 Puntos)

BEGIN;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (33, 1, current_date);
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad)
VALUES (21, 9, 33, 5);
UPDATE producto SET stock = stock - 5 WHERE id = 9; 
ROLLBACK;
COMMIT;
-- Ahora consultamos la tabla producto para ver el resulado de la transacción.
SELECT * FROM producto;


-- 3. El cliente usuario02 ha realizado la siguiente compra:
-- ● producto: producto1, producto 2, producto 8.
-- ● cantidad: 3 de cada producto.
-- ● fecha: fecha del sistema.
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este requerimiento y luego consulta la tabla producto para validar que si alguno de ellos se queda sin stock, no se realice la compra. (3 Puntos)

BEGIN;
INSERT INTO compra(id, cliente_id, fecha)
VALUES(34, 2, current_date);
-- Producto1
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad)
VALUES(22, 1, 34, 3);
UPDATE producto SET stock = stock - 3 WHERE id = 1;
-- Producto2
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad)
VALUES(23, 2, 34, 3);
UPDATE producto SET stock = stock - 3 WHERE id = 2;
-- Producto8
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad)
VALUES(24, 8, 34, 3);
UPDATE producto SET stock = stock - 3 WHERE id = 8;
ROLLBACK;
COMMIT;


-- 4. Realizar las siguientes consultas (2 Puntos):
-- a. Deshabilitar el AUTOCOMMIT.
\set AUTOCOMMIT off
-- b. Insertar un nuevo cliente.
INSERT INTO cliente(id, nombre, email)
VALUES(11, 'usuario11', 'usuario11@gmail.com');
-- c. Confirmar que fue agregado en la tabla cliente.
SELECT * FROM cliente WHERE nombre = 'usuario11';
-- d. Realizar un ROLLBACK.
ROLLBACK;
-- e. Confirmar que se restauró la información, sin considerar la inserción del punto b.
SELECT * FROM cliente;
-- f. Habilitar de nuevo el AUTOCOMMIT.
\set AUTOCOMMIT on


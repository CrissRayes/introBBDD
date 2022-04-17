\c CrissRayes
DROP DATABASE pizzeria;
CREATE DATABASE pizzeria;
\c pizzeria

CREATE TABLE pizzas(
  id SERIAL,
  stock INT CHECK (stock >= 0.00),
  costo DECIMAL,
  nombre VARCHAR(25),
  PRIMARY KEY(id)
);

CREATE TABLE ventas(
  cliente VARCHAR(20),
  fecha DATE,
  monto DECIMAL,
  pizza INT,
  FOREIGN KEY (pizza) REFERENCES pizzas(id)
);

INSERT INTO pizzas (stock, costo, nombre)
VALUES (0, 12000, 'Uhlalá');


BEGIN;
  INSERT INTO pizzas (stock, costo, nombre)
  VALUES(2, 15000, 'Jamón a todo dar');
  COMMIT;


SELECT * FROM pizzas;

-- Es hora de probar nuestra base de datos, por lo que realizaremos una transacción que registre una venta
-- con la pizza con stock 0 e intente actualizar su stock restándole 1.
-- Esto nos devolverá el siguiente error.
--  ERROR: el nuevo registro para la relación «pizzas» viola la restricción «check» «stock»
BEGIN;
  INSERT INTO ventas (cliente, fecha, monto, pizza)
  VALUES('Dexter Gonzalez', '2020-02-02', 12000, 1);
  UPDATE pizzas SET stock = stock - 1 WHERE id = 1;
  COMMIT;

-- Ahora supongamos que se quiere realizar una venta de las 2 pizzas
-- registradas pero solo 1 de ellas tiene stock, por lo que marcaremos un punto de guardado 
-- justo después de actualizar el stock de la pizza disponible y volviendo a este punto en el
-- momento que recibimos un error.
BEGIN;
  INSERT INTO ventas (cliente, fecha, monto, pizza)
  VALUES ('Juan Bravo', '2020-02-02', 15000, 2);
  UPDATE pizzas SET stock = stock - 1 WHERE id = 2;
  SAVEPOINT checkpoint;
  INSERT INTO ventas (cliente, fecha, monto, pizza)
  VALUES ('Utonio Ramirez', '2020-02-02', 12000, 1);
  UPDATE pizzas SET stock = stock - 1 WHERE id = 1;
  -- Acá recibirás un error por intentar rebajar el stock de una pizza cuyo stock es 0
  ROLLBACK TO checkpoint;

SELECT * FROM ventas;
SELECT * FROM pizzas;

-- Supongamos que la pizzería Hot Cheese no le va muy bien y decide guardar un respaldo de sus datos 
-- y solicita que se exporte la base de datos como un archivo llamado pizzeria.sql.
-- Para esto realizamos la siguiente instrucción en la consola (terminal o sql?????)
-- pg_dump -U postgres pizzeria > pizzeria.sql;

-- Y si quisiera aperturar el negocio y recuperar los datos de su último respaldo, 
-- deberíamos crear de nuevo la base de datos y posteriormente importar nuestro archivo pizzeria.sql,
-- exportado en el paso 8 tal y como te muestro a continuación.
-- CREATE DATABASE pizzeria;
-- Y en la  consola (terminal o sql) hacemos esto:
-- $ sudo su - postgres
-- $ psql -U postgres pizzeria < pizzeria.sql




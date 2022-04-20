-- CHEATSHEET BBDD POSTGRES --


-- COMANDOS
psql 			-- Iniciar con mi usuario personal.
psql -U nombre_usuario 	-- Inicia con el usuario postgres.
\c nombre_base_de_datos -- Para cambiarnos de base de datos.
\l 			-- Listar todas las bases de datos existentes.
\d 			-- Listar todas las relaciones (o tablas) existentes en una base de datos.
\du 			-- Lista todos los usuarios existentes en la bbdd con sus permisos.
\dt 			-- Lista todas las tablas de una base de datos.
psql -U nombre_usuario -d nombre_base_datos -- iniciar con usuario y acceder a bbdd.
\q 			-- Salir de consola postgres.
\h 			-- Mostrar lista de comandos.
\i nombre_archivo.sql 	-- Ejecuta el archivo con instrucciones sql.


-- MANEJO DE USUARIOS
SELECT * FROM user; 					--para revisar que hemos ingresado de manera correcta.
CREATE USER nombre_usuario WITH comando_opcional; 	--Para poner algún límite a un usuario.
DROP USER nombre_usuario; 				--Para eliminar usuarios.
SELECT nombre_usuario FROM pg_user; 			--saber cuales son todos los usuarios que tienen acceso a la base de datos.
CREATE USER nombre_usuario WITH SUPERUSER; 		--crear otro usuario que tenga todos los permisos, al igual que el administrador de la base de datos.
GRANT ALL PRIVILEGES ON DATABASE database_name TO nombre_usuario; --dar acceso a todos los privilegios de una base de datos.
ALTER USER nombre_usuario CREATEDB; 			--dar permiso de creación de una base de datos.
ALTER USER myuser WITH SUPERUSER; 			--transformar al usuario en superuser.
ALTER USER username WITH NOSUPERUSER; 			--Remover el superusuario.

-- MANEJO DE BASES DE DATOS
CREATE DATABASE nombre_base_de_datos; 			--Crear una base de datos.
DROP DATABASE nombre_base_de_datos; 			--Para eliminar la base de datos.


-- MANEJO DE TABLAS
-- Crear una tabla dentro de nuestro motor de base de datos
CREATE TABLE nombre_tabla (
   columna1 tipo_dato1,
   columna2 tipo_dato2,
   columna3 tipo_dato3,
   PRIMARY KEY (columnaN)
);

-- TIPOS DE DATOS
INT 		-- Números enteros de 4 bytes que pueden tomar valor desde -2147483648 hasta +2147483647.
SMALLINT 	-- Números enteros de 2 bytes que pueden tomar valor desde -32768 hasta +32767.
BIGINT 		-- Números enteros de 8 bytes que pueden tomar valor desde -9223372036854775808 hasta 9223372036854775807.
FLOAT 		-- Números decimales de 32 bit de precisión.
DOUBLE 		-- Números decimales de 64 bit de precisión con hasta 15 dígitos decimales.
CHAR 		-- Cadenadehasta255caracteresdelongitudfija.
VARCHAR 	-- Cadena de hasta 65.535 caracteres de longitud variable. A diferencia de CHAR, si no se ocupa toda la memoria, esta queda libre. CHAR ocupará toda la memoria solicitada.
DATE 		-- Almacena fecha en formato aaaa -mm-dd.<año>-<mes>-<dia>
TIME 		-- Almacena el tiempo en horario desde 00:00:00 hasta 24:00:00
TIMESTAMP 	-- Almacena fecha y hora juntos: yyyy-mm-ddhh:mm:ss.
BOOLEAN 	-- Tiene 3 valores posibles: Verdadero, Falso o NULL.

-- para insertar datos a una tabla
INSERT INTO nombre_tabla (columna1, columna2, columna3) 
VALUES (valor1, valor2, valor3);

-- ver la estructura que tiene nuestra tabla
SELECT * FROM nombre_tabla; 

-- actualizar registros existentes
UPDATE nombre_tabla SET columna1=valor_nuevo WHERE condicion; 

-- eliminar toda la tabla
DROP TABLE tabla; 
DELETE FROM tabla WHERE condicion; -- eliminar uno, varios o todos los registros de la tabla según la condición dada.

-- agregar columnas a una tabla
ALTER TABLE nombre_tabla
ADD nueva_columna tipo_de_dato;

PRIMARY KEY 	-- hace referencia a una columna dentro de la tabla.
FOREIGN KEY 	-- hace referencia a una columna identificadora en otra tabla a la que hacemos referencia.

-- Restricciones:
-- Puede que existan casos en los que nuestras columnas necesiten reglas que cumplir.
NOT NULL 	-- La columna no puede tener valores NULL.
UNIQUE 		-- Todos los valores de la columna deben ser diferentes unos a otros.
SERIAL 		-- Restringe a que el valor numérico sea autoincremental.
PRIMARY KEY 	-- Aplica la clave primaria.
FOREIGN KEY 	-- Sirve para enlazar 2 tablas, generalmente referente a una clave primaria.
CHECK 		-- Todos los valores de una columna deben satisfacer una condición en específico.
DEFAULT 	-- Le da un valor por defecto a aquellos registros que no tengan un valor asignado.
INDEX 		-- Sirveparacrearyrecuperardatosdeformarápida.


-- Eliminar una tabla.
DROP TABLE nombre_tabla; 

-- Si lo que realmente necesitamos es eliminar sólo los registros, pero no la tabla en sí.
TRUNCATE TABLE nombre_tabla;

-- cargar desde un fichero
\i ubicación\nombre_fichero.sql 

-- IMPORTANDO DESDE UN CSV
-- Si las filas están encerradas entre comillas, elimínelas.
-- Crear la tabla a la cual desea agregar el archivo csv.
\copy nombre_tabla FROM 'directorio/archivo.csv' csv header;

-- CONSULTANDO TABLAS
SELECT columna1 FROM nombre_tabla; 		-- Si solamente queremos ver una columna.
SELECT columna1, columna2 FROM nombre_tabla; 	-- Si queremos ver más de una columna.
SELECT * FROM nombre_tabla; 			-- Si queremos seleccionar todos los datos de la tabla.
SELECT columna FROM tabla WHERE condicion; 	-- Si queremos ver una fila en específico.

-- Las condiciones se crean basadas en la siguiente lista de opciones:
	= 	-- igual
	> 	-- mayor que
	< 	-- menor que
	<>, != 	-- distinto
	>= 	-- mayor o igual
	<= 	-- menor o igual
	BETWEEN -- entre cierto rango
	LIKE 	-- por patrón
	IN 	-- para especificar múltiples valores posibles para una columna

SELECT columna FROM tabla LIMIT cantidad; 	-- si del total de datos solo queremos una cantidad menor.
FROM nombre_tabla AS nombre_tabla_referencia; 	-- cuando se quiere dar un nombre mas pequeño o fácil de usar.

-- Asignar un alias a las columnas y mostrarlas con ese alias
SELECT nombre AS nom, apellido AS ape
FROM usuarios AS us;

-- FUNCIONES EN CONSULTAS
-- Se puede agregar a la instrucción SELECT operaciones o funciones como:
MIN 	-- Entrega el mínimo de los datos de una columna.
MAX 	-- Entrega el máximo de los datos de una columna.
LENGTH 	-- Calcula el largo de los datos en una columna.
COUNT 	-- Cuenta la cantidad de ocurrencias de las filas.
SUM 	-- Suma los valores de una columna ignorando los valores null.

-- Ejemplo:
SELECT LENGTH(nombre)
AS largo_del_nombre
FROM tabla;

-- AGRUPANDO CON GROUP BY
-- agrupar filas que tengan datos iguales.
SELECT columna1, columna2, columna3
FROM tabla
GROUP BY columna1;

-- ORDENAR
SELECT columna1, columna2
FROM nombre_tabla
WHERE [condicion | condiciones]
ORDER BY columna2 [DESC | ASC];


-- INDICES
-- se usan para acceder más rápido a la información.

CREATE INDEX nombre_indice on nombre_tabla(nombre_columna); -- crear indice.
SELECT * FROM pg_indexes WHERE tablename = nombre_tabla; -- saber qué columnas de nuestras tablas tienen índice.
drop index nombre_indice; -- eliminar indice.

-- UNION DE TABLAS
-- Unir dos tablas, mostrando sólo las filas que cumplen la condición dada.
SELECT columas FROM tabla1
JOIN tabla2 ON tabla1.columna = tabla2.columna
WHERE condicion;

INNER JOIN	-- : Une sólo las columnas comunes entre ambas tablas.
LEFT JOIN	-- : Une todas las columnas de la primera tabla con las columnas en común de la segunda tabla.
FULL OUTER JOIN	-- : Une todas las columnas de ambas tablas.

-- INNER JOIN
SELECT columnas
FROM tabla1
INNER JOIN tabla2
ON tabla1.columna = tabla2.columna;

-- LEFT JOIN
-- nos permite obtener toda la información de una tabla y el conjunto de la relación con otra.
SELECT columnas
FROM tabla1
LEFT JOIN tabla2
ON tabla1.columna = tabla2.columna;

-- LEFT JOIN donde una columan de la tabla2 es null.
-- Nos permite obtener la información de los registros que no se encuentran en la relación.
SELECT columnas
FROM tabla1
LEFT JOIN tabla2
ON tabla1.columna = tabla2.columna
WHERE tabla2.columna IS NULL;

-- FULL OUTER JOIN
-- Este tipo de unión nos permite obtener todos los registros disponibles en las tablas que estamos relacionando, sin filtrar la información.
SELECT columnas
FROM tabla1
FULL OUTER JOIN tabla2
ON tabla1.columna = tabla2.columna;


-- FULL OUTER JOIN Donde una columna en la tabla1 o tabla2 es null.
-- nos permite conocer aquellos registros que no tienen en común las tablas que estamos relacionando.
SELECT columnas
FROM tabla1
FULL OUTER JOIN tabla2
ON tabla1.columna = tabla2.columna
WHERE tabla1.columna IS NULL
OR tabla2.columna IS NULL;


-- Subquery
-- Una subquery (o consulta interna) es una query implementada dentro de otra query principal de SQL,
-- la cual debe enmarcarse dentro de la cláusula WHERE.
SELECT columna1, columna2,...
FROM nombre_tabla
WHERE columna1 IN 
    (SELECT columna1
    FROM nombre_tabla2
    WHERE condicion);

-- Operador FROM
-- En este caso, la subquery obtiene como resultado una subtabla temporal, 
-- sobre la cual se hará una nueva consulta. La sintaxis está dada de la siguiente manera.
SELECT x.columna1, x.columna2,...
FROM(
    SELECT columna1, columna2,...
    FROM nombre_tabla2
    WHERE condicion
    )
    AS x
INNER JOIN nombre_tabla1 AS y ON x.columna1 = y.columna1;

-- REGLAS DE LAS SUBQUERIES
    -- Las consultas internas deben estar encapsuladas entre paréntesis.
    -- Una subquery puede tener sólo una columna especificada en SELECT.
    -- ORDER BY no se puede utilizar en una consulta interna.
    -- Para obtener un resultado similar a ORDER BY dentro de una consulta interna, se puede implementar el comando GROUP BY.
    -- Las consultas internas que retornen más de una fila sólo pueden ser utilizadas con operadores de múltiples valores como IN


-- TRANSACCIONES
BEGIN; 				-- El sistema permite que se ejecuten todas las sentencias SQL que necesitemos.
COMMIT; 			-- Guarda los cambios de la transacción.
SAVEPOINT; 			-- Guarda el punto de partida al cual volver a la hora de aplicar ROLLBACK.
SAVEPOINT nombre_checkpoint;	-- Punto de partida con un nombre asignado.
ROLLBACK; 			-- Retrocede los cambios realizados.
ROLLBACK TO nombre_checkpoint;	-- Rollback apuntando a un SAVEPOINT por su nombre.
SET TRANSACTION; 		-- Le asigna nombre a la transacción.

-- Ejemplos Transacciones:
BEGIN;
UPDATE cuentas SET balance = balance + 100 WHERE numero_cuenta = 1;
UPDATE cuentas SET balance = balance + 200 WHERE numero_cuenta = 2;
COMMIT;


BEGIN;
INSERT INTO cuentas (numero_cuenta, balance)
VALUES (3, 5000);
SAVEPOINT nueva_cuenta;
UPDATE cuentas SET balance = balance + 300 WHERE numero_cuenta = 2;
ROLLBACK TO nueva_cuenta;
COMMIT;

\echo :AUTOCOMMIT	-- postgres por defecto tiene activados los autocommit, para verificar esto, ejecutar en la consola sql:
\set AUTOCOMMIT off	-- para desactivar el autocommit ejecutar este codigo en la consola sql.
\set AUTOCOMMIT on	-- para reactivar el autocommit ejecutar en la consola sql.


pg_dump -U nombre_usuario nombre_db > nombre_respaldo.sql	-- RESPALDAR (EXPORTAR)BASE DE DATOS.
pg_dumpall > /directorio/dumpall.sql				-- RESPALDAR TODAS LAS BASES DE DATOS.
psql -U postgres nombredb < archivo_restauracion.sql		-- RESTAURAR UNA BASE DE DATOS (Importante crear primero la base de datos hacia donde se enviarán los datos).
psql -f /var/lib/pgsql/backups/dumpall.sql mydb			-- RESTAURAR TODAS LAS BASES DE DATOS.


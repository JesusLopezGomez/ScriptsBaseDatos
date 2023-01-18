CREATE TABLE FABRICANTE
(
	CODIGO NUMBER(10),
	NOMBRE VARCHAR2(30),
	CONSTRAINT PK_FABRICANTE PRIMARY KEY (CODIGO)
);

CREATE TABLE PRODUCTO
(
	CODIGO_PRODUCTO NUMBER(10),
	NOMBRE VARCHAR2(30),
	PRECIO VARCHAR2(1000),
	CODIGO_FABRICANTE NUMBER(10),
	CONSTRAINT PK_PRODUCTO PRIMARY KEY (CODIGO_PRODUCTO),
	CONSTRAINT FK1_PRODUCTO FOREIGN KEY (CODIGO_FABRICANTE) REFERENCES FABRICANTE(CODIGO)
);

-- AÑADIR FABRICANTES NECESARIOS --
INSERT INTO FABRICANTE VALUES (12,'ASUS');
INSERT INTO FABRICANTE VALUES (13,'XIAOMI');
INSERT INTO FABRICANTE VALUES (21,'LENOVO');
INSERT INTO FABRICANTE VALUES (11,'HUAWEI');

-- AÑADIR FABRICANTE NUEVO--
INSERT INTO FABRICANTE (CODIGO,NOMBRE) VALUES (7,'AMD');

--CONSULTA A TODOS LOS FABRICANTES--
SELECT * FROM FABRICANTE;

-- Esta sentencia (añadir fabricante solo con su nombre) no me deja ejecutarla porque no puedo dejar vacia la PRIMARY KEY-- 
INSERT INTO FABRICANTE (NOMBRE) VALUES ('INTEL');

-- AÑADIR VALORES A LOS PRODUCTOS --
INSERT INTO PRODUCTO VALUES (21,'RYZEN 6X', '210€', 7);
INSERT INTO PRODUCTO VALUES (30,'P12', '150€', 30);

SELECT * FROM PRODUCTO;

-- Esta sentencia (añadir un producto sin su codigo) no me deja ejecutarla porque no puedo dejar vacia la PRIMARY KEY--
INSERT INTO PRODUCTO (NOMBRE,PRECIO,CODIGO_FABRICANTE) VALUES ('MICROSOFT', '123€',21);

-- Si es posible eliminar las dos columnas siempre y cuando indiques en que tabla se encuentra y el valor que quieres eliminar con el WHERE--
DELETE FROM FABRICANTE WHERE NOMBRE = 'ASUS';
DELETE FROM FABRICANTE WHERE NOMBRE = 'XIAOMI';

-- Si es posible actualizar el campo que queremos utilizando esta sentencia que le indica el nuevo valor del codigo, y lo cambia en el nombre que indicamos que tiene asociado --
UPDATE FABRICANTE SET CODIGO = 20 WHERE NOMBRE = 'LENOVO';
UPDATE FABRICANTE SET CODIGO = 30 WHERE NOMBRE = 'HUAWEI';

-- Modificamos el precio de los productos a valores numericos en vez de cadena que es como está actualmente, para ello las columna debe estar vacía --
UPDATE PRODUCTO SET PRECIO = '';
ALTER TABLE PRODUCTO MODIFY PRECIO NUMBER(38);
UPDATE PRODUCTO SET PRECIO = 210 WHERE CODIGO_PRODUCTO = 21;
UPDATE PRODUCTO SET PRECIO = 150 WHERE CODIGO_PRODUCTO = 30;

-- Una vez que tenemos el precio con valores numeros ya podemos sumarle 5€ más a todos los precios con esta sentencia --
UPDATE PRODUCTO SET PRECIO = PRECIO + 5;

-- Con esta sentencia podemos eliminar en este caso todos los productos que su precio esté por debajo de 200€ --
DELETE FROM PRODUCTO WHERE PRECIO < 200;


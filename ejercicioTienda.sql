CREATE TABLE FABRICANTES
(
	COD_FABRICANTE NUMBER(3),
	NOMBRE VARCHAR2(15),
	PAIS VARCHAR2(15),
	CONSTRAINT PK_FABRICANTES PRIMARY KEY (COD_FABRICANTE)
);


CREATE TABLE ARTICULOS
(
	ARTICULO VARCHAR2(20),
	COD_FABRICANTE NUMBER(3),
	PESO NUMBER(3),
	CATEGORIA VARCHAR2(10),
	PRECIO_VENTA NUMBER(4,2),
	PRECIO_COSTO NUMBER(4,2),
	EXISTENCIAS NUMBER(5),
	CONSTRAINT FK1_ARTICULOS FOREIGN KEY (COD_FABRICANTE) REFERENCES FABRICANTES(COD_FABRICANTE),
	CONSTRAINT PK_ARTICULOS PRIMARY KEY (ARTICULO,COD_FABRICANTE,PESO,CATEGORIA)
);


CREATE TABLE TIENDAS
(
	NIF VARCHAR2(9),
	NOMBRE VARCHAR2(20),
	DIRECCION VARCHAR2(20),
	POBLACION VARCHAR2(20),
	PROVINCIA VARCHAR2(20),
	CODPOSTAL NUMBER(5),
	CONSTRAINT PK_TIENDAS PRIMARY KEY (NIF)
);


CREATE TABLE PEDIDOS
(
	NIF VARCHAR2(9),
	ARTICULO VARCHAR2(20),
	COD_FABRICANTE NUMBER(3),
	PESO NUMBER(3),
	CATEGORIA VARCHAR2(10),
	FECHA_PEDIDO DATE,
	UNIDADES_PEDIDAS NUMBER(4),
	CONSTRAINT FK1_PEDIDOS FOREIGN KEY (NIF) REFERENCES TIENDAS(NIF),
	CONSTRAINT FK2_PEDIDOS FOREIGN KEY (ARTICULO,COD_FABRICANTE,PESO,CATEGORIA) REFERENCES ARTICULOS(ARTICULO,COD_FABRICANTE,PESO,CATEGORIA) ON DELETE CASCADE,
	CONSTRAINT FK3_PEDIDOS FOREIGN KEY (COD_FABRICANTE) REFERENCES FABRICANTES(COD_FABRICANTE),
	CONSTRAINT PK_PEDIDOS PRIMARY KEY (NIF,ARTICULO,COD_FABRICANTE,PESO,CATEGORIA,FECHA_PEDIDO)
);

CREATE TABLE VENTAS 
(
	NIF VARCHAR2(9),
	ARTICULO VARCHAR2(20),
	COD_FABRICANTE NUMBER(3),
	PESO NUMBER(3),
	CATEGORIA VARCHAR2(10),
	FECHA_VENTA DATE,
	UNIDADES_VENDIDAS NUMBER(4),
	CONSTRAINT FK1_VENTAS FOREIGN KEY (ARTICULO,COD_FABRICANTE,PESO,CATEGORIA) REFERENCES ARTICULOS(ARTICULO,COD_FABRICANTE,PESO,CATEGORIA) ON DELETE CASCADE,
	CONSTRAINT FK2_VENTAS FOREIGN KEY (NIF) REFERENCES TIENDAS(NIF),
	CONSTRAINT FK3_VENTAS FOREIGN KEY (COD_FABRICANTE) REFERENCES FABRICANTES(COD_FABRICANTE),
	CONSTRAINT PK_VENTAS PRIMARY KEY (NIF,ARTICULO,COD_FABRICANTE,PESO,CATEGORIA,FECHA_VENTA)
);

-- Añadir restricciones a la tabla fabricantes --
ALTER TABLE FABRICANTES ADD CONSTRAINT CHK1_NOMBRE CHECK (NOMBRE = UPPER(NOMBRE));
ALTER TABLE FABRICANTES ADD CONSTRAINT CHK2_PAIS CHECK (PAIS = UPPER(PAIS));

-- Añadir restricciones a la tabla articulos --
ALTER TABLE ARTICULOS ADD CONSTRAINT CHK1_PRECIO_VENTA CHECK (PRECIO_VENTA > 0);
ALTER TABLE ARTICULOS ADD CONSTRAINT CHK2_PRECIO_COSTO CHECK (PRECIO_COSTO > 0);
ALTER TABLE ARTICULOS ADD CONSTRAINT CHK3_PESO CHECK (PESO > 0);
ALTER TABLE ARTICULOS ADD CONSTRAINT CHK4_CATEGORIA CHECK ((UPPER(CATEGORIA) = 'PRIMERA') OR (UPPER(CATEGORIA) = 'SEGUNDA') OR (UPPER(CATEGORIA)) = 'TERCERA');

-- Añadir restricciones a la tabla tiendas -- 
ALTER TABLE TIENDAS ADD CONSTRAINT CHK1_PROVINCIA CHECK (PROVINCIA = UPPER(PROVINCIA));

--Añadir restricciones a la tabla pedidos --
ALTER TABLE PEDIDOS ADD CONSTRAINT CHK1_UNIDADES_PEDIDAS CHECK (UNIDADES_PEDIDAS > 0);

--Añadir restricciones a la tabla ventas --
ALTER TABLE VENTAS ADD CONSTRAINT CHK1_UNIDADES_VENDIDAS CHECK (UNIDADES_VENDIDAS > 0);
ALTER TABLE VENTAS MODIFY FECHA_VENTA DEFAULT (SYSDATE);

--últimos apartados --
ALTER TABLE PEDIDOS MODIFY UNIDADES_PEDIDAS NUMBER(6);
ALTER TABLE VENTAS MODIFY UNIDADES_VENDIDAS NUMBER(6);

ALTER TABLE PEDIDOS ADD  PVP_ARTICULO NUMBER(4);
ALTER TABLE VENTAS ADD  PVP_ARTICULO NUMBER(4);

ALTER TABLE FABRICANTES DROP COLUMN PAIS;

ALTER TABLE VENTAS ADD CONSTRAINT CHK_UNIDADES_VENDIDAS2 CHECK (UNIDADES_VENDIDAS > 100);

ALTER TABLE VENTAS DROP CONSTRAINT CHK_UNIDADES_VENDIDAS2;



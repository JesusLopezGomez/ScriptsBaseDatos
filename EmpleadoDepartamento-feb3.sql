CREATE TABLE EMPLEADO
(
	NUMERO_EMP INTEGER(5),
	APELLIDO VARCHAR(15),
	OFICIO VARCHAR(15),
	DIRECTOR INTEGER(5),
	FECHA_ALTA DATE,
	SALARIO INTEGER(8),
	COMISION INTEGER(8),
	NUMERO_DEPARTAMENTO INTEGER(5),
	CONSTRAINT PK_EMPLEADO PRIMARY KEY (NUMERO_EMP)
);

CREATE TABLE DEPARTAMENTO
(
	NUMERO_DEPARTAMENTO INTEGER(5),
	NOMBRE_DEPARTAMENTO VARCHAR(15),
	LOCALIDAD VARCHAR(15),
	CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (NUMERO_DEPARTAMENTO)
);

ALTER TABLE EMPLEADO ADD CONSTRAINT FK1_EMPLEADO FOREIGN KEY (NUMERO_DEPARTAMENTO) REFERENCES DEPARTAMENTO(NUMERO_DEPARTAMENTO);
ALTER TABLE EMPLEADO ADD CONSTRAINT FK2_EMPLEADO FOREIGN KEY (DIRECTOR) REFERENCES EMPLEADO(NUMERO_EMP);

/*Insercción de datos de Departamento */
INSERT INTO DEPARTAMENTO VALUES (10,'CONTABILIDAD','SEVILLA');
INSERT INTO DEPARTAMENTO VALUES (20,'INVESTIGACION','MADRID');
INSERT INTO DEPARTAMENTO VALUES (30,'VENTAS','BARCELONA');
INSERT INTO DEPARTAMENTO VALUES (40,'PRODUCCION','BILBAO');

INSERT INTO EMPLEADO VALUES(7369,'SANCHEZ','EMPLEADO',7902,('1980-12-17'),104000,NULL,20);

INSERT INTO EMPLEADO VALUES(7499,'ARROYO','VENDEDOR',7698,('1980-02-20'),208000,39000,30);

INSERT INTO EMPLEADO VALUES(7521,'SALA','VENDEDOR',7698,('1981-02-22'),162500,162500,30);

INSERT INTO EMPLEADO VALUES(7566,'JIMENEZ','DIRECTOR',7839,('1981-04-02'),386750,NULL,20);

INSERT INTO EMPLEADO VALUES(7654,'MARTIN','VENDEDOR',7698,('1981-09-29'),162500,182000,30);

INSERT INTO EMPLEADO VALUES(7698,'NEGRO','DIRECTOR',7839,('1981-05-01'),370500,NULL,30);

INSERT INTO EMPLEADO VALUES(7788,'GIL','ANALISTA',7566,('1981-11-09'),390000,NULL,20);

INSERT INTO EMPLEADO VALUES(7839,'REY','PRESIDENTE',NULL,('1981-11-17'),650000,NULL,10);

INSERT INTO EMPLEADO VALUES(7844,'TOVAR','VENDEDOR',7698,('1981-09-08'),195000,0,30);

INSERT INTO EMPLEADO VALUES(7876,'ALONSO','EMPLEADO',7788,('1981-09-23'),143000,NULL,20);

INSERT INTO EMPLEADO VALUES(7900,'JIMENO','EMPLEADO',7698,('1981-12-03'),1235000,NULL,30);

INSERT INTO EMPLEADO VALUES(7902,'FERNANDEZ','ANALISTA',7566,('1981-12-03'),390000,NULL,20);

INSERT INTO EMPLEADO VALUES(7934,'MUÑOZ','EMPLEADO',NULL,('1982-01-23'),169000,NULL,10);

/*Consultas*/
#1
SELECT APELLIDO,OFICIO,NUMERO_DEPARTAMENTO 
FROM EMPLEADO e;
#2
SELECT NUMERO_DEPARTAMENTO,NOMBRE_DEPARTAMENTO,LOCALIDAD
FROM DEPARTAMENTO d;
#3
SELECT * 
FROM EMPLEADO;
#4
SELECT * 
FROM EMPLEADO e 
ORDER BY APELLIDO ASC;
#5
SELECT * 
FROM EMPLEADO 
ORDER BY NUMERO_DEPARTAMENTO DESC;
#6
SELECT * 
FROM EMPLEADO E,DEPARTAMENTO D  
WHERE D.NUMERO_DEPARTAMENTO = E.NUMERO_DEPARTAMENTO 
ORDER BY E.NUMERO_DEPARTAMENTO DESC,E.APELLIDO ASC;
#8
SELECT * 
FROM EMPLEADO E
WHERE E.SALARIO > 200000; 
#9
SELECT *
FROM EMPLEADO E
WHERE E.OFICIO LIKE 'ANALISTA';
#10
SELECT E.APELLIDO,E.OFICIO 
FROM EMPLEADO E
WHERE E.NUMERO_DEPARTAMENTO = 20;
#11
SELECT *
FROM EMPLEADO E ORDER BY E.APELLIDO ASC;
#12
SELECT E.APELLIDO 
FROM EMPLEADO E
WHERE E.OFICIO LIKE 'VENDEDOR' ORDER BY APELLIDO ASC;
#13
SELECT *
FROM EMPLEADO E
WHERE E.OFICIO LIKE 'ANALISTA' AND E.NUMERO_DEPARTAMENTO = 10;
#14
SELECT *
FROM EMPLEADO E
WHERE E.SALARIO > 200000 OR E.NUMERO_DEPARTAMENTO = 20;
#15
SELECT * 
FROM EMPLEADO E,DEPARTAMENTO D
WHERE E.NUMERO_DEPARTAMENTO = D.NUMERO_DEPARTAMENTO 
ORDER BY E.OFICIO ASC,D.NOMBRE_DEPARTAMENTO ASC;
#16
SELECT *
FROM EMPLEADO E
WHERE E.APELLIDO LIKE 'A%';
#17
SELECT *
FROM EMPLEADO E
WHERE E.APELLIDO LIKE '%Z';
#18
SELECT *
FROM EMPLEADO E
WHERE E.APELLIDO LIKE 'A%'
AND E.OFICIO LIKE '%E%';
#19
SELECT * 
FROM EMPLEADO E
WHERE E.SALARIO BETWEEN 100000 AND 200000;
#20
SELECT *
FROM EMPLEADO E
WHERE E.OFICIO LIKE 'VENDEDOR' AND E.COMISION > 100000;

#21
SELECT *
FROM EMPLEADO E
ORDER BY NUMERO_DEPARTAMENTO ASC,E.APELLIDO DESC;

#22
SELECT NUMERO_EMP,APELLIDO 
FROM EMPLEADO E
WHERE APELLIDO LIKE '%Z' AND SALARIO > 300000;

#23
SELECT *
FROM DEPARTAMENTO D
WHERE LOCALIDAD LIKE 'B%';

#24
SELECT * 
FROM EMPLEADO E
WHERE UPPER('OFICIO') LIKE 'EMPLEADO'
AND (SALARIO > 100000 AND NUMERO_DEPARTAMENTO = 10);

#25
SELECT APELLIDO
FROM EMPLEADO E
WHERE ((E.COMISION IS NULL) OR (E.COMISION = 0));

#26
SELECT APELLIDO
FROM EMPLEADO E
WHERE ((E.COMISION IS NULL) OR (E.COMISION = 0)) AND E.APELLIDO LIKE 'J%';

#27
SELECT APELLIDO
FROM EMPLEADO E
WHERE OFICIO LIKE 'VENDEDOR' OR 'ANALISTA' OR 'EMPLEADO';

#28
SELECT APELLIDO
FROM EMPLEADO E
WHERE OFICIO NOT LIKE ('ANALISTA' OR 'EMPLEADO') AND SALARIO > 200000;

#29
SELECT *
FROM EMPLEADO E
WHERE SALARIO BETWEEN 200000 AND 300000;

#30
SELECT APELLIDO,SALARIO,NUMERO_DEPARTAMENTO 
FROM EMPLEADO E 
WHERE (SALARIO > 200000) AND (NUMERO_DEPARTAMENTO = 10 OR NUMERO_DEPARTAMENTO = 30);

#31
SELECT APELLIDO,NUMERO_EMP
FROM EMPLEADO E
WHERE (SALARIO NOT BETWEEN 100000 AND 200000);

#32
SELECT LOWER(APELLIDO)
FROM EMPLEADO E

#33
SELECT CONCAT(APELLIDO,OFICIO)   
FROM EMPLEADO E

#34
SELECT APELLIDO,LENGTH(APELLIDO) AS LONGITUD_APELLIDO
FROM EMPLEADO E ORDER BY LENGTH(APELLIDO) DESC

#35
SELECT EXTRACT(YEAR FROM E.FECHA_ALTA) AS FECHA_CONTRATACION
FROM EMPLEADO E;

#36
SELECT *
FROM EMPLEADO E 
WHERE YEAR(FECHA_ALTA) = 1992;

#37
SELECT * 
FROM EMPLEADO E 
WHERE MONTHNAME(FECHA_ALTA) = 'FEBRUARY';


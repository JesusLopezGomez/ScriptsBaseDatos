
CREATE TABLE empleados
(dni VARCHAR2(9) PRIMARY KEY,
nomemp VARCHAR2(50),
jefe VARCHAR2(9),
departamento NUMBER,
salario NUMBER(9,2) DEFAULT 1000,
usuario VARCHAR2(50),
fecha DATE,
CONSTRAINT FK_JEFE FOREIGN KEY (jefe) REFERENCES empleados (dni) );
--Crear un trigger sobre la tabla EMPLEADOS para que no se permita que un empleado
--sea jefe de más de cinco empleados.

CREATE OR REPLACE 
	TRIGGER JEF_MIN_5_EMPLE
	BEFORE INSERT ON EMPLEADOS
	FOR EACH ROW
	
DECLARE 
	CANTIDAD_EMPLE NUMBER(5):= 0;
BEGIN 
	
	SELECT COUNT(E.DNI) INTO CANTIDAD_EMPLE
	FROM EMPLEADOS e 
	WHERE E.JEFE LIKE :NEW.JEFE;

	IF CANTIDAD_EMPLE > 4 THEN
		RAISE_APPLICATION_ERROR(-20001, 'El jefe insertado ya es jefe de 5 empleados, inserte otro jefe.');
	END IF;
	
END JEF_MIN_5_EMPLE;

INSERT INTO EMPLEADOS e VALUES ('12345678','EL JEFE',NULL,12,1900,'JEFE',SYSDATE);

INSERT INTO EMPLEADOS e VALUES ('12345671','EMPLE1','12345678',12,1900,'EMPLE',SYSDATE);
INSERT INTO EMPLEADOS e VALUES ('12345672','EMPLE2','12345678',12,1900,'EMPLE',SYSDATE);
INSERT INTO EMPLEADOS e VALUES ('12345673','EMPLE3','12345678',12,1900,'EMPLE',SYSDATE);
INSERT INTO EMPLEADOS e VALUES ('12345674','EMPLE4','12345678',12,1900,'EMPLE',SYSDATE);
INSERT INTO EMPLEADOS e VALUES ('12345675','EMPLE5','12345678',12,1900,'EMPLE',SYSDATE);
INSERT INTO EMPLEADOS e VALUES ('12345676','EMPLE6','12345678',12,1900,'EMPLE',SYSDATE);


--Crear un trigger para impedir que se aumente el salario de un empleado en más de un
--20%.

CREATE OR REPLACE 
	TRIGGER IMP_SUB_SALAR_MAS_20
	BEFORE UPDATE ON EMPLEADOS
	FOR EACH ROW
	
BEGIN 
	IF :NEW.SALARIO > :OLD.SALARIO* 1.20 THEN 
		RAISE_APPLICATION_ERROR(-20002,'Error no se puede subir el salrio a más de un 20% del salario anterior.');
	END IF;
	
END IMP_SUB_SALAR_MAS_20;

UPDATE EMPLEADOS E SET SALARIO = 2400 WHERE E.DNI LIKE '12345678';


CREATE TABLE empleados_baja
( dni VARCHAR2(9) PRIMARY KEY,
nomemp VARCHAR2 (50),
jefe VARCHAR2(9),
departamento NUMBER,
salario NUMBER(9,2) DEFAULT 1000,
usuario VARCHAR2(50),
fecha DATE );
--Crear un trigger que inserte una fila en la tabla empleados_baja cuando se borre una fila
--en la tabla empleados. Los datos que se insertan son los del empleado que se da de baja
--en la tabla empleados, salvo en las columnas usuario y fecha se grabarán las variables
--del sistema USER y SYSDATE que almacenan el usuario y fecha actual

CREATE OR REPLACE 
	TRIGGER BAJA_EMPLEADO
	AFTER DELETE ON EMPLEADOS
	FOR EACH ROW 
	
BEGIN 
	
	INSERT INTO empleados_baja VALUES (:OLD.dni,:OLD.nomemp,:OLD.jefe,:OLD.departamento,:OLD.salario, TO_CHAR(USER), SYSDATE);
	
END BAJA_EMPLEADO;

--Crear un trigger para impedir que, al insertar un empleado, el empleado y su jefe puedan
--pertenecer a departamentos distintos. Es decir, el jefe y el empleado deben pertenecer al
--mismo departamento.

CREATE OR REPLACE 
	TRIGGER JEFE_EMP_MISMO_DPT
	BEFORE INSERT ON EMPLEADOS
	FOR EACH ROW

DECLARE

	NUMERO_DPT_JEFE NUMBER(5) := 0;	
BEGIN 

	SELECT E.DEPARTAMENTO INTO NUMERO_DPT_JEFE
	FROM EMPLEADOS e 
	WHERE E.DNI LIKE :NEW.JEFE;

	IF NUMERO_DPT_JEFE <> :NEW.DEPARTAMENTO THEN 
		RAISE_APPLICATION_ERROR(-20003,'Error el jefe y el empleado tienen que estar en el mismo departamento.');
	END IF;
	
END;

INSERT INTO EMPLEADOS e VALUES ('12345676','EMPLE5','12345678',13,1900,'EMPLE',SYSDATE);

--Crear un trigger para impedir que, al insertar un empleado, la suma de los salarios de los
--empleados pertenecientes al departamento del empleado insertado supere los 10.000
--euros.

CREATE OR REPLACE 
	TRIGGER IMP_SALARIOS_DPT_MAYOR_10000
	BEFORE INSERT ON EMPLEADOS
	FOR EACH ROW 

DECLARE 
	SUMA_SALAR_DPT NUMBER(6) := 0;
BEGIN
	
	SELECT SUM(E.SALARIO) INTO SUMA_SALAR_DPT
	FROM EMPLEADOS e 
	WHERE E.DEPARTAMENTO = :NEW.DEPARTAMENTO;

	IF SUMA_SALAR_DPT > 10000 THEN
		
		RAISE_APPLICATION_ERROR(-20004,'Error la suma de salario del depatarmento de este empleado supera los 10.000€');
	
	END IF;
	
END;

INSERT INTO EMPLEADOS e VALUES ('12345666','EMPLE6','12345678',12,1900,'EMPLE',SYSDATE);

CREATE TABLE controlCambios(
 usuario varchar2(30),
 fecha date,
 tipooperacion varchar2(30),
 datoanterior varchar2(30),
 datonuevo varchar2(30)
);
--Creamos un trigger que se active cuando modificamos algún campo de "empleados" y
--almacene en "controlCambios" el nombre del usuario que realiza la actualización, la
--fecha, el tipo de operación que se realiza, el dato que se cambia y el nuevo valor.

CREATE OR REPLACE 
	TRIGGER MODIFICACION_EMPLE
	AFTER UPDATE ON EMPLEADOS
	FOR EACH ROW
BEGIN 
	
	IF UPDATING('DNI') THEN 
	
		INSERT INTO controlCambios VALUES (TO_CHAR(USER),SYSDATE,'MODIFICACION',TO_CHAR(:OLD.DNI),TO_CHAR(:NEW.DNI));
	
	ELSIF UPDATING('NOMEMP' ) THEN
	
		INSERT INTO controlCambios VALUES (TO_CHAR(USER),SYSDATE,'MODIFICACION',TO_CHAR(:OLD.NOMEMP),TO_CHAR(:NEW.NOMEMP));
		
	ELSIF 
	
	
	
	
END;



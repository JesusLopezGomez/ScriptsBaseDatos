--7.1. Crea un trigger que, cada vez que se inserte o elimine un empleado, registre
--una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del suceso,
--número y nombre de empleado, así como el tipo de operación realizada
--(INSERCIÓN o ELIMINACIÓN).



CREATE OR REPLACE
TRIGGER Insercion_eliminacion_empleado
	AFTER INSERT OR DELETE ON EMPLEADOS
	FOR EACH ROW
BEGIN
	IF INSERTING THEN
		INSERT INTO AUDITORIA_EMPLEADOS
		VALUES(TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS') || ' - INSERCIÓN - '
		|| :new.NUMEM || ' ' || :new.NOMEM );
	ELSIF DELETING THEN
		INSERT INTO AUDITORIA_EMPLEADOS
		VALUES(TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS') || ' - ELIMINACIÓN - '
		|| :old.NUMEM || ' ' || :old.NOMEM );
END IF;
END Insercion_eliminacion_empleado;



INSERT INTO EMPLEADOS e(NUMEM,NOMEM) VALUES(109,'JESUS');

SELECT *
FROM AUDITORIA_EMPLEADOS ae;

--7.2. Crea un trigger que, cada vez que se modi(quen datos de un empleado,
--registre una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del
--suceso, valor antiguo y valor nuevo de cada campo, así como el tipo de operación
--realizada (en este caso MODIFICACIÓN).

CREATE OR REPLACE TRIGGER MODIFICACION_EMPLEADO
	AFTER UPDATE ON EMPLEADOS 
	FOR EACH ROW
BEGIN 
	
	INSERT INTO AUDITORIA_EMPLEADOS VALUES(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH:MI:SS') || ' - MODIFICACIÓN - '|| :OLD.NUMEM || :NEW.NUMEM
	|| :OLD.NOMEM || :NEW.NOMEM|| :OLD.EXTEL || :NEW.EXTEL|| :OLD.FECNA || :NEW.FECNA|| :OLD.FECIN ||:NEW.FECIN || :OLD.SALAR 
	|| :NEW.SALAR|| :OLD.COMIS ||:NEW.COMIS || :OLD.NUMHI || :NEW.NUMHI|| :OLD.NUMDE || :NEW.NUMDE || ' - MODIFICACIÓN - ');
	
END;

UPDATE EMPLEADOS SET NUMEM = 108 WHERE NUMEM = 110;


--5.7.3. Crea un trigger para que registre en la tabla AUDITORIA_EMPLEADOS las
--subidas de salarios superiores al 5%. 
CREATE OR REPLACE TRIGGER SUBIDAS_5_PORCIENTO
	AFTER UPDATE OF SALAR ON EMPLEADOS
	FOR EACH ROW
BEGIN 
	IF :NEW.SALAR*1.05 > :OLD.SALAR THEN 
		INSERT INTO AUDITORIA_EMPLEADOS VALUES(:OLD.NOMEM || ' - Salario antiguo: ' || :OLD.SALAR || ' - Salario nuevo: ' || :NEW.SALAR);
	END IF;
END;


SELECT E.SALAR 
FROM EMPLEADOS e;

UPDATE EMPLEADOS SET SALAR = 1900 WHERE SALAR = 1800;

--7.4. Deseamos operar sobre los datos de los departamentos y los centros donde
--se hallan. Para ello haremos uso de la vista SEDE_DEPARTAMENTOS creada
--anteriormente. Al tratarse de una vista que involucra más de una tabla,
--necesitaremos crear un trigger de sustitución para gestionar las operaciones de
--actualización de la información. Crea el trigger necesario para realizar inserciones,
--eliminaciones y modi(caciones en la vista anterior.

CREATE OR REPLACE 
	TRIGGER OPERAR_DATOS_DPT_CENTROS_C
	INSTEAD OF INSERT OR UPDATE OR DELETE ON SEDE_DEPARTAMENTOS
	
BEGIN 
	
	IF INSERTING THEN 
		INSERT INTO CENTROS VALUES(:NEW.NUMCE, :NEW.NOMCE, :NEW.DIRCE);
		INSERT INTO DEPARTAMENTOS (:NEW.NUMDE, :NEW.NUMCE, :NEW.DIREC, :NEW.TIDIR, :NEW.PRESU, :NEW.DEPDE, :NEW.NOMDE);
	END IF;
	
END OPERAR_DATOS_DPT_CENTROS_C;

INSERT INTO SEDE_DEPARTAMENTOS VALUES(12,'La mina','Loco',12,'Locotrones',120.2,1.2,'A',12);


	





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

CREATE OR REPLACE 
TRIGGER MODIFICACION_EMPLEADO
	AFTER UPDATE ON EMPLEADOS 
	FOR EACH ROW
BEGIN 
	
	INSERT INTO AUDITORIA_EMPLEADOS VALUES(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH:MI:SS') || ' - MODIFICACIÓN - '|| 
									'Número antiguo: ' || :OLD.NUMEM || ' Número nuevo: ' || :NEW.NUMEM  ||
									' Nombre antiguo: ' || :OLD.NOMEM || ' Nombre nuevo: ' || :NEW.NOMEM  ||
									' EXTEL antiguo: '  || :OLD.EXTEL || ' EXTEL nuevo: '   || :NEW.EXTEL ||
									' FECNA antiguo: '  || :OLD.FECNA || ' FECNA nuevo: ' || :NEW.FECNA ||
									' FECIN antiguo: '  || :OLD.FECIN || ' FECIN nuevo: ' || :NEW.FECIN ||
									' SALAR antiguo: '  || :OLD.SALAR  || ' SALAR nuevo: '|| :NEW.SALAR ||
									' COMIS antiguo: '  || :OLD.COMIS || ' COMIS nuevo: ' || :NEW.COMIS ||
									' NUMHI antiguo: ' || :OLD.NUMHI || ' NUMHI nuevo: ' || :NEW.NUMHI  ||
									' NUMDE antiguo: ' || :OLD.NUMDE || ' NUMDE nuevo: ' || :NEW.NUMDE);
	
END;

UPDATE EMPLEADOS SET NUMEM = 108 WHERE NUMEM = 110;




CREATE OR REPLACE PROCEDURE CABALLOS.LISTADO (NOMBREEMPLEADO IN OUT VARCHAR2, EDAD IN OUT NUMBER)
IS 
BEGIN
	IF NOMBREEMPLEADO IS NULL THEN 
		NOMBREEMPLEADO:='MARTA';
	END IF;
	IF EDAD<10 THEN 
		EDAD:=18;
	END IF;
END;

DECLARE
EDAD_E NUMBER(10);
NOMBRE VARCHAR2(50);
BEGIN 
	EDAD_E:=4;
	LISTADO(NOMBRE,EDAD_E);
	DBMS_OUTPUT.PUT_LINE(NOMBRE ||' ' || EDAD_E);
END;
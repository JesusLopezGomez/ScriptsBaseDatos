--Realizar un procedure que se llame insertar_alumno, que recibirá como parámetro el nombre 
--y apellido de una persona, e inserte de forma automática esa persona como alumno.

CREATE OR REPLACE 
PROCEDURE Insertar_alumno(NOMBRE_P VARCHAR2, APELLIDO_P VARCHAR2) 
IS

ID_ALUMNO VARCHAR2(40);
DNI_ALUMNO VARCHAR2(40);

BEGIN
	--Compruebo si el alumno existe
	SELECT P.DNI INTO DNI_ALUMNO
	FROM PERSONA p 
	WHERE P.NOMBRE LIKE NOMBRE_P
	AND P.APELLIDO LIKE APELLIDO_P;	

	SELECT TO_CHAR(MAX(TO_NUMBER(SUBSTR(A.IDALUMNO,2))+1)) INTO ID_ALUMNO
	FROM ALUMNO a;
	
	INSERT INTO ALUMNO a VALUES('A'||ID_ALUMNO,DNI_ALUMNO);
	COMMIT;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Esa persona no existe.');
		WHEN OTHERS THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error' || SQLCODE || ' ' || SQLERRM);
END;

BEGIN
	Insertar_alumno('JOSELITO','LOCOTRON');
END;


--Realizar una función que reciba como parámetro el nombre y el apellido de una persona, 
--también debe recibir un parámetro que podrá ser un 1 (en ese caso debe insertarlo como un alumno)
-- o un 2 (debe insertarlo como profesor), y un parámetro de entrada salida en el que deberá devolver 
--el código del profesor o alumno insertado. La función deberá devolver un 1 si se ha podido realizar 
--la inserción, y un cero si ha ocurrido algún error.


CREATE OR REPLACE FUNCTION UNIVERSIDAD.INSERTAR_ALUMNO_O_PROFESOR(NOMBRE VARCHAR2, APELLIDO VARCHAR2, NUMERO NUMBER) 
RETURN NUMBER
IS 

DNI_PERSONA VARCHAR2(20);
ID_PROFESOR VARCHAR2(15);
NUMERO_RETURN NUMBER(10) := 0;

BEGIN 
	--Compruebo si existe la persona
	SELECT P.DNI INTO DNI_PERSONA
	FROM PERSONA p 
	WHERE P.NOMBRE LIKE NOMBRE
	AND P.APELLIDO LIKE APELLIDO;	
	
	IF NUMERO = 1 THEN 
		
		Insertar_alumno(NOMBRE,APELLIDO);
		
		NUMERO_RETURN := 1;	
	
	END IF;

	IF NUMERO = 2 THEN 
	
		SELECT TO_CHAR(MAX(TO_NUMBER(SUBSTR(P.IDPROFESOR,2))+1)) INTO ID_PROFESOR
		FROM PROFESOR p ;
	
		INSERT INTO PROFESOR p VALUES ('P'||ID_PROFESOR,DNI_PERSONA);
	
		NUMERO_RETURN := 1;
	
	END IF;

	RETURN NUMERO_RETURN;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Esa persona no existe.');
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error' || SQLCODE || ' ' || SQLERRM);
END;

SELECT INSERTAR_ALUMNO_O_PROFESOR('JOSELITO','LOCOTRON',1)
FROM DUAL;

SELECT *
FROM PERSONA p;

SELECT *
FROM PROFESOR p;


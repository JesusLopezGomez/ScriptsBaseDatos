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
	Insertar_alumno('JESUS','LOPEZ');
END;

CREATE OR REPLACE 
PROCEDURE Insertar_profesorS(NOMBRE_P VARCHAR2, APELLIDO_P VARCHAR2) 
IS

ID_PROFESOR VARCHAR2(40);
DNI_ALUMNO VARCHAR2(40);

BEGIN
	--Compruebo si el profesor existe
	SELECT P.DNI INTO DNI_ALUMNO
	FROM PERSONA p 
	WHERE P.NOMBRE LIKE NOMBRE_P
	AND P.APELLIDO LIKE APELLIDO_P;	

	SELECT TO_CHAR(MAX(TO_NUMBER(SUBSTR(p.IDPROFESOR ,2))+1)) INTO ID_PROFESOR
	FROM PROFESOR p ;
	
	INSERT INTO PROFESOR P VALUES('p'||ID_PROFESOR,DNI_ALUMNO);
	COMMIT;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Esa persona no existe.');
		WHEN OTHERS THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error' || SQLCODE || ' ' || SQLERRM);
END;


--Crear un procedure para que se llame tres o más veces a la función anterior, mostrando 
--el mensaje “El alumno XXXX ha sido insertado”, o “El alumno XXXX no ha sido insertado, 
--y lo mismo con profesores donde XXXX será el dato concreto.

CREATE OR REPLACE PROCEDURE UNIVERSIDAD.BUCLE_LLAMADA_3
IS 

numero number(5);

BEGIN 
	FOR I IN 1..3 LOOP 
		
		numero:= INSERTAR_ALUMNO_O_PROFESOR('JESUS','LOPEZ',2);
	
		IF numero = 1 THEN
			DBMS_OUTPUT.PUT_LINE('El alumno XXXX ha sido insertado');
		ELSIF numero = 2 THEN
			DBMS_OUTPUT.PUT_LINE('El profesor XXXX ha sido insertado');
		ELSE
			DBMS_OUTPUT.PUT_LINE('El profesor o el profesor XXXX no ha sido insertado');
		END IF;
		
	END LOOP;
END;

BEGIN
	BUCLE_LLAMADA_3;
END;

--Realizar una función que reciba como parámetro el nombre y el apellido de una persona, 
--también debe recibir un parámetro que podrá ser un 1 (en ese caso debe insertarlo como un alumno)
-- o un 2 (debe insertarlo como profesor), y un parámetro de entrada salida en el que deberá devolver 
--el código del profesor o alumno insertado. La función deberá devolver un 1 si se ha podido realizar 
--la inserción, y un cero si ha ocurrido algún error.

CREATE OR REPLACE FUNCTION UNIVERSIDAD.INSERTAR_ALUMNO_O_PROFESOR(V_NOMBRE VARCHAR2, V_APELLIDO VARCHAR2, NUMERO_INTRO NUMBER) 
RETURN NUMBER
IS 

DNI_PERSONA VARCHAR2(20);
ID_PROFESOR VARCHAR2(15);
RETURN_NUM NUMBER(5) := 0;

BEGIN 
	--Compruebo si existe la persona
	SELECT P.DNI INTO DNI_PERSONA
	FROM PERSONA p 
	WHERE P.NOMBRE LIKE V_NOMBRE
	AND P.APELLIDO LIKE V_APELLIDO;	
	
	IF NUMERO_INTRO = 1 THEN 	
		RETURN_NUM := 1;
		
		Insertar_alumno(V_NOMBRE,V_APELLIDO);
		
		RETURN RETURN_NUM;	
	
	END IF;

	IF NUMERO_INTRO = 2 THEN 
		RETURN_NUM := 1;
		
		
		Insertar_profesorS(V_NOMBRE,V_APELLIDO);	
		
		RETURN RETURN_NUM;
	END IF;
	

	RETURN RETURN_NUM;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Esa persona no existe.');
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error' || SQLCODE || ' ' || SQLERRM);
	
END;


DECLARE 

RETORNADO NUMBER(5);

BEGIN
	RETORNADO := INSERTAR_ALUMNO_O_PROFESOR('JESUS','LOPEZ',2);
	DBMS_OUTPUT.PUT_LINE(RETORNADO);
END;


SELECT P.*
FROM PERSONA p


INSERT INTO PERSONA P VALUES ('1234556C','JESUS','LOPEZ','SEVILA',' ',1,129139,SYSDATE,1);



--Realizar una función que devuelva un 1 si el nombre y apellido de la persona que se
--le pasa por parámetro es un alumno, un dos si es un profesor y un 0 si no está en la base de datos

CREATE OR REPLACE
FUNCTION COMPROBAR_ALUMNO_PROFESOR(V_NOMBRE VARCHAR2, V_APELLIDO VARCHAR2)
RETURN NUMBER
IS 

EXISTE_ALUMNO NUMBER(5);
EXISTE_PROFE NUMBER(5);
RETURN_NUM NUMBER(5) := 0;

BEGIN 
	
	SELECT COUNT(P.DNI) INTO EXISTE_PROFE
	FROM PERSONA p, PROFESOR p2 
	WHERE P.DNI = P.DNI
	AND P.NOMBRE LIKE V_NOMBRE
	AND P.APELLIDO LIKE V_APELLIDO;

	SELECT COUNT(P.DNI) INTO EXISTE_ALUMNO
	FROM PERSONA p, ALUMNO a 
	WHERE P.DNI = A.DNI
	AND P.NOMBRE LIKE V_NOMBRE
	AND P.APELLIDO LIKE V_APELLIDO;

	IF EXISTE_ALUMNO > 0 THEN
		RETURN_NUM := 1;
		RETURN RETURN_NUM;
	ELSIF EXISTE_PROFE > 0 THEN
		RETURN_NUM := 2;
		RETURN RETURN_NUM;

	ELSE
		RETURN RETURN_NUM;
	END IF;

END;

SELECT COMPROBAR_ALUMNO_PROFESOR('JESUSZ','LOPEZZ') FROM dual;


--⦁	Crear un procedure que reciba como parámetro el nombre de una titulación, 
-- el nombre de la asignatura, y el nombre y apellido del profesor (en dos parámetros distintos),
-- y que inserte esos datos en la tabla de asignatura. Si se produce un error notificarlo. Los errores que deben notificarse son:
		--⦁	No existe la titulación
		--⦁	No existe la personas
		--⦁	La persona no es un profesor
		--⦁	El nombre de la asignatura ya está en la base de datos.

CREATE OR REPLACE 
PROCEDURE CREAR_ASIGNATURA (NOMBRE_T VARCHAR2, NOMBRE_A VARCHAR2, NOMBRE_P VARCHAR2, APELLIDO_P VARCHAR2)
IS 

EXISTE_TITULACION NUMBER(5);
EXISTE_PERSONA NUMBER(5);
PERSONA_ES_PROFESOR NUMBER(5);
NOMBRE_ASIGNATURA_EN_BD NUMBER(5);
COD_ASIGNATURA VARCHAR2(10);
ID_PROFESOR VARCHAR2(10);
ID_TITU VARCHAR2(10);

BEGIN 
	
	SELECT COUNT(P.DNI) INTO EXISTE_PERSONA
	FROM PERSONA p
	WHERE P.NOMBRE LIKE NOMBRE_P
	AND P.APELLIDO LIKE APELLIDO_P;

	SELECT COUNT(T.IDTITULACION) INTO EXISTE_TITULACION
	FROM TITULACION t 
	WHERE T.NOMBRE LIKE NOMBRE_T;

	SELECT COUNT(P.DNI) INTO PERSONA_ES_PROFESOR
	FROM PERSONA p, PROFESOR p2 
	WHERE P.DNI = P2.DNI 
	AND P.NOMBRE LIKE NOMBRE_P
	AND P.APELLIDO LIKE APELLIDO_P;

	SELECT COUNT(A.IDASIGNATURA) INTO NOMBRE_ASIGNATURA_EN_BD
	FROM ASIGNATURA a 
	WHERE A.NOMBRE LIKE NOMBRE_A;

	IF EXISTE_PERSONA = 0 THEN
		RAISE_APPLICATION_ERROR(-20001, 'No existe persona');
	
	ELSIF EXISTE_TITULACION = 0 THEN 
		RAISE_APPLICATION_ERROR(-20002, 'No existe titulacion');
	
	ELSIF PERSONA_ES_PROFESOR = 0 THEN 
		RAISE_APPLICATION_ERROR(-20003, 'Esa persona no es profesor');
		
	ELSIF NOMBRE_ASIGNATURA_EN_BD > 0 THEN 
			RAISE_APPLICATION_ERROR(-20004, 'Esa asignatura ya existe en la base de datos');
	ELSE
	
		SELECT TO_CHAR(MIN(TO_NUMBER(A.IDASIGNATURA)+1)) INTO COD_ASIGNATURA
		FROM ASIGNATURA a;
		
		SELECT P2.IDPROFESOR INTO ID_PROFESOR
		FROM PERSONA p, PROFESOR p2 
		WHERE P.DNI = P2.DNI 
		AND P.NOMBRE LIKE NOMBRE_P
		AND P.APELLIDO LIKE APELLIDO_P;
	
		SELECT T.IDTITULACION INTO ID_TITU
		FROM TITULACION t 
		WHERE T.NOMBRE LIKE NOMBRE_T;
		
		INSERT INTO ASIGNATURA VALUES (COD_ASIGNATURA,NOMBRE_A,2,1,60,ID_PROFESOR,ID_TITU,2);
	
	END IF;
	
END;

SELECT *
FROM ASIGNATURA a;

SELECT *
FROM TITULACION t ;

BEGIN
	CREAR_ASIGNATURA('Matematicas', 'Seguridad Via', 'JESUS', 'LOPEZ');
END;

INSERT INTO ASIGNATURA VALUES ('12345','Seguridad Via',2,1,60,'p307','130110',2);



--Desarrolla el paquete ARITMETICA cuyo código fuente viene en este tema.
--Crea un archivo para la especi(cación y otro para el cuerpo. Realiza varias pruebas
--para comprobar que las llamadas a funciones y procedimiento funcionan
--correctamente.

CREATE OR REPLACE
PACKAGE BODY aritmetica IS

  PROCEDURE mostrar_info IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE
      ('Paquete de operaciones aritméticas. Versión ' || version);
  END mostrar_info;

  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a+b);
  END suma;

  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a-b);
  END resta;

  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a*b);
  END multiplica;

  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a/b);
  END divide;
 
  FUNCTION RESTO (A NUMBER, B NUMBER) RETURN NUMBER IS
  BEGIN 
	  RETURN MOD(A,B);
  END RESTO;
  PROCEDURE AYUDA IS 
  BEGIN 
DBMS_OUTPUT.PUT_LINE('Procedimientos disponibles: mostrar_info, este nos el nombre del paquete.
						Funciones: suma, suma dos numeros, resta, resta dos numeros, multipica, 
						multiplica dos numeros, divide, divide dos numeros, y resto te da el resto de los dos numeros introducidos.
						A todas las funciones se le tiene que meter dos numeros');
  END AYUDA;

END aritmetica;

--Pruebas--
BEGIN
	ARITMETICA.mostrar_info;
	ARITMETICA.AYUDA;
END;

SELECT ARITMETICA.suma(4,5) FROM DUAL;
SELECT ARITMETICA.resta(5,3) FROM DUAL;
SELECT ARITMETICA.MULTIPLICA(2,3) FROM DUAL;
SELECT ARITMETICA.DIVIDE(6,2) FROM DUAL;
SELECT ARITMETICA.RESTO(6,4) FROM DUAL; 
--Pruebas--

--Desarrolla el paquete GESTION. En un principio tendremos los
--procedimientos para gestionar los departamentos. Dado el archivo de
--especi(cación mostrado más abajo crea el archivo para el cuerpo. Realiza varias
--pruebas para comprobar que las llamadas a funciones y procedimientos funcionan
--correctamente

CREATE OR REPLACE
PACKAGE BODY GESTION IS

	PROCEDURE CREAR_DEP (nombre VARCHAR2, presupuesto NUMBER, numero NUMBER) IS 
	BEGIN 
		
		CREATE TABLE DEP(
			NOMBRED VARCHAR(20),
			PRESUPUESTOD NUMBER(7),
			NUMERO NUMBER(7),
			CONSTRAINT PK_DEP PRIMARY KEY(NUMERO)
		);
	
	INSERT INTO DEP(NOMBRED,PRESUPUESTOD,NUMERO) VALUES (nombre, presuesto,numero);
	END;

FUNCTION NUM_DEP (nombre VARCHAR2) 
RETURN NUMBER
	NUMERO NUMBER(10)
IS
	SELECT D.DEPTNO INTO NUMERO
	FROM DEPT d 
	WHERE D.DNAME LIKE nombre;

	RETURN NUMERO;
END NUM_dEP;

PROCEDURE MOSTRAR_DEP (numero NUMBER)
IS
DEPT DEPT%ROWTYPE;
BEGIN
	SELECT * INTO DEPT
	FROM DEP d 
	WHERE D.NUMERO = numero;
	
	DBMS_OUTPUT.PUT_LINE(DEPT);
	
END;

PROCEDURE BORRAR_DEP (numero NUMBER)
IS
BEGIN
	DELETE FROM DEP d WHERE D.NUMERO = numero;
END;

PROCEDURE MODIFICAR_DEP (numero NUMBER, presupuesto NUMBER)
IS
BEGIN
	UPDATE DEP D WHERE D.NUMERO = numero SET D.PRESUPUESTOD = presupuesto;
END;


END GESTION;

--pruebas

BEGIN
	GESTION.MOSTRAR_DEP(10);
END;


--pruebas


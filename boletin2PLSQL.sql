--Crea un procedimiento llamado ESCRIBE para mostrar por pantalla el
--mensaje HOLA MUNDO.

CREATE OR REPLACE 
PROCEDURE ESCRIBE
AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('HOLA MUNDO');
END;

BEGIN
	ESCRIBE();
END;

--Crea un procedimiento llamado ESCRIBE_MENSAJE que tenga un
--parámetro de tipo VARCHAR2 que recibe un texto y lo muestre por pantalla.
--La forma del procedimiento ser. la siguiente:

CREATE OR REPLACE 
PROCEDURE ESCRIBE2(TEXTO VARCHAR2)
AS
BEGIN
	DBMS_OUTPUT.PUT_LINE(TEXTO);
END;

BEGIN
	ESCRIBE2('PLSQL');
END;

--Crea un procedimiento llamado SERIE que muestre por pantalla una serie de
--números desde un mínimo hasta un máximo con un determinado paso. La
--forma del procedimiento ser. la siguiente:

CREATE OR REPLACE 
PROCEDURE SERIE(MINIMO NUMBER, MAXIMO NUMBER, PASO NUMBER)
AS 
DECLARE 
	MINIMO NUMBER(6) := MINIMO
BEGIN 
	 WHILE MINIMO <= MAXIMO LOOP
	 	DBMS_OUTPUT.PUT_LINE (MINIMO);
	 	MINIMO = MINIMO+PASO;
	 END LOOP;
END;

BEGIN
	SERIE(1,10,2);
END;


--Crea una función AZAR que reciba dos parámetros y genere un número al
--azar entre un mínimo y máximo indicado. La forma de la función será la
--siguiente:
CREATE OR REPLACE 
FUNCTION AZAR(MINIMO NUMBER,MAXIMO NUMBER)
RETURN NUMBER
IS BEGIN 
	
END;

--Crea una función NOTA que reciba un parámetro que será una nota numérica
--entre 0 y 10 y devuelva una cadena de texto con la calificación (Suficiente,
--Bien, Notable, ...). La forma de la función será la siguiente:

CREATE OR REPLACE 
FUNCTION NOTA(NOTA NUMBER)
RETURN VARCHAR2 
IS BEGIN 
	IF NOTA = 10 OR NOTA=9 THEN 
		DBMS_OUTPUT.PUT_LINE('Sobresaliente');
	ELSIF NOTA = 8 OR NOTA = 7 THEN 
		DBMS_OUTPUT.PUT_LINE('Notable');
	ELSIF NOTA = 6 THEN 
		DBMS_OUTPUT.PUT_LINE('Bien');

	ELSIF NOTA = 5 THEN 
		DBMS_OUTPUT.PUT_LINE('Suficiente');

	ELSIF NOTA < 5 AND NOTA > 0 THEN
		DBMS_OUTPUT.PUT_LINE('Insuficiente');
	END IF;
END;

SELECT NOTA(4) AS CALIFICACION FROM DUAL;








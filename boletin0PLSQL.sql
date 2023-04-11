BEGIN
	 IF 10 > 5 THEN
		 DBMS_OUTPUT.PUT_LINE ('Cierto');
	 ELSE
		 DBMS_OUTPUT.PUT_LINE ('Falso');
	 END IF;
END;

--Resultado esperado: cierto
--Resultado obtenido: cierto

BEGIN
IF 10 > 5 AND 5 > 1 THEN
	 	DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
		 DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;

--Resultado esperado: cierto
--Resultado obtenido: cierto

BEGIN
	IF 10 > 5 AND 5 > 50 THEN
 		DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
 		DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;

--Resultado esperado: falso
--Resultado obtenido: falso

BEGIN
	CASE
		 WHEN 10 > 5 AND 5 > 50 THEN
		 	DBMS_OUTPUT.PUT_LINE ('Cierto');
		 ELSE
			 DBMS_OUTPUT.PUT_LINE ('Falso');
	END CASE;
END;

--Resultado esperado: falso
--Resultado obtenido: falso

BEGIN
	 FOR i IN 1..10 LOOP
		 DBMS_OUTPUT.PUT_LINE (i);
	 END LOOP;
END;

--Resultado esperado: del 1 al 10
--Resultado obtenido: del 1 al 10

BEGIN
	 FOR i IN REVERSE 1..10 LOOP
		 DBMS_OUTPUT.PUT_LINE (i);
	 END LOOP;
END;

--Resultado esperado: del 10 al 1
--Resultado obtenido: del 10 al 1


DECLARE
 	num NUMBER(3) := 0;
BEGIN
	 WHILE num<=100 LOOP
	 	DBMS_OUTPUT.PUT_LINE (num);
	 	num:= num+2;
	 END LOOP;
END;

--Resultado esperado: numeros pares o de dos en dos hasta el 100
--Resultado obtenido: numeros pares o de dos en dos hasta el 100

DECLARE
	 num NUMBER(3) := 0;
BEGIN
	 LOOP
	 	DBMS_OUTPUT.PUT_LINE (num);
	 IF num > 100 THEN EXIT; END IF;
	 	num:= num+2;
	 END LOOP;
END;

--Resultado esperado: numeros pares hasta que el numero sea mayor que 100
--Resultado obtenido: numeros pares hasta que el numero sea mayor que 100

DECLARE
 	num NUMBER(3) := 0;
BEGIN
	 LOOP
		 DBMS_OUTPUT.PUT_LINE (num);
	 EXIT WHEN num > 100;
	 num:= num+2;
	 END LOOP;
END;

--Resultado esperado: numeros pares hasta que el numero sea mayor que 100
--Resultado obtenido: numeros pares hasta que el numero sea mayor que 100

<<<<<<< HEAD
--Escribe un procedimiento que muestre el número de empleados y el salario
--mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
--uso de cursores implícitos, es decir utilizar SELECT ... INTO
CREATE OR REPLACE 
PROCEDURE EJERCICIO1
AS
	NUM_EMPLEADOS NUMBER;
	MINIMO NUMBER;
	MAXIMO NUMBER;
	MEDIA NUMBER;
BEGIN 
	SELECT COUNT(E.NUMEM),MIN(E.SALAR),MAX(E.SALAR),AVG(E.SALAR) INTO NUM_EMPLEADOS,MINIMO,MAXIMO,MEDIA
	FROM EMPLEADOS E, DEPARTAMENTOS D
	WHERE E.NUMDE = D.NUMDE AND D.NOMDE LIKE 'FINANZAS';

	DBMS_OUTPUT.PUT_LINE(NUM_EMPLEADOS);
	DBMS_OUTPUT.PUT_LINE(MINIMO);
	DBMS_OUTPUT.PUT_LINE(MAXIMO);
	DBMS_OUTPUT.PUT_LINE(MEDIA);
END;

BEGIN
	EJERCICIO1;
END;

--Escribe un procedimiento que suba un 10% el salario a los EMPLEADOS
--con más de 2 hijos y que ganen menos de 2000 €. Para cada empleado se
--mostrar por pantalla el código de empleado, nombre, salario anterior y final.
--Utiliza un cursor explícito. La transacción no puede quedarse a medias. Si
--por cualquier razón no es posible actualizar todos estos salarios, debe
--deshacerse el trabajo a la situación inicial.
CREATE OR REPLACE PROCEDURE EJERCICIO2
AS 	
CURSOR C_EJERCICIO2 IS 
	SELECT E.NUMEM, E.NOMEM, E.SALAR
	FROM EMPLEADOS E
	WHERE E.SALAR < 2000 AND E.NUMHI > 2;

	COD_EMPLE EMPLEADOS.NUMEM%TYPE;
	NOMBRE_EMPLE EMPLEADOS.NOMEM%TYPE;
	SALARIO_EMPLE EMPLEADOS.SALAR%TYPE;
BEGIN 
	OPEN C_EJERCICIO2;
	LOOP
		
		FETCH C_EJERCICIO2 INTO COD_EMPLE,NOMBRE_EMPLE,SALARIO_EMPLE;
		EXIT WHEN C_EJERCICIO2%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Código empleado: ' || ' ' ||COD_EMPLE);
		DBMS_OUTPUT.PUT_LINE('Nombre empleado: ' || ' ' ||NOMBRE_EMPLE);
		DBMS_OUTPUT.PUT_LINE('Salario anterior: ' || ' '||SALARIO_EMPLE);
		DBMS_OUTPUT.PUT_LINE('Salario final: ' || ' '||(SALARIO_EMPLE + (SALARIO_EMPLE*0.10)));
		DBMS_OUTPUT.PUT_LINE('------------');
	END LOOP;
	CLOSE C_EJERCICIO2;
END;

BEGIN
	EJERCICIO2;
END;
--Escribe un procedimiento que reciba dos parámetros (número de
--departamento, hijos). Deber. crearse un cursor explícito al que se le pasarán
--estos parámetros y que mostrar. los datos de los empleados que pertenezcan
--al departamento y con el número de hijos indicados. Al final se indicar. el
--número de empleados obtenidos.
CREATE OR REPLACE 
PROCEDURE EJERCICIO3(NUMERO_DEPARTAMENTO NUMBER, NUMERO_HIJOS NUMBER)
AS
CURSOR C_DEPARTAMENTO_HIJOS IS 
	SELECT *
	FROM EMPLEADOS E;

	DATOS_EMPLE EMPLEADOS%ROWTYPE;
	CONT NUMBER := 0;
BEGIN
	
	OPEN C_DEPARTAMENTO_HIJOS;
	LOOP
		FETCH C_DEPARTAMENTO_HIJOS INTO DATOS_EMPLE;
		EXIT WHEN C_DEPARTAMENTO_HIJOS%NOTFOUND;
		IF (DATOS_EMPLE.NUMDE = NUMERO_DEPARTAMENTO) AND DATOS_EMPLE.NUMHI = NUMERO_HIJOS THEN 
			DBMS_OUTPUT.PUT_LINE('Código empleado: ' || ' ' ||DATOS_EMPLE.NUMEM);
			DBMS_OUTPUT.PUT_LINE('Código departamento: ' || ' ' ||DATOS_EMPLE.NUMDE);
			DBMS_OUTPUT.PUT_LINE('Nombre empleado: ' || ' ' ||DATOS_EMPLE.NOMEM);
			DBMS_OUTPUT.PUT_LINE('Número de hijos: ' || ' '||DATOS_EMPLE.NUMHI);
			CONT := CONT+1;
		END IF;
	END LOOP;
	CLOSE C_DEPARTAMENTO_HIJOS;
	DBMS_OUTPUT.PUT_LINE('Número de empleados obtenidos: ' || ' '||CONT);

END;

BEGIN
	EJERCICIO3(121,3);
END;

--Escribe un procedimiento con un parámetro para el nombre de empleado,
--que nos muestre la edad de dicho empleado en años, meses y días.

CREATE OR REPLACE 
PROCEDURE EJERCICIO4(NOMBRE VARCHAR)
AS
CURSOR C_EDAD_ANNO_MESE_DIA IS

	SELECT *
	FROM EMPLEADOS E;

	DATOS_EMPLE EMPLEADOS%ROWTYPE;

BEGIN	
	OPEN C_EDAD_ANNO_MESE_DIA;
	LOOP
		FETCH C_EDAD_ANNO_MESE_DIA INTO DATOS_EMPLE;
		EXIT WHEN C_EDAD_ANNO_MESE_DIA%NOTFOUND;
		IF DATOS_EMPLE.NOMEM = NOMBRE THEN
			DBMS_OUTPUT.PUT_LINE('Edad en años: ' || (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DATOS_EMPLE.FECNA)));
			DBMS_OUTPUT.PUT_LINE('Edad en meses: ' || (EXTRACT(YEAR FROM DATOS_EMPLE.FECNA)*12 + EXTRACT(MONTH FROM DATOS_EMPLE.FECNA)));
			DBMS_OUTPUT.PUT_LINE('Edad en dias: ' || (EXTRACT(YEAR FROM DATOS_EMPLE.FECNA)*365 + EXTRACT(DAY FROM DATOS_EMPLE.FECNA)));
		END IF;
	END LOOP;
	CLOSE C_EDAD_ANNO_MESE_DIA;
END;

BEGIN
	EJERCICIO4('CESAR');
END;










=======
--Escribe un procedimiento que muestre el número de empleados y el salario
--mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
--uso de cursores implícitos, es decir utilizar SELECT ... INTO
CREATE OR REPLACE 
PROCEDURE EJERCICIO1
AS
	NUM_EMPLEADOS NUMBER;
	MINIMO NUMBER;
	MAXIMO NUMBER;
	MEDIA NUMBER;
BEGIN 
	SELECT COUNT(E.NUMEM),MIN(E.SALAR),MAX(E.SALAR),AVG(E.SALAR) INTO NUM_EMPLEADOS,MINIMO,MAXIMO,MEDIA
	FROM EMPLEADOS E, DEPARTAMENTOS D
	WHERE E.NUMDE = D.NUMDE AND D.NOMDE LIKE 'FINANZAS';

	DBMS_OUTPUT.PUT_LINE(NUM_EMPLEADOS);
	DBMS_OUTPUT.PUT_LINE(MINIMO);
	DBMS_OUTPUT.PUT_LINE(MAXIMO);
	DBMS_OUTPUT.PUT_LINE(MEDIA);
END;

BEGIN
	EJERCICIO1;
END;

--Escribe un procedimiento que suba un 10% el salario a los EMPLEADOS
--con más de 2 hijos y que ganen menos de 2000 €. Para cada empleado se
--mostrar por pantalla el código de empleado, nombre, salario anterior y final.
--Utiliza un cursor explícito. La transacción no puede quedarse a medias. Si
--por cualquier razón no es posible actualizar todos estos salarios, debe
--deshacerse el trabajo a la situación inicial.
CREATE OR REPLACE PROCEDURE EJERCICIO2
AS 	
CURSOR C_EJERCICIO2 IS 
	SELECT E.NUMEM, E.NOMEM, E.SALAR
	FROM EMPLEADOS E
	WHERE E.SALAR < 2000 AND E.NUMHI > 2;

	COD_EMPLE EMPLEADOS.NUMEM%TYPE;
	NOMBRE_EMPLE EMPLEADOS.NOMEM%TYPE;
	SALARIO_EMPLE EMPLEADOS.SALAR%TYPE;
BEGIN 
	OPEN C_EJERCICIO2;
	LOOP
		
		FETCH C_EJERCICIO2 INTO COD_EMPLE,NOMBRE_EMPLE,SALARIO_EMPLE;
		EXIT WHEN C_EJERCICIO2%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Código empleado: ' || ' ' ||COD_EMPLE);
		DBMS_OUTPUT.PUT_LINE('Nombre empleado: ' || ' ' ||NOMBRE_EMPLE);
		DBMS_OUTPUT.PUT_LINE('Salario anterior: ' || ' '||SALARIO_EMPLE);
		DBMS_OUTPUT.PUT_LINE('Salario final: ' || ' '||(SALARIO_EMPLE + (SALARIO_EMPLE*0.10)));
		DBMS_OUTPUT.PUT_LINE('------------');
	END LOOP;
	CLOSE C_EJERCICIO2;
END;

BEGIN
	EJERCICIO2;
END;
--Escribe un procedimiento que reciba dos parámetros (número de
--departamento, hijos). Deber. crearse un cursor explícito al que se le pasarán
--estos parámetros y que mostrar. los datos de los empleados que pertenezcan
--al departamento y con el número de hijos indicados. Al final se indicar. el
--número de empleados obtenidos.
CREATE OR REPLACE 
PROCEDURE EJERCICIO3(NUMERO_DEPARTAMENTO NUMBER, NUMERO_HIJOS NUMBER)
AS
CURSOR C_DEPARTAMENTO_HIJOS IS 
	SELECT *
	FROM EMPLEADOS E;

	DATOS_EMPLE EMPLEADOS%ROWTYPE;
	CONT NUMBER := 0;
BEGIN
	
	OPEN C_DEPARTAMENTO_HIJOS;
	LOOP
		FETCH C_DEPARTAMENTO_HIJOS INTO DATOS_EMPLE;
		EXIT WHEN C_DEPARTAMENTO_HIJOS%NOTFOUND;
		IF (DATOS_EMPLE.NUMDE = NUMERO_DEPARTAMENTO) AND DATOS_EMPLE.NUMHI = NUMERO_HIJOS THEN 
			DBMS_OUTPUT.PUT_LINE('Código empleado: ' || ' ' ||DATOS_EMPLE.NUMEM);
			DBMS_OUTPUT.PUT_LINE('Código departamento: ' || ' ' ||DATOS_EMPLE.NUMDE);
			DBMS_OUTPUT.PUT_LINE('Nombre empleado: ' || ' ' ||DATOS_EMPLE.NOMEM);
			DBMS_OUTPUT.PUT_LINE('Número de hijos: ' || ' '||DATOS_EMPLE.NUMHI);
			CONT := CONT+1;
		END IF;
	END LOOP;
	CLOSE C_DEPARTAMENTO_HIJOS;
	DBMS_OUTPUT.PUT_LINE('Número de empleados obtenidos: ' || ' '||CONT);

END;

BEGIN
	EJERCICIO3(121,3);
END;

--Escribe un procedimiento con un parámetro para el nombre de empleado,
--que nos muestre la edad de dicho empleado en años, meses y días.

CREATE OR REPLACE 
PROCEDURE EJERCICIO4(NOMBRE VARCHAR)
AS
CURSOR C_EDAD_ANNO_MESE_DIA IS

	SELECT *
	FROM EMPLEADOS E;

	DATOS_EMPLE EMPLEADOS%ROWTYPE;

BEGIN	
	OPEN C_EDAD_ANNO_MESE_DIA;
	LOOP
		FETCH C_EDAD_ANNO_MESE_DIA INTO DATOS_EMPLE;
		EXIT WHEN C_EDAD_ANNO_MESE_DIA%NOTFOUND;
		IF DATOS_EMPLE.NOMEM = NOMBRE THEN
			DBMS_OUTPUT.PUT_LINE('Edad en años: ' || (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DATOS_EMPLE.FECNA)));
			DBMS_OUTPUT.PUT_LINE('Edad en meses: ' || (EXTRACT(YEAR FROM DATOS_EMPLE.FECNA)*12 + EXTRACT(MONTH FROM DATOS_EMPLE.FECNA)));
			DBMS_OUTPUT.PUT_LINE('Edad en dias: ' || (EXTRACT(YEAR FROM DATOS_EMPLE.FECNA)*365 + EXTRACT(DAY FROM DATOS_EMPLE.FECNA)));
		END IF;
	END LOOP;
	CLOSE C_EDAD_ANNO_MESE_DIA;
END;

BEGIN
	EJERCICIO4('CESAR');
END;










>>>>>>> abe635426f80e657d1d8331ce440888897377ffb

--Realiza un procedimiento que reciba un número de departamento y muestre por pantalla su
--nombre y localidad.

CREATE OR REPLACE 
PROCEDURE NOMBRE_LOCALIDAD(NUMERO_DERPT NUMBER)
AS
	NOMBRE_DEPART DEPT.DNAME%TYPE;
	LOCALIDAD_DEPART DEPT.LOC%TYPE;
BEGIN
	SELECT D.DNAME,D.LOC INTO NOMBRE_DEPART,LOCALIDAD_DEPART
	FROM DEPT D
	WHERE D.DEPTNO = NUMERO_DERPT;
	
	DBMS_OUTPUT.PUT_LINE('Nombre departamento: ' || NOMBRE_DEPART);
	DBMS_OUTPUT.PUT_LINE('Localidad departamten: ' || LOCALIDAD_DEPART);
END;

BEGIN
	NOMBRE_LOCALIDAD(10);
END;


--Realiza una función devolver_sal que reciba un nombre de departamento y devuelva la suma
--de sus salarios. 

CREATE OR REPLACE 
FUNCTION DEVOLVER_SAL(NOMBRE_DEPT VARCHAR2)
RETURN NUMBER
IS

	SUMA_SALARIO NUMBER;

BEGIN
	SELECT SUM(E.SAL) INTO SUMA_SALARIO
	FROM DEPT d,EMP e 
	WHERE D.DEPTNO = E.DEPTNO AND D.DNAME  = NOMBRE_DEPT;

	RETURN SUMA_SALARIO;
END DEVOLVER_SAL;


SELECT DEVOLVER_SAL('ACCOUNTING') FROM DUAL;

--Realiza un procedimiento MostrarAbreviaturas que muestre las tres primeras letras del
--nombre de cada empleado.

CREATE OR REPLACE 
PROCEDURE MOSTRARABREVIATURAS
AS
CURSOR C_NOMBRE IS
	SELECT E.ENAME 
	FROM EMP E;
BEGIN
	FOR I IN C_NOMBRE LOOP
		DBMS_OUTPUT.PUT_LINE(SUBSTR(I.ENAME, 0, 3));
	END LOOP;
END;

BEGIN
	MOSTRARABREVIATURAS;
END;

--Realiza un procedimiento que reciba un número de departamento y muestre una lista de sus
--empleados.

CREATE OR REPLACE 
PROCEDURE LISTA_EMPLE(NUM_DEPT NUMBER)
AS
CURSOR C_NOMBRE_EMPLE(c_dept NUMBER) IS 
	SELECT E.ENAME 
	FROM EMP E
	WHERE E.DEPTNO = c_dept;
BEGIN
	
	FOR I IN C_NOMBRE_EMPLE(NUM_DEPT) LOOP
		
		DBMS_OUTPUT.PUT_LINE('Nombre empleado: '||I.ENAME);
		
	END LOOP;

END;

BEGIN
	LISTA_EMPLE(10);
END;

--Realiza un procedimiento MostrarJefes que reciba el nombre de un departamento y muestre
--los nombres de los empleados de ese departamento que son jefes de otros empleados.Trata las
--excepciones que consideres necesarias.

CREATE OR REPLACE 
PROCEDURE MOSTRARJEFES(NOMBRE_DPT VARCHAR)
AS
CURSOR C_JEFES(NOMBRE_DPT2 VARCHAR) IS
	SELECT E.ENAME
	FROM EMP E, EMP E1, DEPT D
	WHERE E.EMPNO = E1.MGR
	AND E.DEPTNO = D.DEPTNO
	AND E1.DEPTNO = D.DEPTNO 
	AND D.DNAME = NOMBRE_DPT2;

	NOMBRE_DPT_EXCEP VARCHAR(40);
BEGIN
	
	SELECT D.DNAME INTO NOMBRE_DPT_EXCEP
	FROM DEPT d 
	WHERE d.DNAME = NOMBRE_DPT;

	IF SQL%NOTFOUND THEN
		RAISE NO_DATA_FOUND;
	END IF;
	
	FOR I IN C_JEFES(NOMBRE_DPT) LOOP
		DBMS_OUTPUT.PUT_LINE('Jefe: '||I.ENAME);
	END LOOP;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('No existen datos.');
END;

BEGIN
	MOSTRARJEFES('curro');
END;


--Hacer un procedimiento que muestre el nombre y el salario del empleado cuyo código es 7082 
CREATE OR REPLACE 
PROCEDURE NOMBRE_SALR_7082
AS 
	NOMBRE_EMPLE EMP.ENAME%TYPE;
	SALARIO_EMPLE EMP.SAL%TYPE;
	
NODATA EXCEPTION;

BEGIN
	SELECT E.ENAME,E.SAL INTO NOMBRE_EMPLE,SALARIO_EMPLE
	FROM EMP E
	WHERE E.EMPNO = 7082;
	IF NOMBRE_EMPLE IS NULL OR SALARIO_EMPLE = 0 THEN
		RAISE NODATA;
	ELSE 
		DBMS_OUTPUT.PUT_LINE('Nombre: ' || NOMBRE_EMPLE || ' salario: ' || SALARIO_EMPLE);
	END IF;
	
	EXCEPTION 
		WHEN NODATA OR NO_DATA_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE('ERROR EMPLEADO NO EXISTENTE');


END;

BEGIN
	NOMBRE_SALR_7082;
END;

--Realiza un procedimiento llamado HallarNumEmp que recibiendo un nombre de
--departamento, muestre en pantalla el número de empleados de dicho departamento
--Si el departamento no tiene empleados deberá mostrar un mensaje informando de ello. Si el
--departamento no existe se tratará la excepción correspondiente.

CREATE OR REPLACE 
PROCEDURE HALLAR_NUM_EMP(NOMBRE_DPT VARCHAR)
AS

CONT NUMBER(10);
NODATA EXCEPTION;

BEGIN
	SELECT COUNT(DISTINCT E.EMPNO) INTO CONT
	FROM EMP e,DEPT d 
	WHERE E.DEPTNO = D.DEPTNO AND D.DNAME = NOMBRE_DPT;
	IF CONT = 0 OR NOMBRE_DPT IS NULL THEN
		RAISE NODATA;
	ELSE
		DBMS_OUTPUT.PUT_LINE('En el departamento ' || NOMBRE_DPT || ' hay ' || CONT || ' empleados.');
	END IF;
EXCEPTION 
		WHEN NODATA OR NO_DATA_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE('ERROR NO EXISTENTE');
END;

BEGIN
	HALLAR_NUM_EMP('ACCOUNTING');
END;

--Hacer un procedimiento que reciba como parámetro un código de empleado y devuelva su
--nombre.

CREATE OR REPLACE PROCEDURE EJER8(COD NUMBER)
AS
NOMBRE EMP.ENAME%TYPE;
NODATA EXCEPTION;
BEGIN
SELECT E.ENAME INTO NOMBRE
FROM EMP e
WHERE E.EMPNO = COD;
IF COD IS NULL OR COD LIKE '' THEN
RAISE NODATA;
ELSE
DBMS_OUTPUT.PUT_LINE(NOMBRE);
END IF;
EXCEPTION WHEN NODATA OR NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('ERROR, INTRODUCE UN DATO');
END;

BEGIN
	EJER8(10);
END;

--Codificar un procedimiento que reciba una cadena y la visualice al revés. 

CREATE OR REPLACE PROCEDURE rever(CADENA VARCHAR2)
AS 
    CADENA2 VARCHAR2(100);
BEGIN
    FOR CARACTER IN REVERSE 1..LENGTH(CADENA)
    LOOP
        CADENA2 := CADENA2||SUBSTR(CADENA,CARACTER,1);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(CADENA2);
END;

BEGIN
    rever('JESUS');
END;

-- Escribir un procedimiento que reciba una fecha y escriba el año, en número, correspondiente a
--esa fecha. 

CREATE OR REPLACE 
PROCEDURE EJER10 (FECHA DATE)
AS
BEGIN 
	DBMS_OUTPUT.PUT_LINE(EXTRACT(YEAR FROM FECHA));
END;

BEGIN
	EJER10(SYSDATE);
END;

--Realiza una función llamada CalcularCosteSalarial que reciba un nombre de departamento y
--devuelva la suma de los salarios y comisiones de los empleados de dicho departamento.

CREATE OR REPLACE 
FUNCTION EJER11(NOMBRE_DPT VARCHAR)
RETURN NUMBER
AS

	SUMA NUMBER;

BEGIN 

	SELECT (SUM(E.SAL) + SUM(E.COMM)) INTO SUMA  
	FROM DEPT d, EMP e 
	WHERE D.DEPTNO = E.DEPTNO 
	AND D.DNAME = NOMBRE_DPT;
	
	RETURN SUMA;
END;

SELECT EJER11('SALES') FROM DUAL;

--Codificar un procedimiento que permita borrar un empleado cuyo número se pasará en la
--llamada. Si no existiera dar el correspondiente mensaje de error.

CREATE OR REPLACE PROCEDURE EJER12(NUMERO_EMP NUMBER)
AS 
NODATA EXCEPTION;
EMPLEADO NUMBER;
BEGIN
	SELECT E.EMPNO INTO EMPLEADO
	FROM EMP E
	WHERE E.EMPNO = NUMERO_EMP;

	IF EMPLEADO IS NULL THEN
		RAISE NODATA;
	ELSE 
	DELETE FROM EMP E WHERE E.EMPNO = NUMERO_EMP;
	END IF;
	EXCEPTION WHEN NODATA OR NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('ERROR, NO EXISTE EMPLEADO');
END;

BEGIN
	EJER12(7369);
END;

--Realiza un procedimiento MostrarCostesSalariales que muestre los nombres de todos los
--departamentos y el coste salarial de cada uno de ellos

CREATE OR REPLACE PROCEDURE EMPLEADOS2.EJER13
AS
	CURSOR C_COSTE_SALAR IS 
		SELECT D.DNAME, (SUM(E.SAL) + SUM(E.COMM)) AS SUMA
		FROM DEPT D,EMP E
		WHERE D.DEPTNO = E.DEPTNO 
		GROUP BY D.DNAME;
BEGIN
	FOR I IN C_COSTE_SALAR LOOP
		DBMS_OUTPUT.PUT_LINE('NOMBRE DEPARTAMENTO: '||I.DNAME || ' COSTE SALARIAL: ' || I.SUMA);
	END LOOP;	
END;

BEGIN
	EJER13;
END;

--Escribir un procedimiento que modifique la localidad de un departamento. El procedimiento
--recibirá como parámetros el número del departamento y la localidad nueva. 
CREATE OR REPLACE 
PROCEDURE EJER14(NUM_DPT NUMBER, LOCALIDAD VARCHAR)
AS 

DEPT_NUM NUMBER;
NODATA EXCEPTION;

BEGIN
	SELECT D.DEPTNO INTO DEPT_NUM
	FROM DEPT d 
	WHERE D.DEPTNO = NUM_DPT;
	
	IF DEPT_NUM IS NULL THEN
		RAISE NODATA;
	ELSE 
		UPDATE DEPT D SET D.LOC = LOCALIDAD 
		WHERE D.DEPTNO = NUM_DPT;
	END IF;
	EXCEPTION WHEN NODATA OR NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('ERROR, NO EXISTE DEPARTAMENTO');
END;

BEGIN
	EJER14(10,'SEVILLA');
END;

SELECT * 
FROM DEPT d;

--Realiza un procedimiento MostrarMasAntiguos que muestre el nombre del empleado más
--antiguo de cada departamento junto con el nombre del departamento. Trata las excepciones
--que consideres necesarias.

CREATE OR REPLACE PROCEDURE MostrarMasAntiguos
AS 
	noData EXCEPTION;
	CURSOR EJER15 IS
			SELECT DISTINCT d.DNAME AS departamento, e.ENAME AS nombre
			FROM EMP e, DEPT d  
			WHERE e.DEPTNO = d.DEPTNO AND e.HIREDATE IN (SELECT min(e.HIREDATE)
								FROM EMP e , DEPT d 
								WHERE e.DEPTNO = d.DEPTNO 
								GROUP BY d.DNAME );

BEGIN 


	FOR I IN EJER15 LOOP
	dbms_output.put_line('Departamento: '||I.departamento||' Nombre: '||I.nombre);
	END LOOP;

	
END;

BEGIN
	MostrarMasAntiguos;
END;



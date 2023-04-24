--Realiza una función llamada CalcularCosteSalarial que reciba un nombre de departamento y
--devuelva la suma de los salarios y comisiones de los empleados de dicho departamento.

CREATE OR REPLACE 
FUNCTION EJER11(NOMBRE_DPT VARCHAR2)
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

no_data EXCEPTION;

BEGIN

	DELETE FROM EMP E WHERE E.EMPNO = NUMERO_EMP;

	IF SQL%NOTFOUND THEN
		RAISE no_data;
	END IF;

	IF SQL%ROWCOUNT > 5 THEN
		RAISE_APPLICATION_ERROR(-20001,'Has borrado más de 5 empleados.');
	END IF;
		
EXCEPTION WHEN no_data THEN
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
		SELECT D.DNAME, NVL((SUM(E.SAL) + SUM(E.COMM)),0) AS SUMA
		FROM DEPT D,EMP E
		WHERE D.DEPTNO = E.DEPTNO 
		GROUP BY D.DNAME;
BEGIN
	FOR I IN C_COSTE_SALAR LOOP
		DBMS_OUTPUT.PUT_LINE('NOMBRE DEPARTAMENTO: '||I.DNAME || ', COSTE SALARIAL: ' || I.SUMA);
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
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
		DBMS_OUTPUT.PUT_LINE(SUBSTR(I.ENAME, 3));
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
CURSOR C_NOMBRE_EMPLE IS 
	SELECT E.ENAME 
	FROM EMP E
	WHERE E.DEPTNO = NUM_DEPT;
BEGIN
	
	FOR I IN C_NOMBRE_EMPLE LOOP
		
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
CURSOR C_JEFES IS
	SELECT E.ENAME
	FROM EMP E, EMP E1, DEPT D
	WHERE E.EMPNO = E1.MGR
	AND E.DEPTNO = D.DEPTNO
	AND E1.DEPTNO = D.DEPTNO 
	AND D.DNAME = NOMBRE_DPT;
BEGIN
	 
	FOR I IN C_JEFES LOOP
		DBMS_OUTPUT.PUT_LINE('Jefe: '||I.ENAME);
	END LOOP;	

END;

BEGIN
	MOSTRARJEFES('OPERATIONS');
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












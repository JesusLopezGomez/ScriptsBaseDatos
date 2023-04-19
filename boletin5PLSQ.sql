--Crear un procedimiento que en la tabla emp incremente el salario el 10% a los empleados que
--tengan una comisión superior al 5% del salario. 
CREATE OR REPLACE 
PROCEDURE EJER1
AS
CURSOR C_EMP IS 
	SELECT E.EMPNO
	FROM EMP e
	WHERE E.COMM > ALL(SELECT (E.SAL -(E.SAL * 0.95))
					FROM EMP e);

BEGIN 
	FOR REGISTRO IN C_EMP LOOP
		UPDATE EMP SET SAL = SAL + (SAL*0.10) WHERE EMPNO = REGISTRO.EMPNO;
		COMMIT;
	END LOOP;
END;

--Realiza un procedimiento MostrarMejoresVendedores que muestre los nombres de los dos
--vendedores/as con más comisiones.
CREATE OR REPLACE PROCEDURE MostrarMejoresVendedores
AS
CURSOR c_ordenados IS
	SELECT e.ENAME , NVL(e.COMM, 0)
	FROM EMP e
	ORDER BY NVL(e.COMM, 0) desc ;

contador NUMBER :=0;

BEGIN

FOR i IN c_ordenados LOOP

	IF contador<2 THEN

		dbms_output.put_line(i.ename);

		contador:=contador+1;

	END IF;

END LOOP;

END;

BEGIN

MostrarMejoresVendedores;

END;

--Realiza un procedimiento MostrarsodaelpmE que reciba el nombre de un departamento al
--revés y muestre los nombres de los empleados de ese departamento. 

CREATE OR REPLACE 
PROCEDURE MostrarsodaelpmE(NOMBRE_DEPT_A VARCHAR)
AS
	CURSOR C_NOMBRES(NOMBRE_DEPT_BIEN VARCHAR) IS
		SELECT E.ENAME
		FROM EMP E,DEPT D
		WHERE E.DEPTNO = D.DEPTNO 
		AND D.DNAME LIKE NOMBRE_DEPT_BIEN;

	NOMBRE_DEPT_BIEN DEPT.DNAME%TYPE;


BEGIN
	FOR CARACTER IN REVERSE 1..LENGTH(NOMBRE_DEPT_A) LOOP
        NOMBRE_DEPT_BIEN := NOMBRE_DEPT_BIEN||SUBSTR(NOMBRE_DEPT_A,CARACTER,1);
    END LOOP;
   	
   FOR REGISTRO IN C_NOMBRES(NOMBRE_DEPT_BIEN) LOOP
   	   	DBMS_OUTPUT.PUT_LINE('Empleado: ' || REGISTRO.ENAME);
   END LOOP;
   
END;

BEGIN
	MostrarsodaelpmE('SELAS');
END;


--Realiza un procedimiento RecortarSueldos que recorte el sueldo un 20% a los empleados
--cuyo nombre empiece por la letra que recibe como parámetro. Trata las excepciones que
--consideres necesarias.
CREATE OR REPLACE 
PROCEDURE RecortarSueldos(LETRA VARCHAR2)
AS
CURSOR C_EMPLE IS 
	SELECT E.EMPNO
	FROM EMP e 
	WHERE E.ENAME LIKE LETRA||'%';

LETRA_NULL EXCEPTION;
NUMERO_EMP EMP.EMPNO%TYPE;

BEGIN 
	
	SELECT E.EMPNO INTO NUMERO_EMP
	FROM EMP e 
	WHERE E.ENAME LIKE LETRA||'%';

	IF LETRA IS NULL THEN
		RAISE LETRA_NULL;
	END IF;
	
	FOR REGISTRO IN C_EMPLE LOOP
		UPDATE EMP SET SAL = SAL - (SAL*0.2) WHERE EMPNO = REGISTRO.EMPNO;
	END LOOP;
	
	EXCEPTION WHEN LETRA_NULL THEN
		DBMS_OUTPUT.PUT_LINE('ERROR, LA LETRA ES NULL');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('ERROR, NO EXISTEN EMPLEADOS CON ESA LETRA AL PRINCIPIO.');
END;

BEGIN
	RecortarSueldos('X');
END;

--Realiza un procedimiento BorrarBecarios que borre a los dos empleados más nuevos de cada
--departamento
CREATE OR REPLACE 
PROCEDURE BorrarBecarios
AS 
CURSOR C_BECARIOS IS 
SELECT * FROM (SELECT E.EMPNO
				FROM DEPT d,EMP e 
				WHERE D.DEPTNO = E.DEPTNO 
				ORDER BY E.HIREDATE DESC)
WHERE ROWNUM <= 2;

BEGIN
	
	FOR REGISTRO IN C_BECARIOS LOOP
		DELETE FROM EMP e WHERE E.EMPNO = REGISTRO.EMPNO;
	END LOOP;
	
END;

BEGIN
	BorrarBecarios;
END;


--7876,7788











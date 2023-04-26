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

BEGIN
	
END;

--Realiza un procedimiento MostrarMejoresVendedores que muestre los nombres de los dos
--vendedores/as con más comisiones.
CREATE OR REPLACE PROCEDURE MostrarMejoresVendedores
AS
CURSOR c_ordenados IS
	SELECT * FROM (SELECT e.ENAME , NVL(e.COMM, 0)
	FROM EMP e ORDER BY NVL(e.COMM, 0) desc)
	WHERE ROWNUM <= 2;

BEGIN

FOR i IN c_ordenados LOOP
		dbms_output.put_line(i.ename);
END LOOP;

END;

BEGIN

	MostrarMejoresVendedores;

END;

--Realiza un procedimiento MostrarsodaelpmE que reciba el nombre de un departamento al
--revés y muestre los nombres de los empleados de ese departamento. 

CREATE OR REPLACE FUNCTION EMPLEADOS2.REVERSE_BIEN(NOMBRE VARCHAR)
RETURN VARCHAR
AS 

NOMBRE_BIEN VARCHAR(40);

BEGIN

	FOR CARACTER IN REVERSE 1..LENGTH(NOMBRE) LOOP
        NOMBRE_BIEN := NOMBRE_BIEN||SUBSTR(NOMBRE,CARACTER,1);
   	END LOOP;
   
   	RETURN NOMBRE_BIEN;
	
END;


CREATE OR REPLACE 
PROCEDURE MostrarsodaelpmE(NOMBRE_DEPT_A VARCHAR)
AS
	CURSOR C_NOMBRES IS
		SELECT E.ENAME
		FROM EMP E,DEPT D
		WHERE E.DEPTNO = D.DEPTNO 
		AND D.DNAME LIKE REVERSE_BIEN(NOMBRE_DEPT_A);

	NOMBRE_DEPT_BIEN DEPT.DNAME%TYPE;


BEGIN
   	
   	FOR REGISTRO IN C_NOMBRES LOOP
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
CURSOR C_EMPLE(LETRA_RECIBIR VARCHAR2) IS 
	SELECT E.EMPNO
	FROM EMP e 
	WHERE E.ENAME LIKE LETRA_RECIBIR||'%';

NUMERO_EMP EMP.EMPNO%TYPE;

BEGIN 
	
	SELECT E.EMPNO INTO NUMERO_EMP
	FROM EMP e 
	WHERE E.ENAME LIKE LETRA||'%';
	
	FOR REGISTRO IN C_EMPLE(LETRA) LOOP
		UPDATE EMP SET SAL = SAL - (SAL*0.2) WHERE EMPNO = REGISTRO.EMPNO;
		COMMIT;
	END LOOP;
	
	EXCEPTION WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('ERROR, NO EXISTEN EMPLEADOS CON ESA LETRA AL PRINCIPIO.');
		ROLLBACK;
END;

BEGIN
	RecortarSueldos('X');
	RecortarSueldos('Z');
END;

--Realiza un procedimiento BorrarBecarios que borre a los dos empleados más nuevos de cada
--departamento
CREATE OR REPLACE PROCEDURE EMPLEADOS2.BorrarBecarios
AS 
--Cursor explícito para recuperar departamentos
CURSOR C_DEPARTAMENTOS IS 
	SELECT D.DEPTNO 
	FROM DEPT D;

--Cursor explícitio para recuperar empleados más nuevos por departamento
CURSOR C_EMPLEADOS(NUMERO_DEPT NUMBER) IS
	SELECT * FROM (SELECT E2.EMPNO 
					FROM EMP e2
					WHERE E2.DEPTNO = 30
					ORDER BY E2.HIREDATE)
	WHERE ROWNUM <= 2;

BEGIN
	
	FOR REGISTRO IN C_DEPARTAMENTOS LOOP
		FOR I IN C_EMPLEADOS(REGISTRO.DEPTNO) LOOP
			DELETE FROM EMP e WHERE E.EMPNO = I.EMPNO;
		END LOOP;
	END LOOP;
	
END;


BEGIN
	BorrarBecarios;
END;

--7876,7788











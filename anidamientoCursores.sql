--EJERCICIO CURSORES ANIDADOS


--Muestra por cada departamento su listado de empleados con el siguiente formato
-- Nombre depatarmento: Ventas
			--Empleado: Marta  Trabajo: MANAGER 
			--Empleado: Dario  Trabajo: SALESMAN 
			--Empleado: Manuel  Trabajo: SALESMAN 
			--  ......
-- Nombre depatarmento: ACOOUNTING
			--Empleado: Ana  Trabajo: MANAGER 
			--Empleado: Mohamed  Trabajo: SALESMAN 
			--Empleado: Josemi  Trabajo: SALESMAN 
			--  ......

CREATE OR REPLACE PROCEDURE LISTADO_EMPLEADOS IS 

--CURSOR PARA DEPARTAMENTOS. EXPLICITOS
CURSOR C_DEPT IS 
SELECT DNAME,DEPTNO  FROM DEPT;
--EXPLICITOS
CURSOR C_EMPxDEPT(V_DEPT DEPT.DEPTNO%TYPE) IS
SELECT ENAME,JOB FROM EMP
WHERE DEPTNO =V_DEPT;
v_total number(5);
BEGIN
	
	FOR registro_dept IN C_DEPT LOOP
		--IMPLICITO
		SELECT count(*) INTO v_total FROM EMP WHERE  DEPTNO =registro_dept.deptno;
		
	   DBMS_OUTPUT.PUT_LINE('Nombre de departamento: '|| registro_dept.dname || ' Total empleados: ' || v_total );
		FOR registro_emp IN C_EMPxDEPT(registro_dept.deptno) LOOP
			DBMS_OUTPUT.PUT_LINE('              Nombre de empleado: '|| registro_emp.ENAME || ' Trabajo: ' || registro_emp.job);
		
		END LOOP;
	
	END LOOP;
	
END;



BEGIN
	LISTADO_EMPLEADOS;
END;

--1. Crea un paquete con la siguiente nomenclatura TUNOMBREgestioncarreras que contendrá la
--función y el procedimiento solicitados en el ejercicio 2 y ejercicio3. Es decir tendrá
---Función listadocaballos que no recibirá ningún parámetro y devolverá un número.
-- Procedimiento agregarcaballos que recibirá como argumento el nombre, peso, fecha
--de nacimiento, nacionalidad y el dni y el nombre del dueño.

CREATE OR REPLACE 
PACKAGE BODY JESUSGESTIONCARRERAS IS 

	FUNCTION LISTADOCABALLOS 
	RETURN NUMBER 
	IS
	
	CURSOR C_INFO_CABALLOS IS 
		SELECT C.*,P2.*
		FROM CABALLOS c, PERSONAS p2 
		WHERE C.PROPIETARIO = P2.CODIGO; 
	
	CURSOR C_INFO_JOCKEY(V_COD_CABALLO VARCHAR2) IS
		SELECT *
		FROM PARTICIPACIONES p, PERSONAS p2 
		WHERE P.JOCKEY = P2.NOMBRE AND P.CODCABALLO = V_COD_CABALLO;
	
	CURSOR C_INFO_CARRERA(V_COD_CARRERA VARCHAR2) IS
		SELECT *
		FROM CARRERAS c 
		WHERE C.CODCARRERA = V_COD_CARRERA;
	
	BEGIN
		RETURN 1;
	END LISTADOCABALLOS;

	PROCEDURE agregarcaballos (NOMBRE VARCHAR2, PESO NUMBER, FECHA_NACIMINETO DATE, 
	NACIONALIDAD VARCHAR2, DNI VARCHAR2, NOMBRE_DUEÑO VARCHAR2)
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('hOLA');
	END agregarcaballos;

END JESUSGESTIONCARRERAS;


SELECT JESUSGESTIONCARRERAS.LISTADOCABALLOS()
FROM DUAL ; 


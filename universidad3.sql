--1.Cuantos costes básicos hay.
SELECT COUNT(A.COSTEBASICO)
FROM ASIGNATURA a;

--2.Para cada titulación mostrar el número 
--de asignaturas que hay junto con el nombre de la titulación.
SELECT COUNT(A.IDASIGNATURA),T.NOMBRE AS NOMBRE_TITULACION 
FROM TITULACION t, ASIGNATURA a 
WHERE T.IDTITULACION = A.IDTITULACION 
GROUP BY T.NOMBRE;

--3.Para cada titulación mostrar el nombre de la titulación 
--junto con el precio total de todas sus asignaturas.
SELECT T.NOMBRE,SUM(A.COSTEBASICO*A.CREDITOS) AS PRECIO_TOTAL_ASIGNATURA
FROM TITULACION t , ASIGNATURA a
WHERE T.IDTITULACION = A.IDTITULACION 
GROUP BY T.NOMBRE;

--4.Cual sería el coste global de cursar la titulación de Matemáticas
-- si el coste de cada asignatura fuera incrementado en un 7%. 

SELECT (SUM(COSTEBASICO) + SUM(A.COSTEBASICO*0.07)) AS COSTE_GLOBAL
FROM ASIGNATURA a, TITULACION t 
WHERE A.IDTITULACION = T.IDTITULACION AND UPPER(T.NOMBRE) = 'MATEMATICAS'
GROUP BY T.NOMBRE;

--5.Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura.
SELECT COUNT(AA.IDALUMNO), AA.IDASIGNATURA 
FROM ALUMNO_ASIGNATURA aa
GROUP BY AA.IDASIGNATURA;

--6.Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura.
SELECT COUNT(AA.IDALUMNO), A.IDASIGNATURA,A.NOMBRE 
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE AA.IDASIGNATURA = A.IDASIGNATURA 
GROUP BY A.IDASIGNATURA,A.NOMBRE;

--7.Mostrar para cada alumno, el nombre del alumno junto con lo que tendría que 
--pagar por el total de todas las asignaturas en las que está matriculada. 
--Recuerda que el precio de la matrícula tiene un incremento de un 10% por 
--cada año en el que esté matriculado.

SELECT P.NOMBRE, SUM(DECODE(AA.NUMEROMATRICULA,1,A2.COSTEBASICO,A2.COSTEBASICO+(A2.COSTEBASICO*(NUMEROMATRICULA*0.10)))) AS PRECIO_TOTAL
FROM ALUMNO_ASIGNATURA aa, ALUMNO a, PERSONA p, ASIGNATURA a2 
WHERE AA.IDALUMNO = A.IDALUMNO AND P.DNI = A.DNI 
AND AA.IDASIGNATURA = A2.IDASIGNATURA
GROUP BY P.NOMBRE;

--8.Coste medio de las asignaturas de cada titulación, para aquellas 
--titulaciones en el que el coste total de la 1ª matrícula sea mayor que 60 euros. 
SELECT AVG(A.COSTEBASICO) 
FROM ASIGNATURA A,TITULACION t,ALUMNO_ASIGNATURA aa 
WHERE A.IDTITULACION = T.IDTITULACION AND AA.IDASIGNATURA = A.IDASIGNATURA AND AA.NUMEROMATRICULA = 1
GROUP BY T.NOMBRE 
HAVING SUM(A.COSTEBASICO) > 60;

--9.Nombre de las titulaciones  que tengan más de tres alumnos.
SELECT T.NOMBRE 
FROM ASIGNATURA a,TITULACION t, ALUMNO_ASIGNATURA aa 
WHERE A.IDTITULACION = T.IDTITULACION AND AA.IDASIGNATURA = A.IDASIGNATURA 
GROUP BY T.NOMBRE
HAVING COUNT(AA.IDALUMNO) > 3;

--10.Nombre de cada ciudad junto con el número de personas que viven en ella.
SELECT P.CIUDAD, COUNT(P.NOMBRE) 
FROM PERSONA p 
GROUP BY P.CIUDAD;

--11.Nombre de cada profesor junto con el número de asignaturas que imparte.
SELECT P2.NOMBRE, COUNT(A.IDASIGNATURA) AS NUMERO_ASIGNATURA
FROM PROFESOR p,ASIGNATURA a,PERSONA p2
WHERE P.DNI = P2.DNI AND P.IDPROFESOR = A.IDPROFESOR
GROUP BY P2.NOMBRE;

--12.Nombre de cada profesor junto con el número de alumnos 
--que tiene, para aquellos profesores que tengan dos o más de 2 alumnos.
SELECT P.NOMBRE, COUNT(AA.IDALUMNO) AS NUMERO_ALUMNOS
FROM PERSONA p, PROFESOR p2 ,ASIGNATURA a , ALUMNO_ASIGNATURA aa 
WHERE P.DNI = P2.DNI AND A.IDASIGNATURA = AA.IDASIGNATURA AND P2.IDPROFESOR = A.IDPROFESOR
GROUP BY P.NOMBRE
HAVING COUNT(AA.IDALUMNO) >= 2;

--13.Obtener el máximo de las sumas de los costesbásicos de cada cuatrimestre
SELECT MAX(SUM(A.COSTEBASICO))
FROM ASIGNATURA a 
GROUP BY A.CUATRIMESTRE;

--14.Suma del coste de las asignaturas
SELECT SUM(A.COSTEBASICO)
FROM ASIGNATURA a;

--15.¿Cuántas asignaturas hay?
SELECT COUNT(A.IDASIGNATURA)
FROM ASIGNATURA a ;

--16.Coste de la asignatura más cara y de la más barata
SELECT MAX(A.COSTEBASICO) AS CARA, MIN(A.COSTEBASICO) AS BARATA
FROM ASIGNATURA a;

--17.¿Cuántas posibilidades de créditos de asignatura hay?
SELECT (COUNT(DISTINCT A.CREDITOS))
FROM ASIGNATURA a;

--18.¿Cuántos cursos hay?
SELECT COUNT(A.CURSO)
FROM ASIGNATURA a;

--19.¿Cuántas ciudades hau?
SELECT COUNT(CIUDAD)
FROM PERSONA p;

--20.Nombre y número de horas de todas las asignaturas.
SELECT A.NOMBRE,A.CREDITOS*10 AS NUMERO_HORAS 
FROM ASIGNATURA a;

--21.Mostrar las asignaturas que no pertenecen a ninguna titulación.
SELECT A.NOMBRE 
FROM ASIGNATURA a
WHERE (A.IDTITULACION IS NULL);

--22.Listado del nombre completo de las personas, sus teléfonos y sus direcciones, 
--llamando a la columna del nombre "NombreCompleto" y a la de direcciones "Direccion".

SELECT (P.NOMBRE|| ' ' ||P.APELLIDO) AS NombreCompleto, 
(P.DIRECCIONCALLE|| ' ' ||P.DIRECCIONNUM) AS Direccion
FROM PERSONA p;

--23.Cual es el día siguiente al día en que nacieron las personas de la B.D.
SELECT EXTRACT(DAY FROM P.FECHA_NACIMIENTO+1) AS DIA_SIGUIENTE_AL_QUE_NACIERON
FROM PERSONA p;

--24.Años de las personas de la Base de Datos, esta consulta tiene que valor 
--para cualquier momento

SELECT NVL(EXTRACT(YEAR FROM P.FECHA_NACIMIENTO),0) AS AÑOS
FROM PERSONA P;

--25.Listado de personas mayores de 25 años ordenadas por apellidos
-- y nombre, esta consulta tiene que valor para cualquier momento

SELECT NVL(NOMBRE|| ' '||APELLIDO,0)
FROM PERSONA p
WHERE (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM P.FECHA_NACIMIENTO)) > 25
ORDER BY NOMBRE ASC, APELLIDO ASC;

--26.Nombres completos de los profesores que además son alumnos

SELECT P2.NOMBRE || ' ' || P2.APELLIDO 
FROM PROFESOR p, PERSONA p2 , ALUMNO a 
WHERE P.DNI = P2.DNI AND A.DNI = P2.DNI; 

--27.Suma de los créditos de las asignaturas de la titulación de Matemáticas
SELECT SUM(CREDITOS)
FROM ASIGNATURA a, TITULACION t 
WHERE T.IDTITULACION = A.IDTITULACION 
AND UPPER(T.NOMBRE) = 'MATEMATICAS';

--28.Número de asignaturas de la titulación de Matemáticas
SELECT COUNT(A.IDASIGNATURA)
FROM ASIGNATURA a, TITULACION t 
WHERE T.IDTITULACION = A.IDTITULACION 
AND UPPER(T.NOMBRE) = 'MATEMATICAS';

--29.¿Cuánto paga cada alumno por su matrícula?
SELECT SUM(A.COSTEBASICO) AS PAGA
FROM ALUMNO_ASIGNATURA aa , ASIGNATURA a
WHERE AA.IDASIGNATURA = A.IDASIGNATURA
GROUP BY AA.IDALUMNO;

--30.¿Cuántos alumnos hay matriculados en cada asignatura?
SELECT COUNT(AA.IDALUMNO)
FROM ALUMNO_ASIGNATURA aa , ASIGNATURA a 
WHERE AA.IDASIGNATURA = A.IDASIGNATURA
GROUP BY A.IDASIGNATURA;


--1.Para cada titulación ordenar por coste mostrando primero las asignaturas más caras 
--y para las asignaturas del mismo coste mostrar por orden alfabético de nombre de asignatura. 
SELECT T.NOMBRE  
FROM TITULACION t,ASIGNATURA a
WHERE T.IDTITULACION = A.IDTITULACION ORDER BY A.COSTEBASICO DESC,A.NOMBRE ASC;

--2.Mostrar el nombre y los apellidos de los profesores.

SELECT P.NOMBRE,P.APELLIDO
FROM PERSONA p , PROFESOR p2
WHERE P.DNI = P2.DNI;

--3.Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla.

SELECT A.NOMBRE
FROM ASIGNATURA a , PERSONA p ,PROFESOR p2 
WHERE A.IDPROFESOR = P2.IDPROFESOR AND P2.DNI = P.DNI 
AND UPPER(P.CIUDAD) = 'SEVILLA';

--4.Mostrar el nombre y los apellidos de los alumnos.

SELECT P.NOMBRE, P.APELLIDO
FROM ALUMNO a,PERSONA p 
WHERE A.DNI = P.DNI;

--5.Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla.

SELECT P.DNI,P.NOMBRE,P.APELLIDO
FROM ALUMNO a,PERSONA p 
WHERE A.DNI = P.DNI AND UPPER(P.CIUDAD) = 'SEVILLA';

--6.Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial".

SELECT P.DNI,P.NOMBRE,P.APELLIDO 
FROM ALUMNO_ASIGNATURA aa , ASIGNATURA a,ALUMNO a2,PERSONA p 
WHERE AA.IDASIGNATURA = A.IDASIGNATURA AND A2.IDALUMNO = AA.IDALUMNO 
AND A2.DNI = P.DNI AND UPPER(A.NOMBRE) = 'SEGURIDAD VIAL';

--7.Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI 20202020A.
-- Un alumno está matriculado en una titulación si está matriculado en una asignatura de la titulación.
SELECT A2.IDTITULACION 
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a2, ALUMNO a ,PERSONA p 
WHERE A.DNI = P.DNI AND AA.IDASIGNATURA = A2.IDASIGNATURA
AND P.DNI = '20202020A';

--8.Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.

SELECT DISTINCT A2.NOMBRE
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a2, ALUMNO a ,PERSONA p 
WHERE AA.IDASIGNATURA = A2.IDASIGNATURA AND A.DNI = P.DNI AND UPPER(P.NOMBRE) = 'ROSA' AND UPPER(P.APELLIDO) = 'GARCIA';

--9.Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz.

SELECT A.DNI 
FROM PERSONA p , ALUMNO a , ALUMNO_ASIGNATURA aa, ASIGNATURA a2, PROFESOR p2 
WHERE P2.IDPROFESOR = A2.IDPROFESOR AND A2.IDASIGNATURA = AA.IDASIGNATURA AND
AA.IDALUMNO = A.IDALUMNO AND P.DNI = P2.DNI 
AND (P.NOMBRE)  LIKE 'Jorge' AND P.APELLIDO LIKE 'Saenz';

--10.Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz.
SELECT A.DNI,P.NOMBRE,P.APELLIDO 
FROM PERSONA p , ALUMNO a , ALUMNO_ASIGNATURA aa, ASIGNATURA a2, PROFESOR p2 
WHERE P2.IDPROFESOR = A2.IDPROFESOR AND A2.IDASIGNATURA = AA.IDASIGNATURA AND
AA.IDALUMNO = A.IDALUMNO AND P.DNI = P2.DNI 
AND (P.NOMBRE)  LIKE 'Jorge' AND P.APELLIDO LIKE 'Saenz';

--11.Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos.

SELECT T.NOMBRE 
FROM TITULACION t,ASIGNATURA a 
WHERE T.IDTITULACION = A.IDTITULACION AND A.CREDITOS = 4;

--12.Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre 
--junto con el nombre de la titulación a la que pertenecen. 

SELECT A.NOMBRE,A.CREDITOS,T.NOMBRE AS NOMBRE_TITULACION
FROM ASIGNATURA a,TITULACION t 
WHERE A.IDTITULACION = T.IDTITULACION AND CUATRIMESTRE = 1;

--13.Mostrar el nombre y el coste básico de las asignaturas de más de 
--4,5 créditos junto con el nombre de las personas matriculadas

SELECT A.NOMBRE,A.COSTEBASICO,P.NOMBRE 
FROM ASIGNATURA a,ALUMNO_ASIGNATURA aa ,ALUMNO a2 ,PERSONA p 
WHERE A.IDASIGNATURA = AA.IDASIGNATURA AND AA.IDALUMNO = A2.IDALUMNO 
AND A2.DNI = P.DNI AND CREDITOS  > 4.5;

--14.Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos

SELECT P2.NOMBRE
FROM ASIGNATURA a,PROFESOR p,PERSONA p2
WHERE A.IDPROFESOR = P.IDPROFESOR AND P.DNI = P2.DNI 
AND A.COSTEBASICO BETWEEN 25 AND 35;

--15.Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.
SELECT P.NOMBRE 
FROM PERSONA p ,ALUMNO a ,ALUMNO_ASIGNATURA aa ,ASIGNATURA a2 
WHERE P.DNI = A.DNI AND A.IDALUMNO = AA.IDALUMNO 
AND AA.IDASIGNATURA = A2.IDASIGNATURA 
AND A2.IDASIGNATURA IN ('150212','130113');

--16. Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, 
--junto con el nombre de la titulación a la que pertenece.

SELECT A.NOMBRE , (T.NOMBRE) AS NOMBRE_TITULACION 
FROM ASIGNATURA a , TITULACION t 
WHERE A.IDTITULACION = T.IDTITULACION AND A.CUATRIMESTRE = 2 AND CREDITOS != 6;

--17.Mostrar el nombre y el número de horas de todas las asignaturas. 
--(1cred.=10 horas) junto con el dni de los alumnos que están matriculados.

SELECT A.NOMBRE , (CREDITOS * 10) AS NUM_HORAS, (A2.DNI) AS DNI_ALUMNO
FROM ASIGNATURA a, ALUMNO_ASIGNATURA aa , ALUMNO a2 
WHERE A.IDASIGNATURA = AA.IDASIGNATURA AND AA.IDALUMNO = A2.IDALUMNO;

--18.Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura

SELECT P.NOMBRE
FROM PERSONA p , ALUMNO a , ALUMNO_ASIGNATURA aa 
WHERE P.DNI = A.DNI AND A.IDALUMNO = AA.IDALUMNO 
AND P.CIUDAD LIKE 'Sevilla' AND aa.IDASIGNATURA IS NOT NULL;

--19.Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.

SELECT A.NOMBRE 
FROM ASIGNATURA a , PROFESOR p ,PERSONA p2 
WHERE A.IDPROFESOR = P.IDPROFESOR AND P.DNI = P2.DNI
AND A.CURSO = 1 AND P.IDPROFESOR = 'P101';

--20.Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.

SELECT p.NOMBRE 
FROM ALUMNO a, ALUMNO_ASIGNATURA aa,PERSONA p 
WHERE P.DNI = A.DNI AND A.IDALUMNO = AA.IDALUMNO AND AA.NUMEROMATRICULA >= 3;


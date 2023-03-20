--1. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la
--'150212' y la '130113'.
SELECT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA aa 
WHERE AA.IDASIGNATURA NOT LIKE '150212' AND AA.IDASIGNATURA NOT LIKE '130113';
--2. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial".
SELECT A2.NOMBRE 
FROM ASIGNATURA A2  
WHERE (A2.CREDITOS) > (SELECT A.CREDITOS
FROM ASIGNATURA a 
WHERE A.NOMBRE LIKE 'Seguridad Vial');
--3. Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez.
SELECT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE AA.IDASIGNATURA = A.IDASIGNATURA AND (A.IDASIGNATURA LIKE '150212' 
AND A.IDASIGNATURA LIKE '130113');

--4. Mostrar el Id de los alumnos matriculados en las asignatura "150212" ó "130113", en una o en
--otra pero no en ambas a la vez.
SELECT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE AA.IDASIGNATURA = A.IDASIGNATURA AND (A.IDASIGNATURA LIKE '150212' 
OR A.IDASIGNATURA LIKE '130113');
--5. Mostrar el nombre de las asignaturas de la titulación "130110" 
--cuyos costes básicos sobrepasen
--el coste básico promedio por asignatura en esa titulación.
SELECT A.NOMBRE,A.COSTEBASICO  
FROM ASIGNATURA a 
WHERE A.IDTITULACION LIKE '130110' 
AND A.COSTEBASICO > (SELECT AVG(A2.COSTEBASICO)
					FROM ASIGNATURA a2
					WHERE A2.IDTITULACION LIKE '130110');
--6. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la
--"150212" y la "130113”
SELECT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE AA.IDASIGNATURA = A.IDASIGNATURA AND (A.IDASIGNATURA NOT LIKE '150212' 
AND A.IDASIGNATURA NOT LIKE '130113');
--7. Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113".
SELECT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE AA.IDASIGNATURA = A.IDASIGNATURA AND (A.IDASIGNATURA LIKE '150212' 
AND A.IDASIGNATURA NOT LIKE '130113');
--8. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial".
SELECT A2.NOMBRE 
FROM ASIGNATURA A2  
WHERE (A2.COSTEBASICO * A2.CREDITOS) > (SELECT COSTEBASICO * CREDITOS
FROM ASIGNATURA a 
WHERE A.NOMBRE LIKE 'Seguridad Vial');
--9. Mostrar las personas que no son ni profesores ni alumnos.
SELECT P.NOMBRE
FROM PERSONA p, ALUMNO a, PROFESOR p2 
WHERE P.DNI = A.DNI AND P2.DNI = P.DNI
AND P2.IDPROFESOR IS NULL AND A.IDALUMNO IS NULL;
--10. Mostrar el nombre de las asignaturas que tengan más créditos.
SELECT A.NOMBRE
FROM ASIGNATURA a 
WHERE ROWNUM <= 3 ORDER BY A.CREDITOS DESC;
--11. Lista de asignaturas en las que no se ha matriculado nadie.
SELECT A.NOMBRE 
FROM ALUMNO_ASIGNATURA aa,ASIGNATURA a 
WHERE AA.IDASIGNATURA = A.IDASIGNATURA 
AND AA.IDALUMNO IS NULL;
--12. Ciudades en las que vive algún profesor y también algún alumno. 
SELECT P.CIUDAD 
FROM PERSONA p,ALUMNO a,PROFESOR p2 
WHERE P.DNI = A.DNI AND P2.DNI = P.DNI 
AND P2.DNI IS NOT NULL AND A.DNI IS NOT NULL;
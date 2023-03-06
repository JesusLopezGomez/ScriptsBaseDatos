--1 ejercicio--
SELECT A.NOMBRE || ' ' || A.APELLIDOS AS NOMBRE_Y_APELLIDOS, A.TELF
FROM AFILIADOS a 
WHERE A.SEXO LIKE 'H' 
AND A.NACIMIENTO < TO_DATE('01/01/1070','DD/MM/YYYY');

--2 ejercicio he utilizado el distinct para que no salgan valores repetidos--
SELECT DISTINCT C.PEZ AS NOMBRE_PEZ, C.TALLA, C.PESO 
FROM CAPTURASSOLOS c 
WHERE (C.TALLA < 45 OR C.TALLA = 45) 
ORDER BY C.PEZ ASC,C.PESO DESC,C.TALLA DESC;

--3 ejercicio --
SELECT DISTINCT A.NOMBRE || ' ' || A.APELLIDOS AS NOMBRE_Y_APELLIDOS 
FROM AFILIADOS a,PERMISOS p
WHERE A.FICHA = P.FICHA 
AND UPPER(P.LICENCIA) LIKE 'A%' 
OR (A.TELF LIKE '9%' AND A.DIRECCION LIKE 'Avda%') 

--4 ejercicio --
SELECT DISTINCT l.CAUCE,l.LUGAR,l.COMUNIDAD
FROM CAPTURASSOLOS c,LUGARES l
WHERE C.LUGAR = L.LUGAR AND C.PEZ LIKE 'Tenca';

--5 ejercicio --
SELECT A.NOMBRE || ' ' || A.APELLIDOS AS NOMBRE_Y_APELLIDOS 
FROM AFILIADOS a,PARTICIPACIONES p,EVENTOS e 
WHERE A.FICHA = P.FICHA AND P.EVENTO = E.EVENTO 
AND P.TROFEO IS NOT NULL ORDER BY E.FECHA_EVENTO ASC;

--6 ejercicio --
SELECT DISTINCT A.NOMBRE || ' ' || A.APELLIDOS AS NOMBRE_Y_APELLIDOS_AFILIADOS, A.NOMBRE || ' ' || A.APELLIDOS AS NOMBRE_Y_APELLIDOS_AVAL2
FROM AFILIADOS a,CAPTURASSOLOS c 
WHERE A.FICHA = C.AVAL2;

--7 ejercicio --
SELECT E.EVENTO
FROM EVENTOS e,PARTICIPACIONES p
WHERE E.EVENTO = P.EVENTO AND P.FICHA = 3796 
AND EXTRACT(YEAR FROM E.FECHA_EVENTO) = 1995
AND P.TROFEO IS NULL ORDER BY E.FECHA_EVENTO DESC;

--8 ejercicio --
SELECT COUNT(DISTINCT C.PEZ) AS NUMERO_DE_PECES_CAPTURADOS_FUERA_DE_CONCURSO_DISTINTOS
FROM CAPTURASSOLOS c;

--9 ejercicio --
SELECT L.CAUCE 
FROM LUGARES l 
GROUP BY L.CAUCE 
HAVING COUNT(L.LUGAR) > 1;

--10 ejercicio --
SELECT L.LUGAR
FROM LUGARES l,EVENTOS e 
WHERE L.LUGAR = E.LUGAR AND E.EVENTO IS NULL;

--11 ejercicio --
SELECT COUNT(C.PEZ) AS NUMERO_CAPTURAS,L.CAUCE 
FROM CAPTURASEVENTOS c,LUGARES l,EVENTOS e
WHERE L.LUGAR = E.LUGAR AND E.EVENTO = C.EVENTO
GROUP BY L.CAUCE ORDER BY L.CAUCE ASC,COUNT(C.PEZ) DESC;

--12 ejercicio --
SELECT A.NOMBRE,A.APELLIDOS
FROM CAPTURASEVENTOS c,LUGARES l,EVENTOS e,AFILIADOS a 
WHERE L.LUGAR = E.LUGAR AND E.EVENTO = C.EVENTO AND A.FICHA = C.FICHA
AND C.PEZ IS NOT NULL
GROUP BY A.NOMBRE,A.APELLIDOS 
HAVING COUNT(DISTINCT L.LUGAR) > 10;

--13 ejercicio --
SELECT * FROM(SELECT A.NOMBRE
FROM CAPTURASSOLOS c, AFILIADOS a 
WHERE C.FICHA = A.FICHA 
GROUP BY A.NOMBRE
ORDER BY COUNT(C.PEZ) DESC)
WHERE ROWNUM = 1;

--14 ejercicio --
SELECT DISTINCT (A.NOMBRE || ' ' ||A.APELLIDOS) AS PRIMER_AVAL_NOMBRE_APELLIDOS, (A.NOMBRE ||' '||A.APELLIDOS) AS SEGUNDO_AVAL_NOMBRE_APELLIDOS
FROM AFILIADOS a, CAPTURASSOLOS c
WHERE A.FICHA = C.FICHA AND A.FICHA = C.AVAL1
UNION
SELECT DISTINCT (A.NOMBRE || ' ' ||A.APELLIDOS) AS PRIMER_AVAL_NOMBRE_APELLIDOS, (A.NOMBRE ||' '||A.APELLIDOS) AS SEGUNDO_AVAL_NOMBRE_APELLIDOS
FROM AFILIADOS a, CAPTURASSOLOS c
WHERE A.FICHA = C.FICHA AND A.FICHA = C.AVAL2;




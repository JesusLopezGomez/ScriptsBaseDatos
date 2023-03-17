--1. Obtener el título de la película, la fecha y el nombre del director de las películas 
--en las que su director haya trabajado alguna vez como también como actor o actriz principal
-- o secundaria .

SELECT P.TITULO_P,P.ANO_PRODUCCION,T.NOMBRE_PERSONA 
FROM PELICULA p, TRABAJO t
WHERE P.CIP = T.CIP AND (UPPER(T.TAREA) = 'DIRECTOR')
AND (UPPER(T.TAREA) = 'ACTOR PRINCIPAL' OR UPPER(T.TAREA) = 'ACTOR SECUNDARIO' 
OR UPPER(T.TAREA) = 'ACTRIZ SECUNDARIA' OR UPPER(T.TAREA) = 'ACTRIZ PRINCIPAL') ;

--2. Mostrar todos los datos de las películas que el total de su recaudación 
--sea superior a 700
--veces el número de espectadores que han visto la película
SELECT *
FROM PELICULA P, PROYECCION p2 
WHERE P2.CIP = P.CIP AND P2.RECAUDACION > (P2.ESPECTADORES*700);

--3. Crear una sentencia SQL para obtener todas las salas (nombre del cine y de la sala) que han 
--estrenado películas escocesas (nacionalidad Escocia) en el periodo comprendido entre dos meses 
--antes del 7 de diciembre del año 1996.
SELECT P.CINE,P.SALA 
FROM PROYECCION p,PELICULA p2 
WHERE P.CIP = P2.CIP
AND UPPER(P2.NACIONALIDAD) =  'ESCOCIA' 
AND P.FECHA_ESTRENO BETWEEN TO_DATE('07/10/1996','DD/MM/YYYY') AND TO_DATE('07/12/1996','DD/MM/YYYY');  


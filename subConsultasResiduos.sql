--1Teniendo en cuenta los residuos generados por todas las empresas, mostrar el código del residuo que más se ha generado por todas ellas.
SELECT * FROM(SELECT RE.COD_RESIDUO 
				FROM RESIDUO_EMPRESA re
				ORDER BY RE.CANTIDAD DESC)
WHERE ROWNUM = 1; 
--2Mostrar el nombre dela empresa transportista que sólo trabajó para la empresa con nif R-12356711-Q
SELECT  E.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e,TRASLADO t,EMPRESAPRODUCTORA e2 
WHERE E.NIF_EMPTRANSPORTE = T.NIF_EMPTRANSPORTE 
AND T.NIF_EMPRESA = E2.NIF_EMPRESA 
AND E2.NOMBRE_EMPRESA = (SELECT E.NOMBRE_EMPRESA 
							FROM EMPRESAPRODUCTORA e 
							WHERE E.NIF_EMPRESA LIKE 'R-12356711-Q');
						
SELECT  E.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e JOIN TRASLADO t 
ON E.NIF_EMPTRANSPORTE = T.NIF_EMPTRANSPORTE 
JOIN EMPRESAPRODUCTORA e2 ON T.NIF_EMPRESA = E2.NIF_EMPRESA 
WHERE E2.NOMBRE_EMPRESA = (SELECT E.NOMBRE_EMPRESA 
							FROM EMPRESAPRODUCTORA e 
							WHERE E.NIF_EMPRESA LIKE 'R-12356711-Q');
--Esta se puede hacer sin subconsulta también	

--3Mostrar el nombre de la empresa transportitas que realizó el primer transporte que está registrado en la base de datos.
SELECT * FROM (SELECT E.NOMBRE_EMPTRANSPORTE
				FROM TRASLADO t,EMPRESATRANSPORTISTA e 
				WHERE T.NIF_EMPTRANSPORTE = E.NIF_EMPTRANSPORTE 
				ORDER BY T.FECHA_ENVIO ASC)
WHERE ROWNUM = 1;
--4Mostrar todas las características de los traslados, para aquellos traslados cuyo coste sea superior a la media de todos los traslados.
SELECT * 
FROM TRASLADO t 
WHERE (SELECT AVG(NVL(T2.COSTE,0))
FROM TRASLADO t2) < T.COSTE;
--5Obtener el nombre de las ciudades más cercanas entre las que se ha realizado un envío.
SELECT * FROM(SELECT D.CIUDAD_DESTINO 
				FROM TRASLADO t,DESTINO d 
				WHERE T.COD_DESTINO = D.COD_DESTINO
				ORDER BY T.KMS ASC)
WHERE ROWNUM <= 3;

SELECT D.CIUDAD_DESTINO AS CIUDAD_DESTINO, E.CIUDAD_EMPRESA AS CIUDAD_ORIGEN
FROM DESTINO d, EMPRESAPRODUCTORA e, TRASLADO t
WHERE T.NIF_EMPRESA = E.NIF_EMPRESA 
AND D.COD_DESTINO = T.COD_DESTINO 
AND D.CIUDAD_DESTINO <> E.CIUDAD_EMPRESA 
AND T.KMS = (SELECT MIN(T2.KMS) FROM TRASLADO t2);

--6Obtener el nombre de las empresas que nunca han utilizado el Ferrocarril como medio de transporte.
SELECT DISTINCT EP.NOMBRE_EMPRESA
FROM EMPRESAPRODUCTORA EP
WHERE EP.NOMBRE_EMPRESA NOT IN (SELECT EP.NOMBRE_EMPRESA
                                FROM EMPRESAPRODUCTORA EP, TRASLADO T
                                WHERE EP.NIF_EMPRESA=T.NIF_EMPRESA AND T.TIPO_TRANSPORTE='FERROCARRIL');
--7Obtener el nombre de la empresa que ha realizado más envíos a Madrid.
SELECT T.NIF_EMPRESA
FROM TRASLADO t,DESTINO d
WHERE T.COD_DESTINO = D.COD_DESTINO 
AND UPPER(D.CIUDAD_DESTINO) LIKE 'MADRID' 
GROUP BY T.NIF_EMPRESA ORDER BY COUNT(T.FECHA_ENVIO) DESC;

SELECT E.NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA e 
WHERE E.NIF_EMPRESA = (SELECT * FROM (SELECT T.NIF_EMPRESA
										FROM TRASLADO t,DESTINO d
										WHERE T.COD_DESTINO = D.COD_DESTINO 
										AND UPPER(D.CIUDAD_DESTINO) LIKE 'MADRID' 
										GROUP BY T.NIF_EMPRESA ORDER BY COUNT(T.FECHA_ENVIO) DESC)
						WHERE ROWNUM = 1);
					
--8Vamos a crear una nueva tabla llamada envios, que tendrá un campo llamdo Ciudad_destino, otro
--llamado ciudad_origen, y otro cantidad_total, en la que guardaremos donde van los residuos. La primary key de la tabla debe 
--ser ciudad_destino y ciudad_origen, así podremos evitar que metan dos registros con la misma ciudad destino y origen.
--Cargar dicha tabla con los registros oportunos según nuestra base de datos, teniendo en cuenta que en cantidad total 
--se debe guardar el total de las cantidades que se ha enviado desde ciudad_origen a ciudad_destino
CREATE TABLE ENVIOS(
	CIUDAD_DESTINO VARCHAR2(15),
	CIUDAD_ORIGEN VARCHAR2(15),
	CANTIDAD_TOTAL NUMBER(10),
	CONSTRAINT PK_ENVIOS PRIMARY KEY (CIUDAD_DESTINO,CIUDAD_ORIGEN)
);

INSERT INTO ENVIOS (CIUDAD_DESTINO,CIUDAD_ORIGEN,CANTIDAD_TOTAL) 
SELECT D.CIUDAD_DESTINO, E.CIUDAD_EMPRESA,SUM(T.CANTIDAD) 
FROM DESTINO d,EMPRESAPRODUCTORA e,TRASLADO t 
WHERE T.COD_DESTINO = D.COD_DESTINO AND E.NIF_EMPRESA = T.NIF_EMPRESA
GROUP BY D.CIUDAD_DESTINO, E.CIUDAD_EMPRESA; 

SELECT * FROM ENVIOS
--9Vamos a modificar la tabla residuo para añadir un nuevo campo llamado num_constituyentes. 
--Una vez hayas añadido el nuevo campo crea la sentencia sql necesaria para que este campo tomen los valores adecuados.

ALTER TABLE RESIDUO ADD NUM_CONSTITUYENTES NUMBER(10) ;

UPDATE RESIDUO RE SET NUM_CONSTITUYENTES = (SELECT COUNT(RC.COD_CONSTITUYENTE)
											FROM RESIDUO r,RESIDUO_CONSTITUYENTE rc 
											WHERE R.COD_RESIDUO = RC.COD_RESIDUO
											AND RE.COD_RESIDUO = R.COD_RESIDUO
											GROUP BY R.COD_RESIDUO);
										

SELECT * FROM RESIDUO r 
--10Modifica la tabla empresaproductora añadiendo un campo nuevo llamado nif, que es el nif de la empresa matriz,
-- es decir, de la que depende, por lo que este nuevo campo será una fk sobre el campo nif_empresa. 
--Mostrar un listado en donde salga el nombre de la empresa matriz y el nombre de la empresa de la que depende 
--ordenado por empresa matriz. El nuevo campo llamado nif tomará valores nulos cuando se trate de una empresa que no
-- depende de nadie. No es necesario hacer los cambios, sólo la consulta.

ALTER TABLE EMPRESAPRODUCTORA ADD NIF VARCHAR2(12);
ALTER TABLE EMPRESAPRODUCTORA ADD CONSTRAINT FK2_EMPRESAPRODUCTORA FOREIGN KEY (NIF) REFERENCES EMPRESAPRODUCTORA(NIF_EMPRESA) ON DELETE SET NULL;

SELECT E.NOMBRE_EMPRESA AS EMPRESA_MATRIZ, E2.NOMBRE_EMPRESA AS EMPRESA_SECUNDARIA
FROM EMPRESAPRODUCTORA e , EMPRESAPRODUCTORA e2
WHERE E.NIF_EMPRESA = E2.NIF;

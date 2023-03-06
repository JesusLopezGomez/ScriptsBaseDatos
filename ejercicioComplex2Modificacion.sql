#1-Averigua el DNI de todos los clientes
SELECT DNI
FROM CLIENTE C;
 
#2-Consulta todos los datos de todos los programas.
SELECT *
FROM PROGRAMA P;

#3-Obtén un listado con los nombres de todos los programas.
SELECT NOMBRE
FROM PROGRAMA P;

#4-Genera una lista con todos los comercios.
SELECT NOMBRE
FROM COMERCIO C;

#5-Genera una lista de las ciudades con establecimientos donde se venden
#programas, sin que aparezcan valores duplicados (utiliza DISTINCT).

SELECT DISTINCT C.CIUDAD 
FROM PROGRAMA P,DISTRIBUYE D,COMERCIO C
WHERE P.CODIGO = D.CODIGO AND D.CIF = C.CIF
AND P.CODIGO IS NOT NULL; 

#6-Obtén una lista con los nombres de programas, sin que aparezcan valores
#duplicados (utiliza DISTINCT).
SELECT DISTINCT NOMBRE 
FROM PROGRAMA P;

#7-Obtén el DNI más 4 de todos los clientes
SELECT DNI 
FROM CLIENTE C
WHERE C.DNI > 4;

#8-Haz un listado con los códigos de los programas multiplicados por 7.
SELECT CODIGO * 7 AS CODIGO_POR_7
FROM PROGRAMA P;

#9-¿Cuáles son los programas cuyo código es inferior o igual a 10?
SELECT CODIGO 
FROM PROGRAMA P
WHERE P.CODIGO <= 10;

#10-¿Cuál es el programa cuyo código es 11?
SELECT CODIGO 
FROM PROGRAMA P
WHERE P.CODIGO = 11;

#11-¿Qué fabricantes son de Estados Unidos?
SELECT NOMBRE 
FROM FABRICANTE F
WHERE F.PAIS LIKE 'Estados Unidos';

#12-¿Cuáles son los fabricantes no españoles? Utilizar el operador IN.
SELECT NOMBRE
FROM FABRICANTE F
WHERE F.PAIS NOT IN('España');

#13-Obtén un listado con los códigos de las distintas versiones de Windows.
SELECT CODIGO 
FROM PROGRAMA P
WHERE P.NOMBRE LIKE 'Windows';

#14-¿En qué ciudades comercializa programas El Corte Inglés?
SELECT C.NOMBRE 
FROM PROGRAMA P,COMERCIO C,DISTRIBUYE D
WHERE P.CODIGO = D.CODIGO AND D.CIF = C.CIF
AND P.NOMBRE LIKE 'El Corte Inglés';

#15-¿Qué otros comercios hay, además de El Corte Inglés? Utilizar el operador IN.
SELECT C.NOMBRE 
FROM PROGRAMA P,COMERCIO C,DISTRIBUYE D
WHERE P.CODIGO = D.CODIGO AND D.CIF = C.CIF
AND P.NOMBRE NOT IN ('El Corte Inglés'); 

#16-Genera una lista con los códigos de las distintas versiones de Windows y Access. Utilizar el operador IN.
SELECT CODIGO 
FROM PROGRAMA P
WHERE P.NOMBRE IN ('Windows','Access');

#17-Obtén un listado que incluya los nombres de los clientes de edades 
#comprendidas entre 10 y 25 y de los mayores de 50 años. Da una solución con
#BETWEEN y otra sin BETWEEN.

SELECT NOMBRE 
FROM CLIENTE C
WHERE EDAD BETWEEN (10 AND 25) AND EDAD > 40;

#18-Saca un listado con los comercios de Sevilla y Madrid. No se admiten valores duplicados.
SELECT DISTINCT NOMBRE 
FROM COMERCIO C
WHERE C.CIUDAD IN ('Sevila','Madrid');

#19-¿Qué clientes terminan su nombre en la letra “o”?
SELECT NOMBRE 
FROM CLIENTE C
WHERE C.NOMBRE LIKE '%o';

#20-¿Qué clientes terminan su nombre en la letra “o” y, además, son mayores de 30 años?
SELECT NOMBRE 
FROM CLIENTE C
WHERE C.NOMBRE LIKE '%o' AND EDAD > 30;

#21 Obtén un listado en el que aparezcan los programas cuya versión 
#finalice por una letra i, o cuyo nombre comience por una A o por una W.
SELECT P.NOMBRE 
FROM PROGRAMA P
WHERE P.NOMBRE LIKE '%i' OR P.NOMBRE LIKE 'A%' OR P.NOMBRE LIKE 'W%';

#22-Obtén un listado en el que aparezcan los programas cuya versión finalice 
#por una letra i, o cuyo nombre comience por una A y termine por una S.
SELECT P.NOMBRE 
FROM PROGRAMA P
WHERE P.NOMBRE LIKE '%i' OR P.NOMBRE LIKE 'A%' OR P.NOMBRE LIKE '%S';

#23-Obtén un listado en el que aparezcan los programas cuya versión finalice 
#por una letra i, y cuyo nombre no comience por una A.
SELECT P.NOMBRE 
FROM PROGRAMA P
WHERE P.NOMBRE LIKE '%i' OR P.NOMBRE NOT LIKE 'A%'; 

#24-Obtén una lista de empresas por orden alfabético ascendente.
SELECT NOMBRE 
FROM FABRICANTE F ORDER BY NOMBRE ASC;

#25-Genera un listado de empresas por orden alfabético descendente.
SELECT NOMBRE 
FROM FABRICANTE F ORDER BY NOMBRE DESC;
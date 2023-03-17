--1. Número de clientes que tienen alguna factura con IVA 16%.
SELECT COUNT(C.CODCLI)
FROM CLIENTES c,FACTURAS f2 
WHERE C.CODCLI = F2.CODCLI 
AND F2.IVA = ANY (SELECT IVA 
FROM FACTURAS f
WHERE F.IVA = 16);
--2. Número de clientes que no tienen ninguna factura con un 16% de IVA.
SELECT COUNT(C.CODCLI)
FROM CLIENTES c,FACTURAS f2 
WHERE C.CODCLI = F2.CODCLI 
AND F2.IVA NOT IN (SELECT IVA 
FROM FACTURAS f
WHERE F.IVA = 16);
--3. Número de clientes que en todas sus facturas tienen un 16% de IVA (los clientes deben tener al menos una factura).
SELECT COUNT(C.CODCLI)
FROM CLIENTES c,FACTURAS f2 
WHERE C.CODCLI = F2.CODCLI 
AND F2.IVA = ANY (SELECT IVA 
FROM FACTURAS f
WHERE F.IVA = 16);
--4. Fecha de la factura con mayor importe (sin tener en cuenta descuentos ni impuestos).
SELECT F2.FECHA 
FROM FACTURAS f2,LINEAS_FAC lf2 
WHERE F2.CODFAC = LF2.CODFAC 
AND LF2.PRECIO = (SELECT MAX(LF.PRECIO)
FROM LINEAS_FAC lf);
--5. Número de pueblos en los que no tenemos clientes.
SELECT COUNT(P.CODPUE)
FROM CLIENTES c,PUEBLOS p 
WHERE C.CODPUE(+) = P.CODPUE AND C.CODCLI IS NULL;
--6. Número de artículos cuyo stock supera las 20 unidades, con precio superior a 15 euros
-- y de los que no hay ninguna factura en el último trimestre del año pasado.
SELECT COUNT(A.CODART)
FROM ARTICULOS a 
WHERE STOCK > 20 AND PRECIO > 15;



SELECT CODFAC 
FROM FACTURAS f 
WHERE F.FECHA = ADD_MONTHS(SYSDATE ,-3);
--7. Obtener el número de clientes que en todas las facturas del año 
--pasado han pagado IVA (no se ha pagado IVA si es cero o nulo).
SELECT COUNT(C.CODCLI)
FROM FACTURAS f,CLIENTES c
WHERE F.CODCLI = C.CODCLI AND (F.IVA IS NULL OR F.IVA = 0); --Me falta lo del año pasao

--8. Clientes (código y nombre) que fueron preferentes durante el mes de noviembre del año pasado y
--que en diciembre de ese mismo año no tienen ninguna factura. 
--Son clientes preferentes de un mes aquellos que han solicitado más de 60,50 euros 
--en facturas durante ese mes, sin tener en cuenta descuentos ni impuestos.



--9. Código, descripción y precio de los diez artículos más caros.

SELECT LF.CODART,A.DESCRIP,A.PRECIO 
FROM LINEAS_FAC lf , FACTURAS f, ARTICULOS a 
WHERE LF.CODFAC = F.CODFAC AND A.CODART = LF.CODART 
ORDER BY A.PRECIO DESC; 

--10. Nombre de la provincia con mayor número de clientes.
--11. Código y descripción de los artículos cuyo precio es mayor de 90,15 euros y se han vendido menos de 10 unidades (o ninguna) durante el año pasado.
--12. Código y descripción de los artículos cuyo precio es más de tres mil veces mayor que el precio mínimo de cualquier artículo.
--13. Nombre del cliente con mayor facturación.
--14. Código y descripción de aquellos artículos con un precio superior a la media y que hayan sido comprados por más de 5 clientes.
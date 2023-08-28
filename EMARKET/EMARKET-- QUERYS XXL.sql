USE emarket;

/* ¿Cuántos clientes existen? */
SELECT count(*) FROM clientes;

/* ¿Cuántos clientes hay por ciudad? */
SELECT ciudad, count(*) AS clientes_X_ciudad
FROM clientes
GROUP BY ciudad;

  -- --------------------------------------- -- 
			/* ACTIVIDAD CON FACTURAS*/
  -- --------------------------------------- -- 

/* Cuál es el total de transporte? */
SELECT round(sum(Transporte), 2)
FROM facturas;

/* ¿Cuál es el total de transporte por EnvioVia (empresa de envío)? */
SELECT EnvioVia, sum(EnvioVia) AS totalesXenvio
FROM facturas
GROUP BY EnvioVia;

/* Calcular la cantidad de facturas por cliente. Ordenar descendentemente por cantidad de facturas. */
SELECT ClienteID, count(ClienteID) AS total_facturas
FROM facturas
GROUP BY ClienteID
ORDER BY count(ClienteID) DESC;

/* Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas. */
SELECT ClienteID, count(ClienteID) AS total_facturas
FROM facturas
GROUP BY ClienteID
ORDER BY count(ClienteID) DESC
LIMIT 5;

/* ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas? */
SELECT PaisEnvio, count(*) AS total_envios
FROM facturas
GROUP BY PaisEnvio
ORDER BY total_envios asc
LIMIT 1;

/* Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado realizó más operaciones de ventas? */
SELECT EmpleadoID, count(ClienteID) AS VentasTotales
FROM facturas
GROUP BY EmpleadoID
ORDER BY count(ClienteID) DESC;

  -- --------------------------------------- -- 
		/* actividad con Factura detalle */
  -- --------------------------------------- -- 
/* ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle? */

SELECT ProductoID, count(Cantidad)
FROM facturadetalle
GROUP BY ProductoID
ORDER BY count(Cantidad) DESC
LIMIT 3;

/* ¿Cuál es el total facturado? Considerar que el total facturado es la suma de cantidad por precio unitario. */

-- TOTAL POR FACTURA -- 
SELECT FacturaID, SUM(PrecioUnitario * Cantidad) AS PrecioTotal
FROM facturadetalle
GROUP BY FacturaID;

-- TOTAL FACTURADO --
SELECT round(SUM(PrecioUnitario), 2) 
FROM facturadetalle;

/* ¿Cuál es el total facturado para los productos ID entre 30 y 50? */

-- TOTAL FACTURADO POR PRODUCTO --
SELECT ProductoID, SUM(PrecioUnitario * Cantidad) AS PrecioTotal
FROM facturadetalle
WHERE ProductoID BETWEEN 30 AND 50
GROUP BY ProductoID;

-- TOTAL FACTURADO EN TOTAL
SELECT ROUND(SUM(PrecioUnitario * Cantidad), 2) AS total_facturado
FROM facturadetalle
WHERE ProductoID BETWEEN 30 AND 50;

/* ¿Cuál es el precio unitario promedio de cada producto? */

SELECT ProductoID, ROUND(AVG(PrecioUnitario), 2) AS precio_unitario_promedio
FROM facturadetalle
GROUP BY ProductoID;

/* ¿Cuál es el precio unitario máximo? */

SELECT ProductoID, MAX(PrecioUnitario)
FROM facturadetalle
GROUP BY ProductoID
ORDER BY MAX(PrecioUnitario) DESC
LIMIT 3;

-- --------------------------------------- -- 
/* Consultas queries XL parte II - JOIN */
-- --------------------------------------- -- 

/* Generar un listado de todas las facturas del empleado 'Buchanan'.  */

SELECT E.Nombre, E.Apellido, F.FacturaID, F.FechaFactura, F.FechaRegistro
FROM facturas AS F
INNER JOIN empleados AS E ON F.EmpleadoID = E.EmpleadoID
WHERE E.Apellido LIKE 'buchanan'
ORDER BY F.FacturaID ASC;

/* Generar un listado con todos los campos de las facturas del correo 'Speedy Express'. */

SELECT F.*
FROM facturas F
INNER JOIN correos C ON F.EnvioVia = C.CorreoID
WHERE Compania = 'Speedy Express';

/* Generar un listado de todas las facturas con el nombre y apellido de los empleados. */

SELECT E.Apellido, E.Nombre, F.*
FROM Facturas F
INNER JOIN empleados E ON F.EmpleadoID = E.EmpleadoID;

/* Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”. */

SELECT C.Contacto, C.Titulo, F.*
FROM facturas F 
INNER JOIN clientes C ON F.ClienteID = C.ClienteID
WHERE C.Titulo = 'Owner' AND PaisEnvio = 'USA';

/*Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” 
o que incluyan el producto id = “42”*/

SELECT E.Apellido,P.ProductoID, F.*
FROM Facturas AS F
INNER JOIN empleados AS E ON F.EmpleadoID = E.EmpleadoID
INNER JOIN facturadetalle AS fe ON F.FacturaID = fe.FacturaID
INNER JOIN productos AS P ON fe.ProductoID = P.ProductoID
WHERE E.Apellido = 'Leverling' OR fe.ProductoID = 42;

/* Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling”
y que incluya los producto id = “80” o ”42”. */

SELECT E.Apellido,P.ProductoID, F.*
FROM Facturas AS F
INNER JOIN empleados AS E ON F.EmpleadoID = E.EmpleadoID
INNER JOIN facturadetalle AS fe ON F.FacturaID = fe.FacturaID
INNER JOIN productos AS P ON fe.ProductoID = P.ProductoID
WHERE E.Apellido = 'Leverling' AND (fe.ProductoID = 80 OR fe.ProductoID = 42);

/* Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad). */

SELECT c.ClienteID, c.Contacto , ROUND(SUM(fe.PrecioUnitario * fe.Cantidad), 2) AS TotalCompras
FROM clientes c
INNER JOIN facturas f ON c.ClienteID = f.ClienteID
INNER JOIN facturadetalle fe ON f.FacturaID = fe.FacturaID
GROUP BY c.ClienteID, c.Contacto
ORDER BY TotalCompras DESC
LIMIT 5;

/* Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
 fecha de factura, país de envío, Total,
 ordenado de manera descendente por fecha de factura y limitado a 10 filas. */
 
SELECT c.ClienteID, c.Contacto, F.FechaFactura, F.PaisEnvio, SUM(fe.PrecioUnitario * fe.Cantidad ) as Total
FROM Facturas AS F
INNER JOIN clientes AS c ON F.ClienteID = c.ClienteID
INNER JOIN facturadetalle AS fe ON F.FacturaID = fe.FacturaID
group by  c.ClienteID, c.Contacto, 
F.FechaFactura, F.PaisEnvio
ORDER BY FechaFactura DESC
LIMIT 10;
 
 
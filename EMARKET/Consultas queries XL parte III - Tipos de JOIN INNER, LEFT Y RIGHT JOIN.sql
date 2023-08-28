USE emarket;
-- ------------------------------------ --
-- Reportes parte I - Repasamos INNER JOIN
-- ------------------------------------ --

/* Realizar una consulta de la facturación de e-market. Incluir la siguiente información: */
SELECT f.FacturaID, f.FechaFactura, c.Compania AS NombreCorreo, cl.Contacto AS NombreApellidoCliente , p.ProductoNombre AS NombreProducto, ca.CategoriaNombre, fd.PrecioUnitario, fd.Cantidad
FROM facturas AS f
INNER JOIN correos AS c ON f.EnvioVia = c.CorreoID
INNER JOIN clientes AS cl ON f.ClienteID = cl.ClienteID
INNER JOIN	facturadetalle AS fd ON f.FacturaID = fd.FacturaID
INNER JOIN productos AS p ON fd.ProductoID = p.ProductoID
INNER JOIN categorias AS ca ON p.CategoriaID = ca.CategoriaID;

-- ------------------------------------ --
-- Reportes parte II - INNER, LEFT Y RIGHT JOIN
-- ------------------------------------ --

-- 1) Listar todas las categorías junto con información de sus productos.
-- Incluir todas las categorías aunque no tengan productos.

SELECT p.ProductoNombre, ca.CategoriaNombre, ca.Descripcion
FROM productos AS p
RIGHT JOIN categorias AS ca ON p.CategoriaID = ca.CategoriaID
WHERE CategoriaNombre IS NULL;

-- 2) Listar la información de contacto de los clientes que no hayan comprado nunca en emarket.
SELECT cl.Contacto, Titulo,Direccion, Ciudad, Regiones, CodigoPostal ,Pais, Telefono, Fax
FROM clientes AS cl
LEFT JOIN facturas AS f ON cl.ClienteID = f.ClienteID
WHERE f.ClienteID IS NULL;

-- 3) Realizar un listado de productos. Para cada uno indicar su nombre,
-- categoría, y la información de contacto de su proveedor. 
-- Tener en cuenta que puede haber productos para los cuales no se indicó quién es el proveedor.
SELECT P.ProductoNombre, P.CategoriaID, CA.CategoriaNombre, P.ProveedorID, PR.Contacto, PR.Direccion, PR.Ciudad, PR.CodigoPostal
FROM productos as p
LEFT JOIN proveedores as PR ON P.ProveedorID = P.ProveedorID
INNER JOIN categorias AS CA ON P.CategoriaID = CA.CategoriaID
WHERE PR.ProveedorID IS NULL;

-- 4) Para cada categoría listar el promedio del precio unitario de sus productos.
SELECT c.CategoriaNombre, ROUND(AVG(PrecioUnitario),2) AS PrecioPromedio
FROM productos AS p 
INNER JOIN categorias AS c ON p.CategoriaID = c.CategoriaID
GROUP BY c.CategoriaNombre;

-- 5) Para cada cliente, indicar la última factura de compra. Incluir a los clientes que nunca hayan comprado en e-market.

SELECT C.Contacto, F.FechaFactura 
FROM clientes AS C
LEFT JOIN facturas AS F ON C.ClienteID = F.ClienteID
WHERE F.FechaFactura is null;

-- 6)Todas las facturas tienen una empresa de correo asociada (enviovia).
-- Generar un listado con todas las empresas de correo, y la cantidad de facturas correspondientes.
-- Realizar la consulta utilizando RIGHT JOIN.

SELECT C.compania, COUNT(EnvioVia)
FROM facturas AS F
RIGHT JOIN correos AS C ON  F.EnvioVia = C.CorreoID
GROUP BY C.compania
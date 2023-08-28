/* Listar las canciones cuya duración sea mayor a 2 minutos. */
-- FORMA 1
SELECT *
FROM canciones
WHERE milisegundos >= 160000;
-- FORMA 2
SELECT nombre
FROM Canciones
WHERE milisegundos / 60000 > 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

/* Listar las canciones cuyo nombre comience con una vocal. */
-- FROMA 1
SELECT *
FROM canciones
WHERE nombre LIKE 'A%' OR nombre LIKE 'E%' OR nombre LIKE 'I%' OR nombre LIKE 'O%' OR nombre LIKE 'U%'
ORDER BY nombre ASC;
-- FORMA 2 
SELECT *
FROM canciones
WHERE UPPER(SUBSTRING(nombre, 1, 1)) IN ('A', 'E', 'I', 'O', 'U')
ORDER BY nombre ASC;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 3) CANCIONES

-- A) Listar las canciones ordenadas por compositor en forma descendente.
SELECT nombre, compositor
FROM canciones
order by compositor desc;

-- B) Luego, por nombre en forma ascendente. Incluir únicamente aquellas canciones que tengan compositor. 

SELECT nombre, compositor
FROM canciones
WHERE compositor IS NOT NULL AND nombre IS NOT NULL
  AND compositor <> '' AND nombre <> ''
ORDER BY nombre ASC;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 4)Canciones

-- A) Listar la cantidad de canciones de cada compositor. 
SELECT compositor, COUNT(nombre) as CantidadCanciones
FROM canciones 
WHERE compositor IS NOT NULL AND nombre IS NOT NULL
  AND compositor <> '' AND nombre <> ''
GROUP BY compositor;

-- B) Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones. 
SELECT compositor, COUNT(nombre) as CantidadCanciones
FROM canciones 
WHERE compositor IS NOT NULL AND nombre IS NOT NULL
  AND compositor <> '' AND nombre <> ''
GROUP BY compositor
HAVING COUNT(nombre) > 10;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 5) Facturas

-- A) Listar el total facturado agrupado por ciudad.
SELECT ciudad_de_facturacion, SUM(total)
FROM facturas
GROUP BY ciudad_de_facturacion;

-- B)Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.
SELECT ciudad_de_facturacion, SUM(total)
FROM facturas
WHERE pais_de_facturacion = 'Canada'
GROUP BY ciudad_de_facturacion;

-- C) Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.
SELECT ciudad_de_facturacion, SUM(total) AS TotalFacturado
FROM facturas
GROUP BY ciudad_de_facturacion
HAVING SUM(total)> 38;

-- D)Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.
SELECT pais_de_facturacion, ciudad_de_facturacion, SUM(total)
FROM facturas
GROUP BY pais_de_facturacion, ciudad_de_facturacion
ORDER BY pais_de_facturacion ASC;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 6)Canciones / Géneros

-- A) Listar la duración mínima, máxima y promedio de las canciones. 
SELECT MIN(milisegundos), MAX(milisegundos), AVG(milisegundos)
FROM canciones;

-- B) Modificar el punto (a) mostrando la información agrupada por género.
SELECT g.nombre, MIN(milisegundos), MAX(milisegundos), AVG(milisegundos)
FROM canciones c
INNER JOIN generos g ON c.id_genero = g.id
GROUP BY g.nombre;

SELECT count(*)
FROM clientes
WHERE pais = 'brazil'
GROUP BY pais;

SELECT id_genero, count(*) AS cantidad_canciones
FROM canciones
GROUP BY id_genero;

SELECT sum(total) AS TotalGastado
FROM facturas;

SELECT id_album, AVG(milisegundos) AS promedio_ms
FROM canciones
WHERE id_album = 4
GROUP BY id_album;

select a. titulo AS nombre_album, 
(select AVG(c.milisegundos) FROM canciones c WHERE c.id_album=a.id) AS duracion_promedio
FROM albumes a ;
 
SELECT sum(bytes), MIN(bytes) AS menor_peso
FROM canciones;

SELECT id_cliente , SUM(total) AS total
FROM facturas
WHERE id_cliente = 6
GROUP BY id_cliente
HAVING SUM(total) > 45;
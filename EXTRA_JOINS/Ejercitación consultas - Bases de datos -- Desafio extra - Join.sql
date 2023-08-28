USE extra_joins;

-- 1) Obtener los artistas que han actuado en una o más películas.
SELECT AP.artista_id, A.apellido, A.nombre, titulo
FROM artista AS A
JOIN artista_x_pelicula AS AP ON A.id = AP.artista_id
JOIN pelicula AS P ON P.id = AP.pelicula_id;

-- 2)Obtener las películas donde han participado más de un artista según nuestra base de datos. 
SELECT P.titulo, COUNT(*) AS NumeroArtistas
FROM pelicula AS P 
JOIN artista_x_pelicula AS AP ON P.id = AP.pelicula_id
JOIN artista AS A ON A.id = AP.artista_id
GROUP BY P.id, P.titulo
HAVING COUNT(*) > 1;

-- 3) Obtener aquellos artistas que han actuado en alguna película, 
-- incluso aquellos que aún no lo han hecho, según nuestra base de datos.
SELECT A.id, apellido, nombre, P.id, titulo, anio
FROM artista AS A
LEFT JOIN artista_x_pelicula AS AP ON A.id = AP.artista_id
LEFT JOIN pelicula AS P ON P.id = AP.pelicula_id;

-- 4) Obtener las películas que no se le han asignado artistas en nuestra base de datos.
SELECT *
FROM pelicula AS P
LEFT JOIN artista_x_pelicula AS AP ON P.id = AP.pelicula_id
WHERE AP.artista_id IS NULL;

-- 5)Obtener aquellos artistas que no han actuado en alguna película, según nuestra base de datos.

SELECT *
FROM artista AS A
LEFT JOIN artista_x_pelicula AS AP ON A.id = AP.artista_id
WHERE AP.pelicula_id is null;

-- 6) Obtener aquellos artistas que han actuado en dos o más películas según nuestra base de datos.

SELECT A.nombre, COUNT(*)
FROM artista AS A
RIGHT JOIN artista_x_pelicula AS AP ON A.id = AP.artista_id
RIGHT JOIN pelicula AS P ON AP.pelicula_id = P.id
GROUP BY A.nombre
having COUNT(*) >= 2;

-- 7) Obtener aquellas películas que tengan asignado uno o más artistas, 
-- incluso aquellas que aún no le han asignado un artista en nuestra base de datos.
SELECT P.titulo, COUNT(*) AS NumeroArtistas
FROM pelicula AS P 
RIGHT JOIN artista_x_pelicula AS AP ON P.id = AP.pelicula_id
RIGHT JOIN artista AS A ON A.id = AP.artista_id
GROUP BY P.id, P.titulo
HAVING COUNT(*) > 1;


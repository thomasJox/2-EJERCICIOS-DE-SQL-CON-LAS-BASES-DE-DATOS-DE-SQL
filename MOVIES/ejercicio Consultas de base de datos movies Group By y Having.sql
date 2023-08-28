USE movies_db;

/*¿Cuántas películas hay?*/
SELECT count(*)
FROM movies;

/*¿Cuántas películas tienen entre 3 y 7 premios?*/
SELECT COUNT(*) 
FROM movies
WHERE awards between 3 AND 7;

/*¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7?*/
SELECT COUNT(*) 
FROM movies
WHERE awards between 3 AND 7
AND rating > 7;

/*Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por id. de género.*/
SELECT genre_id AS numero_de_genero, count(*) AS cantidad_de_peliculas
FROM movies
GROUP BY genre_id;

/*De la consulta anterior, listar sólo aquellos géneros que tengan como suma de premios un número mayor a 5.*/
SELECT genre_id AS numero_de_genero, count(*) AS cantidad_de_peliculas
FROM movies
GROUP BY genre_id
HAVING SUM(awards)> 5;


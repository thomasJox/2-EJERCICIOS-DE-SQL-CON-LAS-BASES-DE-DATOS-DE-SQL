-- 1) Utilizando la base de datos de movies, queremos conocer,
-- por un lado, los títulos y el nombre del género de todas las series de la base de datos.

SELECT s.title, g.name
FROM series s
INNER JOIN genres g ON s.genre_id= g.id;

-- 2) Por otro, necesitamos listar los títulos de los episodios 
-- junto con el nombre y apellido de los actores que trabajan en cada uno de ellos.

SELECT e.title, a.first_name, a.last_name
FROM episodes e
INNER JOIN actor_episode ae ON e.id = ae.episode_id
INNER JOIN actors a ON ae.actor_id = a.id; 

-- 3) Para nuestro próximo desafío, necesitamos obtener a todos los actores o actrices (mostrar nombre y apellido) 
-- que han trabajado en cualquier película de la saga de La Guerra de las galaxias.

SELECT DISTINCT M.title, A.first_name, A.last_name
FROM actors A
INNER JOIN actor_movie AM ON A.id = AM.actor_id
INNER JOIN movies M ON AM.movie_id = M.id
WHERE M.title LIKE 'La Guerra%';

-- 4) Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por nombre de género.

SELECT G.name as NombreGenero, COUNT(*) AS CantidadPorGenero
FROM movies M
INNER JOIN genres G ON M.genre_id = G.id
GROUP BY G.name;


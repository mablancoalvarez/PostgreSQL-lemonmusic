
--Listar las pistas (tabla Track) con precio mayor o igual a 1
SELECT  T.trackId, T.name, T.unitprice
FROM track T
WHERE T.unitprice >= 1;

--Listar las pistas de mas de 4 minutos de duracion
SELECT T.trackid,
       T.name,
       T.milliseconds * INTERVAL '1 millisecond' AS duration
FROM track T
WHERE T.milliseconds * INTERVAL '1 millisecond' > INTERVAL '4 minutes';

--Listar las pistas que tengan entre 2 y 3 minutos de duracion
SELECT T.trackid,
       T.name,
       T.milliseconds * INTERVAL '1 millisecond' AS duration
FROM track T
WHERE T.milliseconds * INTERVAL '1 millisecond' BETWEEN INTERVAL '2 minutes' AND INTERVAL '3 minutes';

--Listar las pistas que uno de sus compositores (columna Composer) sea Mercury
SELECT T.trackid,T.name,T.composer
FROM track T
WHERE T.composer LIKE '%Mercury%';

-- Calcular la media de duracion de las pistas (Track) de la plataforma
SELECT AVG(T.milliseconds) * INTERVAL '1 millisecond' AS duracion_media
FROM track T;

--Listar los clientes (tabla Customer) de USA, Canada y Brazil
SELECT C.customerid, C.firstname, C.lastname, C.country
FROM customer C
WHERE C.country IN ('USA', 'Canada', 'Brazil')
ORDER BY C.country;

--Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')
SELECT A.artistid, A.name, T.name AS song_name
FROM artist A
INNER JOIN album Al ON A.artistid = Al.artistid
INNER JOIN track T ON Al.albumid = T.albumid
WHERE A.name = 'Queen';


--Listar las pistas del artista 'Queen' 
--en las que haya participado como compositor David Bowie

SELECT A.artistid, A.name, T.name AS song_name
FROM artist A
INNER JOIN album Al ON A.artistid = Al.artistid
INNER JOIN track T ON Al.albumid = T.albumid
WHERE A.name = 'Queen' AND T.composer LIKE '%David Bowie%';

--Listar las pistas de la playlist 'Heavy Metal Classic'
SELECT T.trackid, T.name
FROM playlist P
INNER JOIN playlisttrack PL ON P.playlistid = PL.playlistid
INNER JOIN track T ON PL.trackId = T.trackId
WHERE P.name = 'Heavy Metal Classic';

--Listar las playlist junto con el numero de pistas que contienen
SELECT P.playlistid, P.name, COUNT(PL.trackid) AS total_tracks
FROM playlist P
LEFT JOIN playlisttrack PL ON P.playlistid = PL.playlistid
GROUP BY P.playlistid;

-- Listar las playlist (sin repetir ninguna) que tienen alguna cancion de AC/DC
SELECT DISTINCT P.playlistid, P.name
FROM playlist P
INNER JOIN playlisttrack PL ON P.playlistid = PL.playlistid
INNER JOIN track T ON PL.trackId = T.trackId
INNER JOIN album A ON T.albumid = A.albumid
INNER JOIN artist AR ON A.artistid = AR.artistid
WHERE AR.name = 'AC/DC';

--Listar las playlist que tienen alguna cancion del artista Queen, 
--junto con la cantidad que tienen

SELECT P.playlistid, P.name,COUNT(T.trackId) AS number_queen_songs
FROM playlist P
INNER JOIN playlisttrack PL ON P.playlistid = PL.playlistid
INNER JOIN track T ON PL.trackId = T.trackId
INNER JOIN album A ON T.albumid = A.albumid
INNER JOIN artist AR ON A.artistid = AR.artistid
WHERE AR.name = 'Queen'
GROUP BY P.playlistid;

--Listar las pistas que no estan en ninguna playlist
SELECT T.trackid,T.name
FROM track T
LEFT JOIN playlisttrack PL ON T.trackid = PL.trackid
WHERE PL.playlistid IS NULL;

--Listar los artistas que no tienen album
SELECT A.artistid, A.name
FROM artist A
LEFT JOIN album AL ON A.artistid = AL.artistid
WHERE AL.albumid IS NULL;

--Listar los artistas con el número de albums que tienen
--Para saber si está bien, asegurate que algunos de los artistas de la query anterior
--(artistas sin album) aparecen en este listado con 0 albums

SELECT AR.artistid, AR.name, COUNT (AL.albumid) AS total_album
FROM artist AR
LEFT JOIN album AL ON AR.artistid = AL.artistid
GROUP BY AR.artistid;
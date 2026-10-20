--Listar las pistas ordenadas por el número de veces que aparecen
--en playlists de forma descendente
SELECT T.trackid, T.name,COUNT(T.trackid) AS total_track
FROM track T
INNER JOIN playlisttrack PL ON T.trackid = PL.trackid
GROUP BY T.trackid
ORDER BY total_track DESC;

--Listar las pistas más compradas 
--(la tabla InvoiceLine tiene los registros de compras)
SELECT T.trackid, T.name, SUM(I.quantity) AS total_compras
FROM invoiceline I
INNER JOIN track T ON I.trackid = T.trackid
GROUP BY T.trackid, T.name
ORDER BY total_compras DESC;

--Listar los artistas más comprados
SELECT AR.artistid, AR.name, SUM(I.quantity) AS total_compras
FROM invoiceline I
INNER JOIN track T ON I.trackid = T.trackid
INNER JOIN album AL ON T.albumid = AL.albumid
INNER JOIN artist AR ON AL.artistid = AR.artistid
GROUP BY AR.artistid, AR.name
ORDER BY total_compras DESC;

--Listar las pistas que aún no han sido compradas por nadie
SELECT T.trackid, T.name
FROM track T
LEFT JOIN invoiceline I ON T.trackid = I.trackid
WHERE I.trackid IS NULL;

--Listar los artistas que aún no han vendido ninguna pista
SELECT A.artistid, A.name
FROM artist A
LEFT JOIN album AL ON A.artistid = AL.artistid
LEFT JOIN track T ON AL.albumid = T.albumid
LEFT JOIN invoiceline I ON T.trackid = I.trackid
GROUP BY A.artistid, A.name
HAVING COUNT(I.invoicelineid) = 0;
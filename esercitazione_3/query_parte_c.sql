USE palinsesto;



-- 1. "Elenca i programmi a cui partecipa Marta Fumagalli"
-- DIFETTO: la sottoquery e' confrontata con "=", che richiede UNA sola riga,
-- ma Marta lavora in piu' programmi.

-- QUERY ORIGINALE (errore)
/*SELECT nome
FROM programmi
WHERE codice = (SELECT cod_programma FROM artisti WHERE nome_artista = 'Marta Fumagalli');*/

-- CORREZIONE: IN al posto di "="
SELECT nome
FROM programmi
WHERE codice IN (SELECT cod_programma FROM artisti WHERE nome_artista = 'Marta Fumagalli');



-- 2. "Programmi in cui lavora Marta oppure con almeno un sondaggio con
--      share > 17. Ogni programma deve comparire una sola volta."
-- DIFETTO: UNION ALL non elimina i duplicati, ma la traccia chiede che ogni
-- programma compaia una sola volta. 

-- QUERY ORIGINALE (errore)
/*SELECT p.nome
FROM programmi p, artisti a
WHERE a.cod_programma = p.codice AND a.nome_artista = 'Marta Fumagalli'
UNION ALL
SELECT p.nome
FROM programmi p, sondaggi s
WHERE s.cod_programma = p.codice AND s.share > 17;*/

-- CORREZIONE: UNION (unione insiemistica, elimina i duplicati)
SELECT p.codice, p.nome
FROM programmi p
JOIN artisti a ON a.cod_programma = p.codice
WHERE a.nome_artista = 'Marta Fumagalli'
UNION
SELECT p.codice, p.nome
FROM programmi p
JOIN sondaggi s ON s.cod_programma = p.codice
WHERE s.share > 17;



-- 3. "Elenca i programmi che non hanno nessun artista"
-- DIFETTO: la sottoquery del NOT EXISTS NON e' correlata a p: "SELECT * FROM
-- artisti" non e' legata al programma corrente. Poiche' la tabella artisti non
-- e' vuota, EXISTS e' sempre vero, quindi NOT EXISTS e' sempre falso e la query restituisce sempre 0 righe.

-- QUERY ORIGINALE (errore)
/*SELECT p.nome
FROM programmi p
WHERE NOT EXISTS (SELECT * FROM artisti);*/

-- CORREZIONE: correlare la sottoquery al programma p
SELECT p.codice, p.nome
FROM programmi p
WHERE NOT EXISTS (SELECT * FROM artisti a WHERE a.cod_programma = p.codice);



-- E4. "Sondaggi con share piu' alto di tutti quelli del programma P22"
-- DIFETTO: P22 non ha nessun sondaggio, quindi la sottoquery e' vuota.
-- "share > ALL (insieme vuoto)" e' VERO per ogni riga (quantificazione
-- universale su un insieme vuoto): la query restituisce TUTTI i sondaggi,
-- mentre non ha senso dire che sono "piu' alti" di sondaggi che non esistono.

-- QUERY ORIGINALE (errore): restituisce tutte e 12 le righe di sondaggi
/*SELECT cod_programma, data_rilevazione, share
FROM sondaggi
WHERE share > ALL (SELECT share FROM sondaggi WHERE cod_programma = 'P22');*/

-- CORREZIONE: confronto con MAX. 
SELECT cod_programma, data_rilevazione, share
FROM sondaggi
WHERE share > (SELECT MAX(share) FROM sondaggi WHERE cod_programma = 'P22');


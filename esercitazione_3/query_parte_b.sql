USE palinsesto;

-- 1
-- Artisti che partecipano a programmi di tipologia Quiz o Musicale.
-- Un artista compare una volta per ogni programma in cui lavora
SELECT a.nome_artista, p.codice, p.nome AS programma
FROM artisti a
JOIN programmi p ON p.codice = a.cod_programma
WHERE p.tipologia IN ('Quiz', 'Musicale');


-- 2 
-- Codici dei programmi che compaiono o in artisti o in sondaggi
SELECT cod_programma FROM artisti
UNION
SELECT cod_programma FROM sondaggi;


-- 3 
-- Quali artisti lavorano sia per Rete1 sia per Canale9? 
SELECT DISTINCT a.nome_artista
FROM artisti a
JOIN programmi p ON p.codice = a.cod_programma
WHERE p.rete = "Rete1" 
AND EXISTS
    (SELECT * 
    FROM artisti a2 
    JOIN programmi p2 ON p2.codice = a2.cod_programma
    WHERE p2.rete = "Canale9"
        AND a2.nome_artista = a.nome_artista);



-- 4 
-- Quali artisti lavorano per Rete1 ma non per Canale9? 
SELECT DISTINCT a.nome_artista
FROM artisti a
JOIN programmi p ON p.codice = a.cod_programma
WHERE p.rete = "Rete1" 
AND NOT EXISTS
    (SELECT * 
    FROM artisti a2 
    JOIN programmi p2 ON p2.codice = a2.cod_programma
    WHERE p2.rete = "Canale9"
        AND a2.nome_artista = a.nome_artista);


-- 5 
--  Quali programmi non hanno nessun sondaggio?
SELECT * 
FROM programmi p
WHERE NOT EXISTS (SELECT * FROM sondaggi s WHERE s.cod_programma = p.codice);


-- 6
-- Programmi con almeno due artisti.
SELECT p.nome, p.codice, COUNT(*) AS numero_artisti
FROM programmi p
JOIN artisti a ON a.cod_programma = p.codice
GROUP BY p.nome, p.codice
HAVING COUNT(*) >= 2;


-- 7 
-- Sondaggi con share piu' alto di TUTTI i sondaggi di P03.
SELECT *
FROM sondaggi
WHERE share > ALL (SELECT share FROM sondaggi WHERE cod_programma = "P03");


-- 8 
-- Sondaggio con piu' spettatori (nome programma + data); a parimerito li mostra tutti.
SELECT p.nome, s.data_rilevazione, s.spettatori
FROM sondaggi s
JOIN programmi p ON p.codice = s.cod_programma
WHERE s.spettatori = (SELECT MAX(spettatori) FROM sondaggi);


-- 9
-- Artisti che lavorano in TUTTI i programmi di Rete1 (divisione).
SELECT DISTINCT a.nome_artista
FROM artisti a
WHERE NOT EXISTS (SELECT * FROM programmi p WHERE p.rete = "Rete1" 
                    AND NOT EXISTS
                        (SELECT * FROM artisti a2 WHERE a2.nome_artista = a.nome_artista
                            AND a2.cod_programma = p.codice));



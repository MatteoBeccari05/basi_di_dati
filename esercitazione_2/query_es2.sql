-- 1. Nome degli studenti del corso di laurea CS
SELECT nome 
FROM studente 
WHERE Corso_laurea = 'CS';


-- 2. Nome degli insegnamenti tenuti dal docente King tra il 2004 e il 2005
SELECT DISTINCT insegnamento.nome_insegnamento 
FROM insegnamento 
JOIN modulo ON insegnamento.codice_insegnamento = modulo.codice_insegnamento 
WHERE modulo.docente = 'King' 
AND modulo.anno BETWEEN 2004 AND 2005;


-- 3. Per ogni modulo di King: codice insegnamento, semestre, anno e numero di studenti con un voto registrato 
SELECT m.codice_insegnamento, m.semestre, m.anno, COUNT(v.numero_studente) AS Numero_studenti
FROM modulo m 
JOIN votazione v ON m.identificatore_modulo = v.identificatore_modulo 
WHERE m.docente = 'King' 
GROUP BY m.identificatore_modulo, m.codice_insegnamento, m.semestre, m.anno;


-- 4. Carriera degli studenti CS in ordine cronologico
-- (Per ordinare Primavera prima di Autunno, basta usare "semestre DESC" perché P viene dopo A nell'alfabeto)
SELECT studente.nome, insegnamento.nome_insegnamento, modulo.semestre, modulo.anno, votazione.voto 
FROM studente 
JOIN votazione ON studente.numero_studente = votazione.numero_studente 
JOIN modulo ON votazione.identificatore_modulo = modulo.identificatore_modulo 
JOIN insegnamento ON modulo.codice_insegnamento = insegnamento.codice_insegnamento 
WHERE studente.Corso_laurea = 'CS' 
ORDER BY modulo.anno ASC, modulo.semestre DESC;


-- 5. Propedeuticità dirette e di secondo livello di Basi di dati (CS3380)
-- (La prima SELECT prende quelle dirette, la UNION unisce i risultati della seconda SELECT per il secondo livello)
SELECT codice_propedeuticita 
FROM propedeuticita 
WHERE codice_insegnamento = 'CS3380'
UNION
SELECT p2.codice_propedeuticita 
FROM propedeuticita p1 
JOIN propedeuticita p2 ON p1.codice_propedeuticita = p2.codice_insegnamento 
WHERE p1.codice_insegnamento = 'CS3380';



-- 6. Media dei voti degli studenti convertendo le lettere in numeri
SELECT numero_studente, 
       AVG(CASE voto 
           WHEN 'A' THEN 4 
           WHEN 'B' THEN 3 
           WHEN 'C' THEN 2 
           WHEN 'D' THEN 1 
           WHEN 'F' THEN 0 
       END) AS media
FROM votazione 
GROUP BY numero_studente;


-- 7. Insegnamenti che nessuno studente ha ancora sostenuto
-- (Seleziona l'insegnamento se NON ESISTE una riga corrispondente tra i voti registrati)
SELECT nome_insegnamento 
FROM insegnamento 
WHERE NOT EXISTS (
    SELECT * 
    FROM modulo 
    JOIN votazione ON modulo.identificatore_modulo = votazione.identificatore_modulo 
    WHERE modulo.codice_insegnamento = insegnamento.codice_insegnamento
);

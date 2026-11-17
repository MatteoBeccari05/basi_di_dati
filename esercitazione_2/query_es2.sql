USE universita;

-- 1 Nome degli studenti del corso di laurea CS
SELECT nome
FROM studente
WHERE corso_laurea = "CS";


-- 2 Codice e nome degli insegnamenti del dipartimento CS con almeno 4 ore
SELECT codice_insegnamento, nome_insegnamento
FROM insegnamento
WHERE dipartimento = "CS" AND ore >= 4;


-- 3 Elenco dei docenti che hanno tenuto almeno un modulo, senza ripetizioni.
SELECT DISTINCT docente
FROM modulo;


-- 4 Nome degli insegnamenti tenuti dal docente ‘King’ tra il 2004 e il 2005
SELECT DISTINCT i.nome_insegnamento
FROM insegnamento i
JOIN modulo m ON i.codice_insegnamento = m.codice_insegnamento
WHERE m.docente = "KING" AND m.anno BETWEEN 2004 AND 2005;


-- 5 Per ogni voto registrato in un modulo di King: codice insegnamento, semestre, anno, nome dello studente e voto
SELECT m.codice_insegnamento, m.semestre, m.anno, s.nome, v.voto
FROM modulo m
JOIN votazione v ON m.identificatore_modulo = v.identificatore_modulo
JOIN studente s ON v.numero_studente = s.numero_studente
WHERE m.docente = 'KING';


-- 6 Insegnamenti con almeno un voto registrato
SELECT DISTINCT i.codice_insegnamento, i.nome_insegnamento
FROM insegnamento i
JOIN modulo m ON i.codice_insegnamento = m.codice_insegnamento
JOIN votazione v ON m.identificatore_modulo = v.identificatore_modulo;


-- 7 Carriera degli studenti CS: nome studente, nome e codice dell’insegnamento, semestre, anno, voto
SELECT s.nome, i.nome_insegnamento, i.codice_insegnamento, m.semestre, m.anno, v.voto
FROM studente s
JOIN votazione v ON s.numero_studente = v.numero_studente
JOIN modulo m ON v.identificatore_modulo = m.identificatore_modulo
JOIN insegnamento i ON m.codice_insegnamento = i.codice_insegnamento
WHERE s.corso_laurea = 'CS';


-- 8 Coppie di moduli dello stesso insegnamento, ogni coppia una sola volta: 
-- codice insegnamento, identificatore modulo 1, identificatore modulo 2, docente 1, docente 2
SELECT
    m1.codice_insegnamento,
    m1.identificatore_modulo AS mod1,
    m2.identificatore_modulo AS mod2,
    m1.docente AS docente1,
    m2.docente AS docente2
FROM modulo m1
JOIN modulo m2 ON m1.codice_insegnamento = m2.codice_insegnamento
WHERE m1.identificatore_modulo < m2.identificatore_modulo;


-- 9 Propedeuticità di secondo livello di ‘CS3380’: 
-- insegnamento intermedio, codice e nome della propedeuticità di secondo livello
SELECT p1.codice_propedeuticita AS intermedio, 
       p2.codice_propedeuticita AS codice_propedeuticita, 
       i.nome_insegnamento AS nome_propedeuticita
FROM propedeuticita p1
JOIN propedeuticita p2 ON p1.codice_propedeuticita = p2.codice_insegnamento
JOIN insegnamento i ON p2.codice_propedeuticita = i.codice_insegnamento
WHERE p1.codice_insegnamento = 'CS3380';

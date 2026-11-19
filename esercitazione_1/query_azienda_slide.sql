USE Azienda;

-- Q2
-- Trova nome, cognome e indirizzo di tutti i dipendenti che lavorano per il dipartimento Ricerca.
SELECT Nome, Cognome, Indirizzo
FROM DIPENDENTE, DIPARTIMENTO
WHERE Nome_dip = 'Research' AND Numero_dip = N_dip;

-- Q3
-- Per ogni progetto che si svolge a Ferrara, elenca numero del progetto, numero del
-- dipartimento che lo controlla e cognome, indirizzo e data di nascita del direttore.
SELECT Numero_progetto, PROGETTO.Numero_dip, Cognome, DataNascita, Indirizzo
FROM PROGETTO, DIPARTIMENTO, DIPENDENTE
WHERE PROGETTO.Numero_dip = DIPARTIMENTO.Numero_dip
AND CF_direttore = CodiceFiscale AND Luogo = 'Stafford';


-- Q4
-- Per ogni dipendente, trova il suo nome e il nome del suo supervisore diretto.  (ALIAS)
SELECT D.Nome, D.Cognome, S.Nome, S.Cognome
FROM DIPENDENTE AS D, DIPENDENTE AS S
WHERE D.CF_supervisore = S.CodiceFiscale;


-- Q5
-- Trova le coppie di dipendenti che lavorano nello stesso dipartimento.
SELECT D1.Cognome, D2.Cognome
FROM DIPENDENTE AS D1, DIPENDENTE AS D2
WHERE D1.N_dip = D2.N_dip
AND D1.CodiceFiscale < D2.CodiceFiscale;


-- Q6
-- Trova il codice fiscale di tutti i dipendenti.
SELECT CodiceFiscale
FROM DIPENDENTE;

-- Q7
-- Due tabelle nella FROM e nessuna condizione di join.
SELECT CodiceFiscale, Nome_dip
FROM DIPENDENTE, DIPARTIMENTO;


-- Q8a
-- Tutti gli attributi dei dipendenti del dipartimento 5.
SELECT *
FROM DIPENDENTE WHERE N_dip = 5;


-- Q8b
-- Tutti gli attributi delle due tabelle unite dal join.
SELECT *
FROM DIPENDENTE, DIPARTIMENTO
WHERE Nome_dip = 'Research' AND N_dip = Numero_dip;


-- Q9 con i duplicati
SELECT Stipendio
FROM DIPENDENTE;


-- Q9a senza duplicati
SELECT DISTINCT Stipendio
FROM DIPENDENTE;


-- Q10 
-- Elenca i nomi dei progetti che coinvolgono un dipendente di cognome Bianchi, come
-- lavoratore oppure come direttore del dipartimento che controlla il progetto.
(SELECT Nome_progetto
FROM PROGETTO, DIPARTIMENTO, DIPENDENTE
WHERE PROGETTO.Numero_dip = DIPARTIMENTO.Numero_dip
AND CF_direttore = CodiceFiscale AND Cognome = 'Wallace')
UNION
(SELECT Nome_progetto
FROM PROGETTO, LAVORA_SU, DIPENDENTE
WHERE PROGETTO.Numero_progetto = LAVORA_SU.Numero_progetto
AND CF_dipendente = CodiceFiscale AND Cognome = 'Wallace');


-- Q11 (UNION ALL)
-- I cognomi dei dipendenti del dipartimento 5 e di quelli che guadagnano più di 35.000.
SELECT Cognome FROM DIPENDENTE WHERE N_dip = 5
UNION ALL
SELECT Cognome FROM DIPENDENTE WHERE Stipendio > 35000;


-- Q2A (QUERY ANNIDATE)
SELECT Nome, Cognome, Indirizzo
FROM DIPENDENTE
WHERE N_dip IN (SELECT Numero_dip
FROM DIPARTIMENTO
WHERE Nome_dip = 'Research');


-- Q12 (ANY ED ALL)
-- Trova i dipendenti il cui stipendio supera quello di tutti i dipendenti del dipartimento 5.
SELECT Nome, Cognome
FROM DIPENDENTE
WHERE Stipendio > ALL (SELECT Stipendio
FROM DIPENDENTE
WHERE N_dip = 5);


-- Q13 (QUERY ANNIDATE E CORRELATE)
-- Trova il nome di ogni dipendente che ha un parente con il suo stesso nome di battesimo.
SELECT D.Nome, D.Cognome
FROM DIPENDENTE AS D
WHERE D.CodiceFiscale IN (SELECT CF_dipendente
FROM PARENTE
WHERE CF_dipendente = D.CodiceFiscale
AND D.Nome = Nome_parente);


-- Q13 SENZA ANNIDAMENTO
SELECT D.Nome, D.Cognome
FROM DIPENDENTE AS D, PARENTE AS P
WHERE D.CodiceFiscale = P.CF_dipendente AND D.Nome = P.Nome_parente;


-- Q14 (CONTAINS)
-- Trova il nome di ogni dipendente che lavora su tutti i progetti controllati dal dipartimento numero 5.
/*SELECT Nome, Cognome
FROM DIPENDENTE
WHERE ( (SELECT Numero_progetto FROM LAVORA_SU
WHERE CF_dipendente = CodiceFiscale)
CONTAINS
(SELECT Numero_progetto FROM PROGETTO
WHERE Numero_dip = 5) );*/


-- Q13b (EXISTS)
-- La Q13 di prima, scritta con EXISTS
SELECT Nome, Cognome
FROM DIPENDENTE
WHERE EXISTS (SELECT *
FROM PARENTE
WHERE CodiceFiscale = CF_dipendente
AND Nome = Nome_parente);


-- Q15 (NOT EXISTS)
-- Trova i nomi dei dipendenti che non hanno parenti a carico.
SELECT Nome, Cognome
FROM DIPENDENTE
WHERE NOT EXISTS (SELECT *
FROM PARENTE
WHERE CodiceFiscale = CF_dipendente);


-- Q16 (INSIEMI ESPLICITI)
-- Trova i codici fiscali dei dipendenti che lavorano sui progetti numero 1, 2 oppure 3.
SELECT DISTINCT CF_dipendente
FROM LAVORA_SU
WHERE Numero_progetto IN (1, 2, 3);


-- Q17 (NULL)
-- Trova i nomi dei dipendenti che non hanno un supervisore.
SELECT Nome, Cognome
FROM DIPENDENTE
WHERE CF_supervisore IS NULL;


-- Q18 (NOT IN)
-- Trova i dipendenti che non sono supervisori di nessuno.
SELECT Cognome
FROM DIPENDENTE
WHERE CodiceFiscale NOT IN (SELECT CF_supervisore FROM DIPENDENTE);


-- Q18a
-- La stessa domanda con NOT EXISTS.
SELECT Cognome
FROM DIPENDENTE AS D
WHERE NOT EXISTS (SELECT * FROM DIPENDENTE AS S
WHERE S.CF_supervisore = D.CodiceFiscale);


-- Q19 (JOIN ESTERNO)
-- Tutti i dipartimenti, con i progetti che si svolgono a Ferrara, se ne hanno.
SELECT D.Nome_dip, P.Nome_progetto
FROM DIPARTIMENTO AS D
LEFT JOIN PROGETTO AS P
ON P.Numero_dip = D.Numero_dip
WHERE P.Luogo = 'Ferrara';


-- Q19a (JOIN ESTERNO)
-- Tutti i dipartimenti, con i progetti che si svolgono a Ferrara, se ne hanno.
SELECT D.Nome_dip, P.Nome_progetto
FROM DIPARTIMENTO AS D
LEFT JOIN PROGETTO AS P
ON P.Numero_dip = D.Numero_dip
AND P.Luogo = 'Ferrara';


-- Q20 (FUNZIONI DI AGGREGAZIONE)
-- Trova lo stipendio massimo, quello minimo e quello medio fra tutti i dipendenti.
SELECT MAX(Stipendio), MIN(Stipendio), AVG(Stipendio)
FROM DIPENDENTE;


-- Q21 (AGGREGARE UN SOTTOINSIEME)
-- Stipendio massimo, minimo e medio dei soli dipendenti del dipartimento Ricerca
SELECT MAX(Stipendio), MIN(Stipendio), AVG(Stipendio)
FROM DIPENDENTE, DIPARTIMENTO
WHERE N_dip = Numero_dip AND Nome_dip = 'Research';


-- Q22 (AGGREGARE UN SOTTOINSIEME)
-- Numero totale di dipendenti dell’azienda.
SELECT COUNT(*) FROM DIPENDENTE;


-- Q23 (AGGREGARE UN SOTTOINSIEME)
-- Numero di dipendenti del dipartimento Ricerca.
SELECT COUNT(*)
FROM DIPENDENTE, DIPARTIMENTO
WHERE N_dip = Numero_dip AND Nome_dip = 'Research';


-- Q24 (COUNT, DISTINCT E NULL)
-- Contare righe, valori presenti e valori distinti.
SELECT COUNT(*), COUNT(CF_supervisore),
COUNT(DISTINCT CF_supervisore), COUNT(DISTINCT N_dip)
FROM DIPENDENTE;


-- Q25 (GROUP BY)
-- Per ogni dipartimento, il numero del dipartimento, quanti dipendenti ha e il loro stipendio medio.
SELECT N_dip, COUNT(*), AVG(Stipendio)
FROM DIPENDENTE
GROUP BY N_dip;


-- Q26 (GROUP BY)
-- Per ogni progetto, numero, nome e quanti dipendenti ci lavorano.
SELECT PROGETTO.Numero_progetto, Nome_progetto, COUNT(*)
FROM PROGETTO, LAVORA_SU
WHERE PROGETTO.Numero_progetto = LAVORA_SU.Numero_progetto
GROUP BY PROGETTO.Numero_progetto, Nome_progetto;


-- Q27 (CONTARE ANCHE GLI ZERI)
-- Join interno: Amministrazione non compare.
SELECT D.Nome_dip, COUNT(*)
FROM DIPARTIMENTO AS D JOIN PROGETTO AS P ON P.Numero_dip = D.Numero_dip
GROUP BY D.Numero_dip, D.Nome_dip;


-- Q27a (CONTARE ANCHE GLI ZERI)
-- Join esterno con COUNT(*): Amministrazione compare, ma con 1.
SELECT D.Nome_dip, COUNT(*)
FROM DIPARTIMENTO AS D LEFT JOIN PROGETTO AS P ON P.Numero_dip = D.Numero_dip
GROUP BY D.Numero_dip, D.Nome_dip;


-- Q27b (CONTARE ANCHE GLI ZERI)
-- Join esterno con COUNT(P.Numero_progetto): Amministrazione 0, Direzione 1, Ricerca 2.
SELECT D.Nome_dip, COUNT(P.Numero_progetto)
FROM DIPARTIMENTO AS D LEFT JOIN PROGETTO AS P ON P.Numero_dip = D.Numero_dip
GROUP BY D.Numero_dip, D.Nome_dip;


-- Q28 (ATTRIBUTI FUORI DAL GROUP BY)
-- Un’interrogazione sbagliata: Cognome non è un attributo di raggruppamento.
/*SELECT N_dip, Cognome, COUNT(*)
FROM DIPENDENTE
GROUP BY N_dip;*/


-- Q29 (HAVING)
-- Per ogni progetto su cui lavorano più di due dipendenti, numero, nome e quanti ci lavorano.
SELECT PROGETTO.Numero_progetto, Nome_progetto, COUNT(*)
FROM PROGETTO, LAVORA_SU
WHERE PROGETTO.Numero_progetto = LAVORA_SU.Numero_progetto
GROUP BY PROGETTO.Numero_progetto, Nome_progetto
HAVING COUNT(*) > 2;


-- Q30 (LIKE)
-- Trova tutti i dipendenti che abitano a Ferrara.
SELECT Nome, Cognome
FROM DIPENDENTE
WHERE Indirizzo LIKE '%Ferrara%';


-- Q31 (LIKE)
-- Trova tutti i dipendenti nati negli anni Cinquanta.
SELECT Nome, Cognome
FROM DIPENDENTE
WHERE DataNascita LIKE '195_-__-__';


-- Q32 (BETWEEN)
-- Trova i dipendenti del dipartimento 5 con stipendio tra 30.000 e 40.000.
SELECT *
FROM DIPENDENTE
WHERE (Stipendio BETWEEN 30000 AND 40000) AND N_dip = 5;


-- Q33 (DATETIME)
-- Gli accessi di marzo 2026, scritti con BETWEEN.
/*SELECT * FROM ACCESSO
WHERE Ingresso BETWEEN '2026-03-01' AND '2026-03-31';*/


-- Q34 (OPERAZIONI ARITMETICHE)
-- Mostra l’effetto di un aumento del 10% per tutti i dipendenti che lavorano al progetto ProdottoX.
SELECT Nome, Cognome, 1.1 * Stipendio AS Stipendio_aumentato
FROM DIPENDENTE, LAVORA_SU, PROGETTO
WHERE CodiceFiscale = CF_dipendente
AND LAVORA_SU.Numero_progetto = PROGETTO.Numero_progetto
AND Nome_progetto = 'ProdottoX';


-- Q35 (CASE)
-- Classifica gli stipendi in tre fasce.
SELECT Cognome, Stipendio,
CASE WHEN Stipendio < 30000 THEN 'bassa'
WHEN Stipendio < 50000 THEN 'media'
ELSE 'alta'
END AS Fascia
FROM DIPENDENTE;


-- Q36 (CASE)
-- Per ogni dipartimento, quanti dipendenti guadagnano almeno 30.000
SELECT N_dip, COUNT(*) AS Totale,
SUM(CASE WHEN Stipendio >= 30000 THEN 1 ELSE 0 END) AS Da_30000
FROM DIPENDENTE
GROUP BY N_dip;


-- Q37 (ORDER BY)
-- Elenca i dipendenti e i progetti su cui lavorano, ordinati per dipartimento e, all’interno, per cognome.
SELECT Nome_dip, Cognome, Nome, Nome_progetto
FROM DIPARTIMENTO, DIPENDENTE, LAVORA_SU, PROGETTO
WHERE Numero_dip = N_dip AND CodiceFiscale = CF_dipendente
AND LAVORA_SU.Numero_progetto = PROGETTO.Numero_progetto
ORDER BY Nome_dip, Cognome;


-- Q38 (LIMIT)
-- I tre dipendenti con lo stipendio più alto.
SELECT Cognome, Stipendio
FROM DIPENDENTE
ORDER BY Stipendio DESC
LIMIT 3;


-- Q39 (MASSIMO, PARITA' COMPRESE)
-- Trova il dipendente, o i dipendenti, con lo stipendio più alto.
SELECT Nome, Cognome, Stipendio
FROM DIPENDENTE
WHERE Stipendio = (SELECT MAX(Stipendio) FROM DIPENDENTE);


-- Q40 (MASSIMO, PARITA' COMPRESE)
-- Trova il dipartimento, o i dipartimenti, con più dipendenti.
SELECT N_dip, COUNT(*)
FROM DIPENDENTE
GROUP BY N_dip
HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM DIPENDENTE GROUP BY N_dip);


-- Q41 (SOTTOINTERROGAZIONI NELLA FROM)
-- Quanti dipendenti ha in media un dipartimento?
SELECT AVG(Num) AS Media_dipendenti
FROM (SELECT N_dip, COUNT(*) AS Num FROM DIPENDENTE GROUP BY N_dip) AS T;


-- Q42 (WITH)
-- Per i dipartimenti con più di un dipendente, quanti guadagnano più di 25.000.
WITH DIP_GRANDI AS (SELECT N_dip
 FROM DIPENDENTE
GROUP BY N_dip
HAVING COUNT(*) > 1)
SELECT N_dip, COUNT(*)
FROM DIPENDENTE
WHERE Stipendio > 25000
 AND N_dip IN (SELECT N_dip FROM DIP_GRANDI)
GROUP BY N_dip;


-- Q43 (CONFRONTO CON IL PROPRIO GRUPPO)
-- Trova i dipendenti che guadagnano più della media del proprio dipartimento.
SELECT D.Cognome, D.N_dip, D.Stipendio
FROM DIPENDENTE AS D
WHERE D.Stipendio > (SELECT AVG(D2.Stipendio)
 FROM DIPENDENTE AS D2
WHERE D2.N_dip = D.N_dip);


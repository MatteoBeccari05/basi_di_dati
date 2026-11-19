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


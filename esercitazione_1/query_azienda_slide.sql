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

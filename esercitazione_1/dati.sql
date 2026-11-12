USE azienda;

-- Disabilitiamo temporaneamente i controlli sulle chiavi esterne per facilitare l'inserimento 
-- in presenza di dipendenze incrociate (es. Direttore del Dipartimento e Dipartimento del Dipendente).
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------
-- 1. Inserimento Dipartimenti
-- --------------------------------------------------------
INSERT INTO Dipartimento (Nome_dip, Numero_dip, CF_Direttore, Data_inizio) VALUES
('Direzione', 1, 'RSSMRA80A01H501U', '2010-01-01'),
('Ricerca e Sviluppo', 2, 'VRDLGU75B12H501Z', '2015-06-15'),
('Amministrazione', 3, 'BNCLRA85C45F205W', '2012-03-10'),
('Produzione', 4, 'NREGVN70D20L219Y', '2010-01-01'),
('Marketing', 5, 'FRRLNZ90E14H501J', '2018-09-01');

-- --------------------------------------------------------
-- 2. Inserimento Dipendenti
-- Nota: I CF sono stringhe di 16 caratteri di fantasia
-- --------------------------------------------------------
INSERT INTO Dipendente (Nome, Cognome, Codice_fiscale, Data_nascita, Indirizzo, Sesso, Stipendio, N_Dip, CF_Supervisore) VALUES
-- Direttori (Supervisore = NULL per il CEO, gli altri rispondono al CEO)
('Mario', 'Rossi', 'RSSMRA80A01H501U', '1980-01-01', 'Via Roma 1, Milano', 'M', 5500.00, 1, NULL),
('Luigi', 'Verdi', 'VRDLGU75B12H501Z', '1975-02-12', 'Via Milano 2, Roma', 'M', 4500.00, 2, 'RSSMRA80A01H501U'),
('Clara', 'Bianchi', 'BNCLRA85C45F205W', '1985-03-15', 'Piazza Napoli 3, Torino', 'F', 4000.00, 3, 'RSSMRA80A01H501U'),
('Giovanni', 'Neri', 'NREGVN70D20L219Y', '1970-04-20', 'Via Torino 4, Napoli', 'M', 4200.00, 4, 'RSSMRA80A01H501U'),
('Lorenzo', 'Ferrari', 'FRRLNZ90E14H501J', '1990-05-14', 'Viale Venezia 5, Bologna', 'M', 3800.00, 5, 'RSSMRA80A01H501U'),

-- Dipendenti normali (Rispondono ai rispettivi direttori di dipartimento)
('Giulia', 'Russo', 'RSSGLI92H50L219K', '1992-08-20', 'Via Firenze 10, Roma', 'F', 2500.00, 2, 'VRDLGU75B12H501Z'),
('Marco', 'Esposito', 'SPSMRC88M12F839X', '1988-12-12', 'Viale dei Pini 55, Napoli', 'M', 2800.00, 2, 'VRDLGU75B12H501Z'),
('Sara', 'Romano', 'RMNSRA95A41H501Q', '1995-01-01', 'Via Garibaldi 12, Milano', 'F', 2400.00, 3, 'BNCLRA85C45F205W'),
('Antonio', 'Colombo', 'CLBNTN82C05L219A', '1982-03-05', 'Piazza Dante 9, Napoli', 'M', 3200.00, 4, 'NREGVN70D20L219Y'),
('Elena', 'Ricci', 'RCCLNE94E55H501B', '1994-05-15', 'Via Verdi 8, Bologna', 'F', 2600.00, 5, 'FRRLNZ90E14H501J'),
('Luca', 'Gallo', 'GLLLCA91L23F205P', '1991-07-23', 'Corso Francia 4, Torino', 'M', 2700.00, 4, 'NREGVN70D20L219Y'),
('Chiara', 'Costa', 'CSTCHR96M60H501C', '1996-08-20', 'Via Vespucci 2, Milano', 'F', 2200.00, 3, 'BNCLRA85C45F205W');

-- --------------------------------------------------------
-- 3. Inserimento Sedi Dipartimento
-- --------------------------------------------------------
INSERT INTO Sedi_dipartimento (Numero_dip, Sede) VALUES
(1, 'Milano'),
(2, 'Roma'),
(2, 'Bologna'),
(3, 'Torino'),
(4, 'Napoli'),
(4, 'Bari'),
(5, 'Milano');

-- --------------------------------------------------------
-- 4. Inserimento Progetti
-- --------------------------------------------------------
INSERT INTO Progetto (Nome_progetto, Numero_progetto, Luogo, Numero_dip) VALUES
('Progetto Alfa', 10, 'Roma', 2),
('Innovazione AI', 20, 'Bologna', 2),
('Gestione Finanziaria 2.0', 30, 'Torino', 3),
('Automazione Linea A', 40, 'Napoli', 4),
('Campagna Estiva', 50, 'Milano', 5),
('Riorganizzazione', 60, 'Milano', 1);

-- --------------------------------------------------------
-- 5. Inserimento Lavora_su
-- --------------------------------------------------------
INSERT INTO Lavora_su (CF_Dipendente, Numero_progetto, Ore) VALUES
('RSSGLI92H50L219K', 10, 20.5),
('RSSGLI92H50L219K', 20, 15.0),
('SPSMRC88M12F839X', 10, 40.0),
('RMNSRA95A41H501Q', 30, 35.5),
('CLBNTN82C05L219A', 40, 40.0),
('RCCLNE94E55H501B', 50, 30.0),
('GLLLCA91L23F205P', 40, 38.5),
('CSTCHR96M60H501C', 30, 25.0),
('VRDLGU75B12H501Z', 20, 10.0), -- Il direttore lavora anche al progetto
('RSSMRA80A01H501U', 60, 15.5);

-- --------------------------------------------------------
-- 6. Inserimento Parente
-- --------------------------------------------------------
INSERT INTO Parente (CF_Dipendente, Nome_parente, Sesso, DataNascita, Relazione) VALUES
('RSSMRA80A01H501U', 'Anna Bianchi', 'F', '1982-10-05', 'Coniuge'),
('RSSMRA80A01H501U', 'Paolo Rossi', 'M', '2010-05-12', 'Figlio'),
('VRDLGU75B12H501Z', 'Marta Verdi', 'F', '2008-11-20', 'Figlia'),
('BNCLRA85C45F205W', 'Roberto Gialli', 'M', '1980-02-15', 'Coniuge'),
('SPSMRC88M12F839X', 'Carmela Esposito', 'F', '1960-08-30', 'Madre'),
('CLBNTN82C05L219A', 'Sofia Colombo', 'F', '2015-04-18', 'Figlia');

-- Riabilitiamo i controlli sulle chiavi esterne
SET FOREIGN_KEY_CHECKS = 1;

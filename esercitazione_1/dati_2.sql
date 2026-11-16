USE Azienda;

-- Pulizia eventuale record di prova inserito nello script precedente
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM DIPARTIMENTO WHERE Numero_dip = 1 AND CF_direttore = 'RSSMRA70A01D548X';
DELETE FROM DIPENDENTE WHERE CodiceFiscale = 'RSSMRA70A01D548X';

-- 1. Inserimento DIPENDENTE (Ssn adattati a 16 caratteri per rispettare chk_cf)
INSERT INTO DIPENDENTE (Nome, Cognome, CodiceFiscale, DataNascita, Indirizzo, Sesso, Stipendio, CF_supervisore, N_dip) VALUES
('James',    'Borg',    '0000000888665555', '1937-11-10', '450 Stone, Houston, TX',    'M', 55000.00, NULL,               1),
('Franklin', 'Wong',    '0000000333445555', '1955-12-08', '638 Voss, Houston, TX',     'M', 40000.00, '0000000888665555', 5),
('Jennifer', 'Wallace', '0000000987654321', '1941-06-20', '291 Berry, Bellaire, TX',   'F', 43000.00, '0000000888665555', 4),
('John',     'Smith',   '0000000123456789', '1965-01-09', '731 Fondren, Houston, TX',  'M', 30000.00, '0000000333445555', 5),
('Alicia',   'Zelaya',  '0000000999887777', '1968-01-19', '3321 Castle, Spring, TX',   'F', 25000.00, '0000000987654321', 4),
('Ramesh',   'Narayan', '0000000666884444', '1962-09-15', '975 Fire Oak, Humble, TX',  'M', 38000.00, '0000000333445555', 5),
('Joyce',    'English', '0000000453453453', '1972-07-31', '5631 Rice, Houston, TX',    'F', 25000.00, '0000000333445555', 5),
('Ahmad',    'Jabbar',  '0000000987987987', '1969-03-29', '980 Dallas, Houston, TX',   'M', 25000.00, '0000000987654321', 4);

-- 2. Inserimento DIPARTIMENTO
INSERT INTO DIPARTIMENTO (Nome_dip, Numero_dip, CF_direttore, Data_inizio) VALUES
('Research',       5, '0000000333445555', '1988-05-22'),
('Administration', 4, '0000000987654321', '1995-01-01'),
('Headquarters',   1, '0000000888665555', '1981-06-19');

-- Riattivazione dei vincoli di integrità referenziale
SET FOREIGN_KEY_CHECKS = 1;

-- 3. Inserimento SEDI_DIPARTIMENTO
INSERT INTO SEDI_DIPARTIMENTO (Numero_dip, Sede) VALUES
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

-- 4. Inserimento PROGETTO
INSERT INTO PROGETTO (Nome_progetto, Numero_progetto, Luogo, Numero_dip) VALUES
('ProductX',        1,  'Bellaire',  5),
('ProductY',        2,  'Sugarland', 5),
('ProductZ',        3,  'Houston',   5),
('Computerization', 10, 'Stafford',  4),
('Reorganization',  20, 'Houston',   1),
('Newbenefits',     30, 'Stafford',  4);

-- 5. Inserimento LAVORA_SU
INSERT INTO LAVORA_SU (CF_dipendente, Numero_progetto, Ore) VALUES
('0000000123456789', 1,  32.5),
('0000000123456789', 2,  7.5),
('0000000666884444', 3,  40.0),
('0000000453453453', 1,  20.0),
('0000000453453453', 2,  20.0),
('0000000333445555', 2,  10.0),
('0000000333445555', 3,  10.0),
('0000000333445555', 10, 10.0),
('0000000333445555', 20, 10.0),
('0000000999887777', 30, 30.0),
('0000000999887777', 10, 10.0),
('0000000987987987', 10, 35.0),
('0000000987987987', 30, 5.0),
('0000000987654321', 30, 20.0),
('0000000987654321', 20, 15.0),
('0000000888665555', 20, NULL);

-- 6. Inserimento PARENTE
INSERT INTO PARENTE (CF_dipendente, Nome_parente, Sesso, DataNascita, Relazione) VALUES
('0000000333445555', 'Alice',     'F', '1986-04-05', 'Daughter'),
('0000000333445555', 'Theodore',  'M', '1983-10-25', 'Son'),
('0000000333445555', 'Joy',       'F', '1958-05-03', 'Spouse'),
('0000000987654321', 'Abner',     'M', '1942-02-28', 'Spouse'),
('0000000123456789', 'Michael',   'M', '1988-01-04', 'Son'),
('0000000123456789', 'Alice',     'F', '1988-12-30', 'Daughter'),
('0000000123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');
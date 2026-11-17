-- Esercitazione 1 - Soluzione di riferimento
-- Schema AZIENDA della lezione 08 (slide 3), corrispondente allo schema COMPANY di Elmasri-Navathe, Fig. 5.5 e 5.7
DROP DATABASE IF EXISTS Azienda;
CREATE DATABASE Azienda CHARACTER SET utf8mb4;
USE Azienda;

-- CodiceFiscale e' CHAR(16): lunghezza fissa, contiene lettere, non si fanno calcoli.
-- CHAR non impone la lunghezza minima: serve il CHECK con CHAR_LENGTH (lezione 08, slide 14).
CREATE TABLE IF NOT EXISTS DIPENDENTE (
  Nome           VARCHAR(15)   NOT NULL,
  Minit          CHAR (1) NOT NULL,
  Cognome        VARCHAR(30)   NOT NULL,
  CodiceFiscale  CHAR(16) NOT NULL,
  DataNascita    DATE,
  Indirizzo      VARCHAR(60),
  Sesso          CHAR(1),
  Stipendio      DECIMAL(10,2),
  CF_supervisore CHAR(16),
  N_dip          INT           NOT NULL DEFAULT 1,
  CONSTRAINT pk_dipendente   PRIMARY KEY (CodiceFiscale),
  CONSTRAINT chk_cf          CHECK (CHAR_LENGTH(CodiceFiscale) = 9),
  CONSTRAINT chk_sesso       CHECK (Sesso IN ('M', 'F')),
  CONSTRAINT chk_stipendio   CHECK (Stipendio > 0),
  CONSTRAINT fk_supervisore  FOREIGN KEY (CF_supervisore) REFERENCES DIPENDENTE(CodiceFiscale)
      ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIPARTIMENTO (
  Nome_dip      VARCHAR(20) NOT NULL,
  Numero_dip    INT,
  CF_direttore  CHAR(16)    NOT NULL,
  Data_inizio   DATE,
  CONSTRAINT pk_dipartimento PRIMARY KEY (Numero_dip),
  CONSTRAINT uq_nome_dip     UNIQUE (Nome_dip),
  CONSTRAINT fk_direttore    FOREIGN KEY (CF_direttore) REFERENCES DIPENDENTE(CodiceFiscale)
      ON UPDATE CASCADE
);

-- Il riferimento circolare: la FK DIPENDENTE -> DIPARTIMENTO si aggiunge dopo (slide 16)
-- ALTER TABLE DIPENDENTE DROP CONSTRAINT fk_dip_dipartimento;
ALTER TABLE DIPENDENTE ADD CONSTRAINT fk_dip_dipartimento
  FOREIGN KEY (N_dip) REFERENCES DIPARTIMENTO(Numero_dip) ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS SEDI_DIPARTIMENTO (
  Numero_dip INT,
  Sede       VARCHAR(20),
  PRIMARY KEY (Numero_dip, Sede),
  FOREIGN KEY (Numero_dip) REFERENCES DIPARTIMENTO(Numero_dip) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS PROGETTO (
  Nome_progetto   VARCHAR(20) NOT NULL,
  Numero_progetto INT,
  Luogo           VARCHAR(20),
  Numero_dip      INT         NOT NULL,
  PRIMARY KEY (Numero_progetto),
  UNIQUE (Nome_progetto),
  FOREIGN KEY (Numero_dip) REFERENCES DIPARTIMENTO(Numero_dip) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS LAVORA_SU (
  CF_dipendente   CHAR(16),
  Numero_progetto INT,
  Ore             DECIMAL(3,1),
  PRIMARY KEY (CF_dipendente, Numero_progetto),
  CONSTRAINT chk_ore CHECK (Ore >= 0),
  FOREIGN KEY (CF_dipendente)   REFERENCES DIPENDENTE(CodiceFiscale) ON UPDATE CASCADE,
  FOREIGN KEY (Numero_progetto) REFERENCES PROGETTO(Numero_progetto) ON UPDATE CASCADE
);

-- ON DELETE CASCADE: un parente a carico non ha senso senza il dipendente
CREATE TABLE IF NOT EXISTS PARENTE (
  CF_dipendente CHAR(16),
  Nome_parente  VARCHAR(15),
  Sesso         CHAR(1),
  DataNascita   DATE,
  Relazione     VARCHAR(10),
  PRIMARY KEY (CF_dipendente, Nome_parente),
  CONSTRAINT chk_sesso_parente CHECK (Sesso IN ('M', 'F')),
  FOREIGN KEY (CF_dipendente) REFERENCES DIPENDENTE(CodiceFiscale) ON DELETE CASCADE ON UPDATE CASCADE
);

-- USE Azienda;

-- Disabilito temporaneamente i controlli di integrità referenziale, necessario altrimenti al runtime ci da errore di violazione di chiave
SET FOREIGN_KEY_CHECKS = 0;

-- Inserimento dati nella tabella DIPENDENTE
INSERT INTO DIPENDENTE VALUES 
('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000.00, '333445555', 5),
('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', 40000.00, '888665555', 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000.00, '987654321', 4),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000.00, '888665555', 4),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000.00, '333445555', 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000.00, '333445555', 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000.00, '987654321', 4),
('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000.00, NULL, 1);

-- Inserimento dati nella tabella DIPARTIMENTO
INSERT INTO DIPARTIMENTO VALUES 
('Research', 5, '333445555', '1988-05-22'),
('Administration', 4, '987654321', '1995-01-01'),
('Headquarters', 1, '888665555', '1981-06-19');

-- Inserimento dati nella tabella SEDI_DIPARTIMENTO
INSERT INTO SEDI_DIPARTIMENTO VALUES 
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

-- Inserimento dati nella tabella PROGETTO
INSERT INTO PROGETTO VALUES 
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

-- Inserimento dati nella tabella LAVORA_SU
INSERT INTO LAVORA_SU VALUES 
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, NULL);

-- Inserimento dati nella tabella PARENTE
INSERT INTO PARENTE VALUES 
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'),
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'),
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

-- Riabilito i controlli di integrità referenziale
SET FOREIGN_KEY_CHECKS = 1;
-- Modifiche fatte al codice visto in classe: aggiunto campo mnit, cambio del constraint sulla lunghezza da 16 a 9
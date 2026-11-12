-- Creazione e selezione del Database
CREATE DATABASE IF NOT EXISTS universita;
USE universita;

-- Creazione Tabelle e Vincoli
CREATE TABLE studente (
    nome VARCHAR(50),
    numero_studente INT PRIMARY KEY,
    anno_corso INT,
    Corso_laurea VARCHAR(10)
);

CREATE TABLE insegnamento (
    nome_insegnamento VARCHAR(100),
    codice_insegnamento VARCHAR(10) PRIMARY KEY,
    ore INT,
    dipartimento VARCHAR(10)
);

CREATE TABLE modulo (
    identificatore_modulo INT PRIMARY KEY,
    codice_insegnamento VARCHAR(10),
    semestre VARCHAR(20),
    anno INT,
    docente VARCHAR(50),
    FOREIGN KEY (codice_insegnamento) REFERENCES insegnamento(codice_insegnamento)
);

CREATE TABLE votazione (
    numero_studente INT,
    identificatore_modulo INT,
    voto VARCHAR(2),
    PRIMARY KEY (numero_studente, identificatore_modulo),
    FOREIGN KEY (numero_studente) REFERENCES studente(numero_studente),
    FOREIGN KEY (identificatore_modulo) REFERENCES modulo(identificatore_modulo)
);

CREATE TABLE propedeuticita (
    codice_insegnamento VARCHAR(10),
    codice_propedeuticita VARCHAR(10),
    PRIMARY KEY (codice_insegnamento, codice_propedeuticita),
    FOREIGN KEY (codice_insegnamento) REFERENCES insegnamento(codice_insegnamento),
    FOREIGN KEY (codice_propedeuticita) REFERENCES insegnamento(codice_insegnamento)
);

INSERT INTO studente (nome, numero_studente, anno_corso, Corso_laurea) VALUES 
('Smith', 17, 1, 'CS'), 
('Brown', 8, 2, 'CS');

INSERT INTO insegnamento (nome_insegnamento, codice_insegnamento, ore, dipartimento) VALUES 
('Introduzione all''informatica', 'CS1310', 4, 'CS'), 
('Struttura dei dati', 'CS3320', 4, 'CS'), 
('Matematica discreta', 'MATH2410', 3, 'MATH'), 
('Basi di dati', 'CS3380', 3, 'CS');

INSERT INTO modulo (identificatore_modulo, codice_insegnamento, semestre, anno, docente) VALUES 
(85, 'MATH2410', 'Autunno', 2004, 'King'), 
(92, 'CS1310', 'Autunno', 2004, 'Anderson'), 
(102, 'CS3320', 'Primavera', 2005, 'Knuth'), 
(112, 'MATH2410', 'Autunno', 2005, 'Chang'), 
(119, 'CS1310', 'Autunno', 2005, 'Anderson'), 
(135, 'CS3380', 'Autunno', 2005, 'Stone');

INSERT INTO votazione (numero_studente, identificatore_modulo, voto) VALUES 
(17, 112, 'B'), 
(17, 119, 'C'), 
(8, 85, 'A'), 
(8, 92, 'A'), 
(8, 102, 'B'), 
(8, 135, 'A');

INSERT INTO propedeuticita (codice_insegnamento, codice_propedeuticita) VALUES 
('CS3380', 'CS3320'), 
('CS3380', 'MATH2410'), 
('CS3320', 'CS1310');universitainsegnamento
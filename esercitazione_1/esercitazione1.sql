USE azienda;

CREATE TABLE IF NOT EXISTS Dipendente(
    Nome VARCHAR (15) NOT NULL,
    Cognome VARCHAR(15) NOT NULL,
    Codice_fiscale CHAR(16) NOT NULL,
    Data_nascita DATE NOT NULL, 
    Indirizzo VARCHAR(50) NOT NULL,
    Sesso CHAR(1),
    Stipendio DECIMAL(10,2),
    N_Dip INT DEFAULT 1,
    CF_Supervisore CHAR(16),

    CONSTRAINT pk_dipendente PRIMARY KEY (Codice_fiscale),
    CONSTRAINT fk_dipendente_supervisore FOREIGN KEY (CF_supervisore) REFERENCES Dipendente(Codice_fiscale) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT check_sesso_dipendente CHECK (Sesso IN ('M', 'F')),
    CONSTRAINT check_stipendio_positivo CHECK (Stipendio > 0)
);

CREATE TABLE IF NOT EXISTS Dipartimento(
    Nome_dip VARCHAR(50) NOT NULL,
    Numero_dip INT NOT NULL, 
    CF_Direttore CHAR(16),
    Data_inizio DATE, 

    CONSTRAINT pk_dipartimento PRIMARY KEY(Numero_Dip),
    CONSTRAINT nome_dipartimento UNIQUE (Nome_dip),
    CONSTRAINT fk_dipartimento_direttore FOREIGN KEY (CF_Direttore) REFERENCES Dipendente(Codice_fiscale) ON DELETE SET NULL ON UPDATE CASCADE

);

-- ALTER TABLE Dipendente
--     ADD CONSTRAINT fk_dipendente_dipartimento FOREIGN KEY (N_Dip) REFERENCES Dipartimento(Numero_dip) ON DELETE SET DEFAULT ON UPDATE CASCADE;
 
CREATE TABLE IF NOT EXISTS Sedi_dipartimento(
    Numero_dip INT NOT NULL,
    Sede VARCHAR(50) NOT NULL,

    CONSTRAINT pk_sede_dipartimento PRIMARY KEY (Numero_dip, Sede),
    CONSTRAINT fk_sede_dipartimento FOREIGN KEY(Numero_dip) REFERENCES Dipartimento(Numero_dip) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Progetto(
    Nome_progetto VARCHAR(50) NOT NULL,
    Numero_progetto INT NOT NULL,
    Luogo VARCHAR(50),
    Numero_dip INT NOT NULL,

    CONSTRAINT pk_progetto PRIMARY KEY (Numero_progetto),
    CONSTRAINT fk_lavora_su_dipendente FOREIGN KEY (Numero_dip) REFERENCES Dipartimento(Numero_dip) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Lavora_su(
    CF_Dipendente CHAR(16) NOT NULL,
    Numero_progetto INT NOT NULL,
    Ore DECIMAL(4,1),

    CONSTRAINT pk_lavora_su PRIMARY KEY (CF_dipendente, Numero_progetto),
    CONSTRAINT fk_lavora_su_dipendente2 FOREIGN KEY (CF_Dipendente) REFERENCES Dipendente(Codice_fiscale) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_lavora_su_progetto FOREIGN KEY (Numero_progetto) REFERENCES Progetto(Numero_progetto) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT check_ore CHECK (Ore >= 0)
);

CREATE TABLE IF NOT EXISTS Parente(
    CF_Dipendente CHAR(16) NOT NULL,
    Nome_parente VARCHAR(30) NOT NULL,
    Sesso CHAR(1),
    DataNascita DATE,
    Relazione VARCHAR(20),

    CONSTRAINT pk_parente PRIMARY KEY (CF_dipendente, Nome_parente),
    CONSTRAINT fk_parente_dipendente FOREIGN KEY (CF_Dipendente) REFERENCES Dipendente(Codice_fiscale) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT check_sesso_parente CHECK (Sesso IN('M', 'F'))
);

  
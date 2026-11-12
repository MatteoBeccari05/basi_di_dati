<div align="center">

# 🗄️ Basi di Dati

### Esercizi, query e appunti del corso di **Basi di Dati**
**Laurea Triennale in Informatica — Università degli Studi di Ferrara**

![SQL](https://img.shields.io/badge/SQL-Esercizi-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Unife](https://img.shields.io/badge/UNIFE-Informatica-B30000?style=for-the-badge)
![Status](https://img.shields.io/badge/Stato-in%20aggiornamento-brightgreen?style=for-the-badge)

</div>

---

## 📖 Descrizione

Questa repository raccoglie il materiale che produco durante il corso di **Basi di Dati**: esercizi svolti in **SQL**, soluzioni commentate e file di supporto per lo studio e la preparazione all'esame.

L'obiettivo è avere tutto in un unico posto, ordinato e facile da consultare, e magari essere utile anche a chi segue lo stesso corso.

## 🧠 Argomenti trattati

- 🔹 Modello relazionale e algebra relazionale
- 🔹 Progettazione concettuale (modello E/R) e logica
- 🔹 Linguaggio **SQL**: `SELECT`, `JOIN`, `GROUP BY`, `HAVING`, sottoquery
- 🔹 DDL e DML: `CREATE`, `ALTER`, `INSERT`, `UPDATE`, `DELETE`
- 🔹 Vincoli di integrità, chiavi primarie e chiavi esterne
- 🔹 Normalizzazione (1NF, 2NF, 3NF, BCNF)
- 🔹 Viste, indici, transazioni *(se presenti nel programma)*

> ✏️ Modifica questa lista in base al programma effettivo del corso.

## 📂 Struttura della repository

```text
basi_di_dati/
├── 📁 esercizi/
│   ├── 📁 lezione_01/
│   ├── 📁 lezione_02/
│   └── ...
├── 📁 esami/            # tracce e soluzioni delle prove precedenti
├── 📁 schemi/           # script di creazione database e dati di esempio
├── 📁 appunti/          # riassunti e schemi teorici
└── 📄 README.md
```

> 🚧 La struttura si aggiornerà man mano che inserisco nuovi file.

## 🚀 Come usare gli esercizi

1. **Clona la repository**
   ```bash
   git clone https://github.com/MatteoBeccari05/basi_di_dati.git
   cd basi_di_dati
   ```
2. **Installa un DBMS** (ad esempio [PostgreSQL](https://www.postgresql.org/), [MySQL](https://www.mysql.com/) o [SQLite](https://www.sqlite.org/))
3. **Crea il database** eseguendo lo script dello schema:
   ```bash
   psql -U <utente> -d <database> -f schemi/nome_schema.sql
   ```
4. **Esegui le query** dei singoli esercizi e confronta i risultati.

## 🛠️ Strumenti utilizzati

| Strumento | Utilizzo |
|-----------|----------|
| SQL | Linguaggio principale degli esercizi |
| PostgreSQL / MySQL / SQLite | DBMS per testare le query |
| Git & GitHub | Versionamento e condivisione |
| draw.io / dbdiagram.io | Schemi E/R e relazionali |

## 📝 Convenzioni

- Ogni esercizio è in un file `.sql` con nome descrittivo (es. `es01_selezione_base.sql`)
- Il testo dell'esercizio è riportato in un commento all'inizio del file
- Le query sono formattate e commentate per essere leggibili

Esempio:

```sql
-- Esercizio 1
-- Trovare nome e cognome degli studenti iscritti al corso di Basi di Dati.

SELECT s.nome, s.cognome
FROM studenti s
JOIN iscrizioni i ON i.matricola = s.matricola
JOIN corsi c ON c.id = i.id_corso
WHERE c.nome = 'Basi di Dati';
```

## ⚠️ Disclaimer

Le soluzioni sono frutto del mio studio personale e **possono contenere errori o non essere l'unica soluzione possibile**. Usale come spunto, non come verità assoluta. Se trovi un errore, sentiti libero di segnalarlo!

## 🤝 Contributi

Suggerimenti e correzioni sono ben accetti:

1. Fai un **fork** del progetto
2. Crea un branch (`git checkout -b fix/nome-correzione`)
3. Fai commit delle modifiche
4. Apri una **Pull Request**

## 👤 Autore

**Matteo Beccari**
🎓 Studente di Informatica @ Università di Ferrara
🔗 [GitHub](https://github.com/MatteoBeccari05)

---

<div align="center">

⭐ Se questa repo ti è stata utile, lascia una stella!

</div>

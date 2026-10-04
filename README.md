# MOBIQ-Datenbank

Die Unternehmensdatenbank des erfundenen ERP-Herstellers MOBIQ: PostgreSQL 18, 14 Tabellen, rund 3.300 Zeilen.

`initdb/` wird in Namensreihenfolge eingespielt: Schema 26.2, Beispieldaten, die Flyway-Migrationen aus `mobiq-code` (`db/migration`) und die Daten nach 26.4. `overview.json` fasst Tabellen und Zeilen für das Dashboard zusammen.

## Lokal starten

```
docker compose up -d
psql "postgresql://mobiq:mobiq-demo@localhost:5433/mobiq"
```

Das Passwort ist ein Demo-Wert und nur für diese lokale Beispieldatenbank gedacht. Neu aufsetzen: `docker compose down -v`, dann wieder `up -d`.

## Später in Google Cloud

Für eine gehostete Variante (z. B. Cloud SQL for PostgreSQL) dieselben Dateien aus `initdb/` in derselben Reihenfolge einspielen und eigene Zugangsdaten verwenden. Noch nicht eingerichtet.

Teil des Evaluationsdatensatzes: Code in `mobiq-code`, Dokumentation in `mobiq-docs`, Generator, Tickets und Lösung in `mobiq`. Nicht von Hand ändern, sondern im Repository `mobiq` neu erzeugen.

Alle Firmen, Personen und Daten sind erfunden.

## Lizenz

MIT, siehe [LICENSE](LICENSE). Gilt für den gesamten MOBIQ-Datensatz.

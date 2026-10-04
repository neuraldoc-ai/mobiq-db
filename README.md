# MOBIQ database

The company database of the fictional ERP vendor MOBIQ: PostgreSQL 18, 14 tables, about 3,300 rows.

`initdb/` runs in name order: schema as of 26.2, sample data, the Flyway migrations from [`mobiq-code`](https://github.com/neuraldoc-ai/mobiq-code) (`db/migration`) and the data after 26.4. `overview.json` summarises tables and rows for the dashboard.

## Run locally

```
docker compose up -d
psql "postgresql://mobiq:mobiq-demo@localhost:5433/mobiq"
```

The password is a demo value, meant only for this local sample database. To start over: `docker compose down -v`, then `up -d` again.

## Later in Google Cloud

For a hosted variant (e.g. Cloud SQL for PostgreSQL), load the same files from `initdb/` in the same order and use your own credentials. Not set up yet.

Part of the evaluation dataset: code in `mobiq-code`, documentation in [`mobiq-docs`](https://github.com/neuraldoc-ai/mobiq-docs), generator, tickets and solution in [`mobiq`](https://github.com/neuraldoc-ai/mobiq). Do not edit by hand; regenerate in the `mobiq` repository.

All companies, people and data are fictional.

## License

MIT, see [LICENSE](LICENSE). It covers the whole MOBIQ dataset.

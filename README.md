# CustomerIO Importer

Takes a CSV (from /data/gdpr_data.csv) and sanitizes the data neatly into a database.

From there, it can push data to CustomerIO, sort of (CIO doesn't allow contact creation through its API, but it's ok with contact updating).

### Running it

1. Ask Samm for the CSV, and the `.env`.
2. `bundle`
3. `rails s`.
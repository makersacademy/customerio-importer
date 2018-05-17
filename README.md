# CustomerIO Importer

Takes a CSV of GDPR data and sanitizes the data neatly into a database. Then pushes data to CustomerIO, creating or updating contacts for the correct email campaign.

### Getting set up

1. Check #gdpr on Slack for the GDPR data CSV and the `.env`.
2. `bundle`

### Using it

Two main tasks: import from the CSV, and export to CustomerIO:

- `rake import:master` expects a file called `gdpr_data.csv` in a root directory called `data`. It imports all the data from the CSV and tidies it into the database for upload.
- `rake sync:all` expects the database to be full of tidy data. Then it uploads people one-by-one to CustomerIO. It will update people if they already exist, or create new people.


#### Testing

There's `rspec` for unit tests.

There are some test commands for the scripts:

- `rake sync:seed` seeds the database with test data.
- `rake sync:test_all` tests syncing one test customer of each type.
- `rake sync:test_b2c_customer` tests syncing a test B2C Customer.
- `rake sync:test_b2c_alumnus` tests syncing a test B2C Alumnus.
- `rake sync:test_b2c_fellow` tests syncing a test B2C Fellow.
- `rake sync:test_b2b_person` tests syncing a test B2B Person.
- `rake sync:test_other` tests syncing a test 'Other' Person.

In each case, you should be able to:

- Go to CustomerIO's 'People' panel and see each customer synced there.
- Go to CustomerIO's 'Triggered Campaigns' panel and see each customer type sent an email in the correct campaign.

> To re-test, delete the customers from CustomerIO and re-run the correct Rake task.
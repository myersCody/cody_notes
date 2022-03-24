## Useful PSQL Shortcuts

The notes in this section are useful short cuts for working in in postgres.

##### How to connect:
```
PGPASSWORD=postgres psql postgres -U postgres -h localhost -p 15432
```

##### How to search with a schema:
```
set search_path=acct10001;
```

#### How to find data tables:

```
\dt

--  You can reduce the output by adding search parameters

\dt reporting_ocpgcp*
```

You can also show mat views with:
```
postgres=# \dm reporting_gcp*
                                  List of relations
  Schema   |                   Name                   |       Type        |  Owner
-----------+------------------------------------------+-------------------+----------
 acct10001 | reporting_gcp_compute_summary            | materialized view | postgres
 acct10001 | reporting_gcp_compute_summary_by_account | materialized view | postgres
 acct10001 | reporting_gcp_compute_summary_by_project | materialized view | postgres
 acct10001 | reporting_gcp_compute_summary_by_region  | materialized view | postgres
 acct10001 | reporting_gcp_compute_summary_by_service | materialized view | postgres
 acct10001 | reporting_gcp_cost_summary               | materialized view | postgres
 acct10001 | reporting_gcp_cost_summary_by_account    | materialized view | postgres
 acct10001 | reporting_gcp_cost_summary_by_project    | materialized view | postgres
 acct10001 | reporting_gcp_cost_summary_by_region     | materialized view | postgres
 acct10001 | reporting_gcp_cost_summary_by_service    | materialized view | postgres
 acct10001 | reporting_gcp_database_summary           | materialized view | postgres
 acct10001 | reporting_gcp_network_summary            | materialized view | postgres
 acct10001 | reporting_gcp_storage_summary            | materialized view | postgres
 acct10001 | reporting_gcp_storage_summary_by_account | materialized view | postgres
 acct10001 | reporting_gcp_storage_summary_by_project | materialized view | postgres
 acct10001 | reporting_gcp_storage_summary_by_region  | materialized view | postgres
 acct10001 | reporting_gcp_storage_summary_by_service | materialized view | postgres
(17 rows)
```

#### Tidy up the display mode

```
\x
```
```
\x auto
```

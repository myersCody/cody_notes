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

#### List columns for a table:
```
\d+ reporting_ocpusagelineitem_daily_summary
```
**Example**
```
test_postgres=# \d+ reporting_ocpusagelineitem_daily_summary
                                      Partitioned table "acct10001.reporting_ocpusagelineitem_daily_summary"
                     Column                     |          Type          | Collation | Nullable | Default | Storage  | Stats target | Description
------------------------------------------------+------------------------+-----------+----------+---------+----------+--------------+-------------
 uuid                                           | uuid                   |           | not null |         | plain    |              |
 cluster_id                                     | character varying(50)  |           |          |         | extended |              |
 cluster_alias                                  | character varying(256) |           |          |         | extended |              |
 data_source                                    | character varying(64)  |           |          |         | extended |              |
 namespace                                      | character varying(253) |           |          |         | extended |              |
 node                                           | character varying(253) |           |          |         | extended |              |
 resource_id                                    | character varying(253) |           |          |         | extended |              |
 usage_start                                    | date                   |           | not null |         | plain    |              |
 usage_end                                      | date                   |           | not null |         | plain    |              |
```


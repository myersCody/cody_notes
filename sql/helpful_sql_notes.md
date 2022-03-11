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

#### Tidy up the display mode

```
\x
```
```
\x auto
```

#### What to investigate when the cost is higher than you expected

1. Cost Distribution

2. We may be using a max instead of a sum

3. Grouping

#### How to search for tag keys in a json field

```
AND tags ? 'ready-as-about-our'
```

## If you need to sum a specific key in a json value

```
select SUM(((infrastructure_usage_cost->>'cpu'::"text"))::numeric) from reporting_ocpusagelineitem_daily_summary WHERE pod_labels ? 'environment';
```

## Using max on strings

The functions MAX, MIN, etc. use the lexicographic order when applied to text columns.

- https://stackoverflow.com/questions/18558620/sql-max-function-in-non-numeric-columns

- https://en.wikipedia.org/wiki/Lexicographic_order

Example:

```
postgres=# SELECT max(currency) FROM (VALUES ('one'), ('two'), ('three'), ('three'), ('one')) AS t (currency);
 max
-----
 two
(1 row)
```


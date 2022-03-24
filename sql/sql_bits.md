#### How to search for tag keys in a json field

```
AND tags ? 'ready-as-about-our'
```

## If you need to sum a specific key in a json value

```
select SUM(((infrastructure_usage_cost->>'cpu'::"text"))::numeric) from reporting_ocpusagelineitem_daily_summary WHERE pod_labels ? 'environment';
```


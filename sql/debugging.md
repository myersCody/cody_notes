## SQL Debugging Checks

1. Cost Distribution

A good way to check the cost distribution is by looking at the pod cost:
```
SELECT SUM(unblended_cost), SUM(pod_cost), data_source, service_alias FROM reporting_ocpgcpcostlineitem_project_daily_summary_p GROUP BY data_source, service_alias;
```

2. We may be using a max instead of a sum

3. Grouping
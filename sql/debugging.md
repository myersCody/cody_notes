## SQL Debugging Checks

1. Cost Distribution

A good way to check the cost distribution is by looking at the pod cost:
```
SELECT SUM(unblended_cost), SUM(pod_cost), data_source, service_alias FROM reporting_ocpgcpcostlineitem_project_daily_summary_p GROUP BY data_source, service_alias;
```

2. Check to see if we need to use a `max` instead of a `sum`

3. Grouping

### Example queries for Debugging Tags

```
select distinct key from reporting_ocpstoragevolumelabel_summary INNER JOIN reporting_ocpusagereportperiod ON reporting_ocpstoragevolumelabel_summary.report_period_id = reporting_ocpusagereportperiod.id AND cluster_id = 'OCP-on-AWS' AND report_period_start  >= '2022-02-28';
```
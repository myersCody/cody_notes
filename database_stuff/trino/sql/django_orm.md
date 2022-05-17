## Aggregates

1. You can aggregate a dictionary with `**`:

```
totals = OCPUsageLineItemDailySummary.objects.filter(
                usage_start__gte=self.ten_days_ago.date(), pod_labels__has_key=filter_key
            ).aggregate(
                **{
                    "usage": Sum("pod_usage_cpu_core_hours"),
                    "request": Sum("pod_request_cpu_core_hours"),
                    "limit": Sum("pod_limit_cpu_core_hours"),
                    "cost": Sum(
                        Coalesce(
                            KeyDecimalTransform("cpu", "supplementary_usage_cost"),
                            Value(0, output_field=DecimalField()),
                        )
                        + Coalesce(F("infrastructure_raw_cost"), Value(0, output_field=DecimalField()))
                        + Coalesce(
                            KeyDecimalTransform("cpu", "infrastructure_usage_cost"),
                            Value(0, output_field=DecimalField()),
                        )
                        + Coalesce(F("infrastructure_markup_cost"), Value(0, output_field=DecimalField()))
                    ),
                }
            )
```
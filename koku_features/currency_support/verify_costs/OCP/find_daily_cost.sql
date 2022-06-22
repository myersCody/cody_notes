select distinct(usage_start), source_uuid, sum(infrastructure_raw_cost)  from reporting_ocp_cost_summary_p group by usage_start, source_uuid order by usage_start;
select * from reporting_ocp_cost_summary_p WHERE usage_start >= '2022-06-01';

--  SQL used to confirm the daily cost
select
    distinct(usage_start),
    source_uuid,
    max(cluster_id) as cluster_id,
    (SUM(((infrastructure_usage_cost->>'cpu'::"text"))::numeric) + SUM(((infrastructure_usage_cost->>'memory'::"text"))::numeric) + SUM(((infrastructure_usage_cost->>'storage'::"text"))::numeric)) as infra_daily,
    (SUM(((supplementary_usage_cost->>'cpu'::"text"))::numeric) + SUM(((supplementary_usage_cost->>'memory'::"text"))::numeric) + SUM(((supplementary_usage_cost->>'storage'::"text"))::numeric)) as sup_daily,
    (SUM(((infrastructure_monthly_cost_json->>'cpu'::"text"))::numeric) + SUM(((infrastructure_monthly_cost_json->>'pvc'::"text"))::numeric) + SUM(((infrastructure_monthly_cost_json->>'memory'::"text"))::numeric)) as infra_monthly,
    (SUM(((supplementary_monthly_cost_json->>'cpu'::"text"))::numeric) + SUM(((supplementary_monthly_cost_json->>'pvc'::"text"))::numeric) + SUM(((supplementary_monthly_cost_json->>'memory'::"text"))::numeric)) as sup_monthly
from reporting_ocpusagelineitem_daily_summary WHERE
    usage_start >= '2022-06-1'
group by usage_start, source_uuid order by usage_start;



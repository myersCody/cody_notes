This document runs through testing instructions for creating multiple ocp sources with different base currencies, and how to verify that rates are correct with the database.

## Creating Multiple OCP sources with different base currencies.

**Step One: Multiple OCP sources**
Create multiple ocp sources with different base currencies. This work has been scripted out so that all you have to run is:

```
curl -s -L https://raw.githubusercontent.com/myersCody/cody_notes/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/ocp_commands.sh | bash
```

*Notes:*
- This command uses the makefile in koku so you will need to run it at that level.
- You are gonna have to wait till all the sources and data is loaded before moving on to the cost models section.


**Step Two: Cost Models**
In order to set up the multiple different base currencies, you will need to create cost models for each of the sources set up in the previous step.

I have also found a way to mostly automate this:
1. Inside of Postman create a post response to the following API:
```
http://127.0.0.1:8000/api/cost-management/v1/cost-models/
```

2. Change the body to the following raw json:
- https://raw.githubusercontent.com/myersCody/cody_notes/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/cost_models/postman_body.json

3. Add the Pre-request JavaScript in postman:
- https://raw.githubusercontent.com/myersCody/cody_notes/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/cost_models/postman_prerequest.js

**Notes:**
I set up the sources to contain a currency within the cluster name. Therefore, I can now map which currency the cost model is for with one field change. This script will also automatically grab the source_uuid for desired currency for you.


4. Create the Cost model:
Inside of prerequest script find the following variable:
```
desired_currency = "JYP";
```

You will need to send one post request for each currency option defined in the previous workflows & yamls.

Currency Options:
- AUD
- JYP
- EUR

5. You will also need to hit the update exchange rates url:
- http://127.0.0.1:5042/api/cost-management/v1/update_exchange_rates/

Note: Keep this window up cause you will need it to verify the costs.

## Verifying Costs

1. Grab initial cost from the DB

*Access the database*
```
(koku) bash-3.2$ PGPASSWORD=postgres psql postgres -U postgres -h localhost -p 15432
psql (12.1, server 13.7 (Debian 13.7-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

postgres=# set search_path=acct10001;
SET
postgres=# \x auto
Expanded display is used automatically.
postgres=#
```

*SQL to get current cost before rates are applied**
```
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
```
- Depending on when you run this you will want to change the usage start for the current billing month you are in.

Example:
```
# -[ RECORD 1 ]-+-------------------------------------
# usage_start   | 2022-06-01
# source_uuid   | 2d085606-e8fa-4a91-9ef8-755c05cb36e2
# cluster_id    | ocp-cluster-JPY
# infra_daily   | 60.00000000000000000
# sup_daily     | 120.1337976777777776100000000
# infra_monthly | 16999.999999999999999800000000000000
# sup_monthly   |
# -[ RECORD 2 ]-+-------------------------------------
# usage_start   | 2022-06-01
# source_uuid   | 7188a517-5653-4482-bc57-c60b4a8f88a8
# cluster_id    | ocp-cluster-EUR
# infra_daily   | 60.00000000000000000
# sup_daily     | 120.2284206333333329500000000
# infra_monthly | 16999.999999999999999800000000000000
# sup_monthly   |
# -[ RECORD 3 ]-+-------------------------------------
# usage_start   | 2022-06-01
# source_uuid   | e2e9d867-bced-43f1-8f03-922f0fb1fdee
# cluster_id    | ocp-cluster-AUD
# infra_daily   | 60.00000000000000000
# sup_daily     | 120.0170106833333333000000000
# infra_monthly | 16999.999999999999999800000000000000
# sup_monthly   |
# -[ RECORD 4 ]-+-------------------------------------
```
The cost will be broken down by currency for each currency type per day.

3. Take the numbers and spot check each day using the following python codee:
```
from decimal import Decimal

# Grab these rates from the update exchange rates endpoint.
exchange_rates = {
                    "JPY": {"USD": Decimal(1.25)},
                    "EUR": {"USD": Decimal(.5)},
                    "AUD": {"USD": Decimal(.25)},
                }
# Modify this to match your query output.
query_data = {
    "JPY": [60.00000000000000000, 120.1337976777777776100000000, 16999.999999999999999800000000000000],
    "EUR": [60.00000000000000000, 120.2284206333333329500000000, 16999.999999999999999800000000000000],
    "AUD": [60.00000000000000000, 120.0170106833333333000000000, 16999.999999999999999800000000000000]
}


total_sum_list = []
for key in query_data.keys():
    for cost in query_data.get(key, []):
        converted = Decimal(cost) * exchange_rates[key]["USD"]
        total_sum_list.append(converted)

print(sum(total_sum_list))
```
4. Now check OCP current monthly total URL:
   - http://localhost:8000/api/cost-management/v1/reports/openshift/costs/?filter[resolution]=daily&filter[time_scope_units]=month&delta=cost&filter[time_scope_value]=-1

Now check that the expected total for `2022-06-01` in this example matches what the endpoint is returning.




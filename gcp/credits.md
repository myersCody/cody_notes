## BigQuery with Nise

Credits done through bigquery have a flat rate:
For example if you use this as your yaml.
```
generators:
  - ComputeEngineGenerator:
      start_date: last_month
      price: 2
      usage.amount_in_pricing_units: 1
      usage.pricing_unit: hour
      instance_type: n1-standard-4
      location.region: us-west1-a
      currency: USD
      labels: [{"openshift_node": "test_gcp_kikis", "Titan": "Jaw", "kubernetes-io-cluster-test_cost_ocp_on_gcp_cluster_kikis": "owned"}]
      credit_amount: -200 # Per invoice month
  - CloudStorageGenerator:
      start_date: last_month
      price: 2
      usage.amount_in_pricing_units: 1
      service.description: Storage
      currency: USD
      location.region: us-west1-a
      labels: [{"openshift_node": "test_gcp_kikis", "User": "Ymir"}]
      credit_amount: -100 # Per invoice month
```

Then you can query bigquery to see the rates:
```
SELECT distinct(credits.amount) FROM `project.dataset.export` LEFT JOIN UNNEST(credits) AS credits WHERE usage_start_time >= '2022-03-01';
```
```
1 | 0.0
2 | -0.2205071664829107
3 | -0.4410143329658214
```
We have one rate for the 100, and another for the -200.

## Locally with Nise

Credits are applied for the whole month. So, the entire month of march will get the `-200`


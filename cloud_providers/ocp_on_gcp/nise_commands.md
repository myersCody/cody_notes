# Corey's yamls
*GCP*
```
nise report gcp --static-report-file testing/nise_yamls/ocp_on_gcp/corey-gcp.yml --gcp-bucket-name testing/local_providers/gcp_local_1
```
*OCP*
```
nise report ocp --static-report-file testing/nise_yamls/ocp_on_gcp/corey-ocp.yml --ocp-cluster-id test-ocp-gcp-cluster --insights-upload testing/pvc_dir/insights_local
```

# Luke's yamls:
* [GCP YML](./nise_ymls/luke-gcp.yml)
* [OCP YML](./nise_ymls/luke-ocp.yml)

*GCP*
```
nise report gcp --static-report-file testing/nise_yamls/ocp_on_gcp/luke-gcp.yml --gcp-bucket-name testing/local_providers/gcp_local_1
```
Postman Data:
```
{
    "name": "Local Source One",
    "source_type": "GCP-local",
    "authentication": {
        "credentials": {
            "project_id": "todays-raw-calc-id"
        }
    }, "billing_source": {
        "data_source": {"dataset": "numberone", "local_dir":"/tmp/gcp_local_bucket_1"}
        }
}
```

*OCP*
```
nise report ocp --static-report-file testing/nise_yamls/ocp_on_gcp/luke-ocp.yml --ocp-cluster-id test_cost_ocp_on_gcp_cluster_kikis --insights-upload testing/pvc_dir/insights_local
```
Postman Data:
```
{
    "name": "TestSource OCP GCP",
    "source_type": "OCP",
    "authentication": {
        "credentials": {
            "cluster_id": "test_cost_ocp_on_gcp_cluster_kikis"
        }
    }
}
```

**Special Note**
- You will need to upload the OCP source completely before adding the GCP source.

**Steps**
1. Run both nise commands
2. Run postman ocp
3. Run postman gcp
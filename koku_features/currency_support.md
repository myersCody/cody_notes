#### AWS Source
```
make local-aws-source aws_name=AWS_local bucket=/tmp/local_bucket
make local-aws-source aws_name=AWS_local_0 bucket=/tmp/local_bucket_0
make local-aws-source aws_name=AWS_local_1 bucket=/tmp/local_bucket_1
```

```
nise report --currency "USD" aws --static-report-file ../cost_dev_repos/nise/example_aws_static_data.yml --aws-s3-report-name None --aws-s3-bucket-name "testing/local_providers/aws_local"
nise report --currency "EUR" aws --static-report-file ../cost_dev_repos/nise/example_aws_static_data.yml --aws-s3-report-name None --aws-s3-bucket-name "testing/local_providers/aws_local_0"
nise report --currency "AUD" aws --static-report-file ../cost_dev_repos/nise/example_aws_static_data.yml --aws-s3-report-name None --aws-s3-bucket-name "testing/local_providers/aws_local_1"
```

#### Azure Source
```
make local-azure-source azure_name=Azure_local bucket=/tmp/local_container
make local-azure-source azure_name=Azure_local_0 bucket=/tmp/local_container_0
make local-azure-source azure_name=Azure_local_1 bucket=/tmp/local_container_1
```

```
nise report -c jpy azure --static-report-file ../cost_dev_repos/nise/example_azure_static_data.yml --azure-report-name azure-report --azure-container-name "testing/local_providers/azure_local"
nise report -c eur azure --static-report-file ../cost_dev_repos/nise/example_azure_static_data.yml --azure-report-name azure-report --azure-container-name "testing/local_providers/azure_local_0"
nise report -c gbp azure --static-report-file ../cost_dev_repos/nise/example_azure_static_data.yml --azure-report-name azure-report --azure-container-name "testing/local_providers/azure_local_1"
```

#### GCP Source
```
make local-gcp-source gcp_name=GCP_LOCAL GCP_PROJECT_ID="example_project_id" GCP_TABLE_ID="example_table_id" GCP_DATASET="example_dataset" GCP_LOCAL_DIR="/tmp/gcp_local_bucket"
make local-gcp-source gcp_name=GCP_LOCAL_0 GCP_PROJECT_ID="example_project_id" GCP_TABLE_ID="example_table_id" GCP_DATASET="example_dataset" GCP_LOCAL_DIR="/tmp/gcp_local_bucket_0"
make local-gcp-source gcp_name=GCP_LOCAL_1 GCP_PROJECT_ID="example_project_id" GCP_TABLE_ID="example_table_id" GCP_DATASET="example_dataset" GCP_LOCAL_DIR="/tmp/gcp_local_bucket_1"
```

```
nise report --currency "JPY" gcp --static-report-file "../cost_dev_repos/nise/example_gcp_static_data.yml" --gcp-bucket-name "testing/local_providers/gcp_local"
nise report --currency "EUR" gcp --static-report-file "../cost_dev_repos/nise/example_gcp_static_data.yml" --gcp-bucket-name "testing/local_providers/gcp_local_0"
nise report --currency "AUD" gcp --static-report-file "../cost_dev_repos/nise/example_gcp_static_data.yml" --gcp-bucket-name "testing/local_providers/gcp_local_1"
```


## Resources:
- Initial Start Up Steps: https://github.com/project-koku/koku/pull/3493
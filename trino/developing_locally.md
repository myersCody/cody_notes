Environment variables:
```
#### USING TRINIO
## THESE VARS NEED TO BE UNCOMMENTED
ENABLE_PARQUET_PROCESSING=True
S3_BUCKET_NAME=koku-bucket
S3_ENDPOINT=http://kokuminio:9000
S3_ACCESS_KEY=kokuminioaccess
S3_SECRET=kokuminiosecret
S3_BUCKET_PATH=data
TRINO_DATE_STEP=31
## THESE WILL NEED TO BE COMMENTED OUT WHEN USING TRINIO
# S3_BUCKET_NAME=koku-bucket
# S3_BUCKET_PATH=data_archive
# S3_ENDPOINT=s3.us-east-1.amazonaws.com
# ENABLE_PARQUET_PROCESSING=False
```

Mino: http://127.0.0.1:9090/minio/
- This is the csv & parquet files are located.
- This takes the place of the S3 bucket when you are developing locally.

Trino Coordinator UI: http://127.0.0.1:8080/ui/
- This allows you to see the queies ran by the coordinator and in what order
- It is really helpful or debugging, because it will show the values of the vars we are using the UI.

Trino Commands:
```
trino --server localhost:8080 --catalog hive --schema acct10001 --user admin --debug
```

Quicker way to bring the server down and up:
```
 make docker-trino-down-all && make docker-up-min-trino-no-build
```
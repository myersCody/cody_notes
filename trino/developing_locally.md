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
## Day to Day Workflow

Unlike other providers, GCP uses BigQuery to collect the cost data and create the CSV for processing. Because of our need to query every day to get the data we have two different queries we do to BigQuery:

```
    if not last_export_time:
        if str(DateAccessor().today().date()) == scan_end:
            scan_end = DateAccessor().today().date() + relativedelta(days=1)
        query = f"""
        SELECT {self.build_query_select_statement()}
        FROM {self.table_name}
        WHERE DATE(_PARTITIONTIME) >= '{scan_start}'
        AND DATE(_PARTITIONTIME) < '{scan_end}'
        """
    else:
        query = f"""
        SELECT {self.build_query_select_statement()}
        FROM {self.table_name}
        WHERE DATE(_PARTITIONTIME) >= '{scan_start}'
        AND DATE(_PARTITIONTIME) < '{scan_end}'
        AND export_time > '{last_export_time}'
        """
```

The way we distinguish between the "Initial Download" and the "Day to Day" Workflow is with the `last_export_time` variable. On each download we collect a `max(export_time)`, and we store that value in the database. If the databasee field is null, we know it is the initial download.

The day to day workflow query only grabs data that has a greater export time then the last export time we have seen. Therefore, we only every query for the new data on each day. Which helps cut our BigQuery costs.

## How to Manually Test

To test the day to day workflow you will need access to the dev gcp account. It is much harder to test the day to day workflow manually with nise. For the day to day workflow we will need to OVERWRITE the date variable inside of MASU using an environment variable.

<!-- TODO: Add a section about using a real gcp account for developing -->

1. Add this variable to your .env file. You will want to inital download as a few days back.

*GCP Date Override*
```
DATE_OVERRIDE='2021-11-30'
```

You can check to make sure this variable is inside of your python environment with this command:
```
$ printenv | grep DATE_OVERRIDE
```

Now check to make sure this variable is inside of the koku worker because it will be running the download task.
```
docker exec -it koku_koku-worker_1 bash -c "echo $DATE_OVERRIDE"
```

If the variable is not inside of your conatiner you can restart it and check again:
```
docker-compose up -d koku-worker
```

2. After you confirm it is in the container trigger a download:
- http://127.0.0.1:5042/api/cost-management/v1/download/

<!-- Add example of the logs when download finishes.  -->

3. Increment the date override and repeat the process until you reach today.

4. Compare the Costs

After you have caught up to today, you can now check the costs on our endpoints with the costs inside of BigQuery.

You can check the costs inside of BigQuery with this internal masu endpoint:
- http://127.0.0.1:5042/api/cost-management/v1/gcp_invoice_monthly_cost/?provider_uuid=bbc04adc-99b9-4306-a22c-0eea61c62f78

The you can see the current month with:
- http://localhost:8000/api/cost-management/v1/reports/gcp/costs/?filter[time_scope_value]=-1&filter[time_scope_units]=month&filter[resolution]=monthly

This must match what we see on the internal masu endpoint. If it does it means the day to day workflow is working correctly.

Now check the previous month with:
- http://localhost:8000/api/cost-management/v1/reports/gcp/costs/?filter[time_scope_value]=-2&filter[time_scope_units]=month&filter[resolution]=monthly

This must match what we see on the internal masu endpoint, if it does match that means the intial download is working correctly.

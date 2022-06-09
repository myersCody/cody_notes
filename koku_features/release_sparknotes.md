06/09/2022 Release

1. Check DB migrations

```
(koku) bash-3.2$ ./dev/scripts/show_migrations -o 90b8a9731a67577597f20645c1f2f154197f0123 -n 43e8483a0dcf678e564f6989224aaa2d94305d3b

Comparing migrations:
old sha: 90b8a9731a67577597f20645c1f2f154197f0123
new sha: 43e8483a0dcf678e564f6989224aaa2d94305d3b

New migrations were created:
	api:
		0057_add_org_ids.py

Django migrations should be run.
```

```
git checkout master
git fetch upstream; git rebase upstream/master
git checkout -b hccm-prod-c32f57f-migrations
```

Change the db image tag:
```

git commit -m 'hccm: promote c32f57f migrations to prod'
git push origin hccm-prod-c32f57f-migrations
```


Message the alerts channel:
#cost-mgmt-prod-alerts
```
@crc-cost-mgmt-dev The latest release of cost-management to production is starting. Any alerts are likely due to the release.
```
- Comment and say when the migrations are starting

During a release you can check how many schemas have been run by clicking the raw logs and ctrl f for `Running migrate for schema`

After Migrations are complete.

Create another MR:
```
git checkout master
git fetch upstream; git rebase upstream/master
git checkout -b hccm-prod-43e8483
```

```
43e8483a0dcf678e564f6989224aaa2d94305d3b
```

```
git commit -m 'hccm: promote 43e8483 migrations to prod'
git push origin hccm-prod-43e8483
```

```
@crc-cost-mgmt-dev The latest release of cost-management to production has finished. Any new alerts should be investigated. Release notes will follow in the team chat when completed.
```


BACKUP: 90b8a9731a67577597f20645c1f2f154197f0123


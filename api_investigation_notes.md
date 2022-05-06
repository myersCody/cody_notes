Helpful Take Aways from API Performance Investigation Meeting
1. Use the dev tools to see the spefic url the UI uses.
- developer -> dev tools -> Network
"This will show all of the api calls that we make"
- What is great about dev tools is that you can find the specific query that is driving the response.

2. How to see the queries django runs.
```
from django.db import connection
print(connection.queries)
```
^ This will show all of the query calls that django makes. This shows everything on the connection.


3. How to flush your cache
```
docker eexe -it koku_redis
redis_cli
select 1
keys *
flushall
keys *
```



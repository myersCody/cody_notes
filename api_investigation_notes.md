Helpful Take Aways from API Performance Investigation Meeting
1. Use the dev tools to see the spefic url the UI uses.
```
developer -> dev tools -> Network
```
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

4. You can add to the user section of the nise yaml to increase the amount of test data you are using:
```
accounts:
  payer: 9999999999999
  user:
    - 9999999999999
    - <insert here>
```

5. You can use `time.time()` to see how long various parts of our code to see what is taking the most amount of time. That or you can use something like cprofile.


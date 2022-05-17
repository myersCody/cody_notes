1. Ignore Results
- I think we will want to implement this for koku
```
A task status is the information about the task exiting with a success or failure. It can be useful for some kind of statistics later on. The big thing to note here is that the exit status is not the result of the job that the task was performing, that information is most likely some sort of side effect that gets written to the database (ie. update a user's friend list).

Most projects I've seen don't really care about keeping persistent track of a task's status after it exited yet most of them use either the default sqlite database for saving this information, or even better, they've taken the time and use their regular database (postgres or otherwise).

Why hammer your webapp's database for no reason? Use CELERY_IGNORE_RESULT = True in your celeryconfig.py and discard the results.
```
Quote Above From: https://denibertovic.com/posts/celery-best-practices/
- https://docs.celeryq.dev/en/stable/userguide/tasks.html?highlight=ignore_result#Task.ignore_result

- https://docs.celeryq.dev/en/stable/userguide/tasks.html?highlight=ignore_result#Task.ignore_result

2. Celery's error handling mechanisms
```
@app.task(bind=True, default_retry_delay=300, max_retries=5)
def my_task_A():
    try:
        print("doing stuff here...")
    except SomeNetworkException as e:
        print("maybe do some clenup here....")
        self.retry(e)
```

3. Don't pass Database/ORM objects to tasks.
You shouldn't pass Database objects (for instance your User model) to a background task because the serialized object might contain stale data. What you want to do is feed the task the User id and have the task ask the database for a fresh User object.

4/5: Should we retry or acks_late? http://www.pythondoc.com/celery-3.1.11/faq.html#faq-acks-late-vs-retry

4. Retry Missing Work:
- https://adamj.eu/tech/2020/02/03/common-celery-issues-on-django-projects/#not-retrying-missed-work


5. `ACKS_LATE`: https://wiredcraft.com/blog/3-gotchas-for-celery/

6. Look into `-ofair` option for our celery workers:

Helpful chat for thinking about how ofair works
- https://groups.google.com/g/celery-users/c/8kTlKtOqxLg

- http://www.pythondoc.com/celery-3.1.11/userguide/optimizing.html#prefork-pool-prefetch-settings

7. Transient Queues
- http://www.pythondoc.com/celery-3.1.11/userguide/optimizing.html#using-transient-queues


Helpful Celery Links:
- https://www.fullstackpython.com/celery.html
- Example of work type specific workers: https://github.com/project-koku/koku/pull/2760
### one liner for loop with if condition

```
[(i) for i in my_list if i=="two"]
```

### Building Dictionaries in a for loop
```
data.extend(
            {
                k: m
                if k == rank_field
                else fd_date
                if k == "date"
                else account_alias_map.get(m, m)
                if k == "account_alias" and rank_field == "account"
                else type(v)()
                for k, v in fd.items()
            }
            for m in missing
        )  # noqa
```


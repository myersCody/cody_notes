## Useful Make Command

##### Bring trino down & up:
```
make docker-trino-down-all && make docker-up-min-trino-no-build
make docker-trino-down-all && make docker-up-min-trino
```

## Git Tricks
##### Easy way to clean up branches based off branch naming patterns

```
(koku) bash-3.2$ git branch | grep fix
  cost_distro_fix
  fix_refs
  markup_fix
  readme_fix
(koku) bash-3.2$ git branch | grep fix | xargs git branch -D
Deleted branch cost_distro_fix (was 36116fe0).
Deleted branch fix_refs (was 787f2a90).
Deleted branch markup_fix (was 28337eaf).
Deleted branch readme_fix (was 2bf3bbc3).
```
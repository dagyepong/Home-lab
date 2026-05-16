Quick Fix: Grant Permission Manually
Run this command to grant the required permission directly on the existing database:

```bash
docker exec dockhand-postgres psql -U dockhand -d dockhand -c "GRANT CREATE ON DATABASE dockhand TO dockhand;"
```


```bash
docker compose up -d
```


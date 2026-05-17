Create the upload directory (if it doesn’t exist) and set correct permissions:

```bash
sudo mkdir -p /media/dfr
sudo chown -R 1000:1000 /media/dfr   # Immich runs as UID 1000
```

Start the stack:

```bash
docker compose up -d
```



Verify:

```bash
docker compose logs -f
curl -H "Host: immich.linuxpad.blog" http://localhost/api/server-info
```



Use the backup container’s built‑in restore

```bash

docker run --rm \
  -v traefik_tor_data:/data \
  -v /home/nana/docker/backups:/backups:ro \
  offen/docker-volume-backup:v2.47.1 \
  restore -f /backups/your-backup-file.tar.gz -C /data
```


Important notes
The backup archives contain the contents of the volumes and bind mounts you backed up (authelia, traefik, tor_data). When restoring, the files will overwrite the target volume.

For the other bind mounts (/backup/authelia and /backup/traefik), those are actually read‑only inside the backup container – their source is /home/nana/docker/authelia and /home/nana/docker/traefik on the host. To restore them, copy files manually:

```bash
tar xzvf /home/nana/docker/backups/backup-file.tar.gz -C /home/nana/docker/authelia ./authelia/*
```

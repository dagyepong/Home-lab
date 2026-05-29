Fix: find the Docker group GID on the host and pass it via group_add.

# On the host
```bash
getent group docker | cut -d: -f3
```
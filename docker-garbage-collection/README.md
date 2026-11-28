Before starting it, create the exclusion file beside the Compose file:

```bash
touch docker-gc-exclude
docker compose up -d
docker compose logs -f docker-gc
```

Review the logs to see what it would remove. If the proposed cleanup looks safe, change DRY_RUN to "0" and recreate the container. I recommend keeping CLEAN_UP_VOLUMES: "0"—orphaned volumes can still contain data you care about. The Docker socket mount grants broad control over the Docker daemon despite no-new-privileges; don’t expose this container or its socket over a network.
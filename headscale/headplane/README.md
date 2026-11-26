Generate a random cookie secret, for example with:
```bash
 openssl rand -hex 16
 ```

The Docker socket mount enables Headplane’s advanced Docker integration; access to it is sensitive because it can grant substantial control over the Docker host. headplane.net

Create the API key without rebuilding the stack:

```bash

docker exec headscale headscale apikeys create --expiration 90d
```

Save the key securely, then sign in to Headplane at https://headscale.linuxpad.blog/admin. The key is shown only when created, so don’t paste it into chat or commit it in your Compose file. 
headplane.net
1

Before starting, create the Headplane directories and validate the Compose file:

```bash

mkdir -p /home/nana/docker/headscale/headplane/data
docker compose config
docker compose up -d
```
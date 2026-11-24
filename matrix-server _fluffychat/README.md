Create a .env file beside the Compose file:

```bash
POSTGRES_PASSWORD=replace-this-with-a-long-random-password
```

Keep .env private and don’t commit it to a public repository. Use the same password in Synapse’s database config.

Initialize Synapse before the first docker compose up:

```bash
mkdir -p synapse-data

docker compose run --rm synapse generate
```

The generated synapse-data/homeserver.yaml initially uses SQLite. Edit that file:

Set server_name to "matrix.linuxpad.blog".
Set public_baseurl to "https://matrix.linuxpad.blog/".
Replace its SQLite database: block with:

```yaml
database:
  name: psycopg2
  args:
    user: synapse
    password: "USE_THE_SAME_VALUE_AS_POSTGRES_PASSWORD"
    database: synapse
    host: postgres
    port: 5432
    cp_min: 5
    cp_max: 10
```

Then start the stack:

```bash
docker compose up -d
```

In FluffyChat, sign in using https://matrix.linuxpad.blog as the homeserver. FluffyChat’s web client supports a configurable default homeserver, but you can also select or enter one in the client. 
GitHub

Federation note: this routes client and federation API traffic through Traefik on HTTPS. For reliable federation, make sure your Matrix server’s public discovery/routing is configured as well; simply adding the web-client router is not enough. Also plan regular backups of both synapse-data (including its signing key and media) and the PostgreSQL volume, and pin image versions rather than relying on latest for long-term operation. 
matrix-org.github.io
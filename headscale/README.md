prepare directories:

```bash
mkdir -p ./headscale/config
```

Create empty sqlite database in the  headscale directory:

```bash
cd config/

touch db.sqlite
```

Headscale is up and serving: it created its Noise key, opened the SQLite database, and is listening on 0.0.0.0:8080. The HTTPS warning is expected when Traefik terminates TLS and forwards plain HTTP to Headscale, provided the public URL uses HTTPS.

The 401 is the remaining issue: the UI reached Headscale’s API, but its request didn’t include an API key. Generate one:

```bash
docker exec headscale headscale apikeys create
```


Copy the key when it’s shown—you can’t retrieve it later. In the Headscale UI settings, enter the API URL https://headscale.linuxpad.blog and the key. The UI docs specifically identify a missing API key or incorrect proxy setup as causes of the “missing Bearer” error. GitHub

Keep the key secret; don’t paste it here. After setting it in the UI, refresh and check whether the API request succeeds. API keys are required for Headscale’s REST API
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


🚀 Deployment & Configuration Steps
1. Create the Pocket ID data directory
```bash
mkdir -p pocket-id-data
```


2. Start the stack
```bash
docker compose up -d
```

. Set up Pocket ID admin account
Visit https://pocketid.linuxpad.blog/login/setup

Create your admin account and register a passkey (you can use your computer’s biometrics – no physical key required).

4. Create an OIDC client for Immich inside Pocket ID
Go to OIDC Clients → Add OIDC Client

Name: Immich

Callback URL: https://immich.linuxpad.blog/auth/oidc/callback
(this is Immich’s default OIDC callback endpoint)

Save – copy the generated Client ID and Client Secret.

 Fill the OIDC credentials in your .env
bash
POCKET_ID_CLIENT_ID=the-client-id
POCKET_ID_CLIENT_SECRET=the-client-secret
6. Restart Immich to apply OIDC settings
```bash
docker compose restart immich-server
```
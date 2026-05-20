Prerequisites & Setup
1. Create directories
```bash
mkdir -p /srv/appdata/nextcloud/{html,data,config,custom_apps,themes,db,redis}
```

2. Create .env file (same directory as compose)
```bash
cat > .env <<EOF
NEXTCLOUD_DB_PASSWORD=your_strong_password_here
EOF
```

3. Get a dedicated .onion address for Nextcloud
Edit your Tor container’s torrc (e.g., ./tor/torrc) and add:

```sh
HiddenServiceDir /var/lib/tor/nextcloud/
HiddenServicePort 80 traefik:8081
```
Restart Tor:

```bash
docker-compose restart tor   # or docker restart tor
```

Wait 30 seconds, then get the address:

```bash
docker exec tor cat /var/lib/tor/nextcloud/hostname
```

Copy the output (e.g., abcdef1234567890.onion).

4. Replace placeholders
nextcloud.nanaoware.online → your actual domain

www.nextcloud.nanaoware.online → if needed

YOUR_NEXTCLOUD_ONION.onion → the address from step 3

Also add that same .onion address to NEXTCLOUD_TRUSTED_DOMAINS in the environment.

5. Start Nextcloud

```bash
docker-compose up -d
```

6. Complete installation
Visit https://nextcloud.nanaoware.online – Authelia will prompt you. Then follow Nextcloud setup wizard. The database credentials will be auto‑filled from environment variables. Create an admin account when prompted.

Testing
Clearnet (authenticated): https://nextcloud.nanaoware.online – requires Authelia login.

Tor (anonymous): http://YOUR_NEXTCLOUD_ONION.onion in Tor Browser – no Authelia, but Nextcloud itself will ask you to log in (you can create a public share or guest account if you want truly anonymous access).
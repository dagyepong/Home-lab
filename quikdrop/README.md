📝 Setup Instructions
1. Create required directories on host
```bash
mkdir -p /srv/appdata/quickdrop/{files,log,db}
```

2. Get a dedicated .onion address for QuickDrop
Edit your Tor container’s torrc (e.g., ./tor/torrc) and add:

conf
# QuickDrop hidden service
HiddenServiceDir /var/lib/tor/quickdrop/
HiddenServicePort 80 traefik:8081

Restart Tor:

```bash
docker-compose restart tor   # or docker restart tor
```
Wait ~30 seconds, then retrieve the address:

```bash
docker exec tor cat /var/lib/tor/quickdrop/hostname
```
Example output: abcdef1234567890.onion

3. Replace placeholders
quickdrop.yourdomain.com → your actual clearnet domain.

YOUR_QUICKDROP_ONION.onion → the address from step 2.

4. Start QuickDrop

```bash
docker-compose up -d quickdrop
```
5. Verify
Clearnet (protected by Authelia): https://quickdrop.yourdomain.com

Tor (anonymous): http://abcdef1234567890.onion in Tor Browser


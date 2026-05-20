Pre‑flight Steps (do before starting)
Create the tor configuration directory and file:

```bash
mkdir -p ./tor
nano ./tor/torrc
```
Paste the following content into ./tor/torrc:

```bash
HiddenServiceDir /var/lib/tor/myservice/
HiddenServicePort 80 traefik:8081
```

You can add more hidden services by repeating the two lines with different HiddenServiceDir paths.

Ensure the Docker network traefik exists (it should already, but verify):

```bash
docker network ls | grep traefik
If missing, create it:
```

```bash
docker network create traefik
```

No other changes – your existing traefik entrypoints for HTTP/HTTPS remain untouched.

Starting the Stack
Run:

```bash
docker-compose up -d
```

After ~30 seconds, retrieve your .onion address:

```bash
docker exec tor cat /var/lib/tor/myservice/hostname
```

It will output something like abcdef1234567890.onion. Save this address.

Adding a Traefik Router for a Service (e.g., myapp)
To expose one of your existing services via Tor, add these labels to that service’s definition (inside docker-compose.yml):

```yaml
myapp:
  labels:
    # ... existing labels ...
    - "traefik.http.routers.myapp-tor.rule=Host(`abcdef1234567890.onion`)"
    - "traefik.http.routers.myapp-tor.entrypoints=tor"
    - "traefik.http.routers.myapp-tor.tls=false"
    - "traefik.http.routers.myapp-tor.service=myapp-svc"
    # Omit 'middlewares' to bypass Authelia (recommended for Tor)
```

If you do want Authelia to protect the Tor route, add:

```yaml
    - "traefik.http.routers.myapp-tor.middlewares=authelia@docker"
```

Replace myapp-svc with the actual backend service name you already use in your existing labels.

Testing
Inside your homelab, you can test with a Tor proxy container:

```bash
docker run --rm dperson/torproxy curl --socks5-hostname localhost:9050 http://abcdef1234567890.onion
```

Or simply open the .onion address in Tor Browser.
⚙️ 3. Tailscale Serve command (run after container starts)
After the tailscale-serve container is running, execute once:

```bash
docker exec tailscale-serve tailscale --socket=/tmp/tailscaled.sock serve --bg --https=443 http://traefik.:80
```
This tells Tailscale to:

Listen on port 443 (HTTPS) with an auto‑provisioned certificate

Proxy all requests to http://traefik.:80 on the Docker network

Serve under the node’s default MagicDNS name: https://homelab.tail9f20b.ts.net

To verify:
```bash
docker exec tailscale-serve tailscale --socket=/tmp/tailscaled.sock serve status
```
Expected output:

```sh
https://homelab.tail9f20b.ts.net/
|-- proxy http://traefik.:80
```

🔁 Making it persistent (optional)
The --bg command stays active as long as the container runs. However, if the container is recreated (e.g., docker compose down && docker compose up), you must re‑run the command.
To make it fully automatic, you can add the following to the command: of the tailscale-serve service in your compose file:

```yaml
    command: sh -c "tailscaled --socket=/tmp/tailscaled.sock --statedir=/var/lib/tailscale --tun=userspace-networking & sleep 5 && tailscale --socket=/tmp/tailscaled.sock serve --bg --https=443 http://traefik.:80 && wait"
```
But this overrides the container’s default entrypoint; test it carefully if you go that route. Alternatively, simply keep the manual command in your notes – it takes seconds.

📱 4. Access your services
From any device connected to your Tailscale network:
```sh
Traefik dashboard: https://homelab.tail9f20b.ts.net
```
(Optional) Authelia: add another Traefik router for auth.homelab.tail9f20b.ts.net pointing to authelia@docker, using the same http entrypoint.
📂 Traefik File Provider Configurations
All files are placed in ./config/ (relative to the main docker-compose.yml).

### **config/tailscale-dashboard.yml (Tailscale access):**
```yaml
http:
  routers:
    tailscale-dashboard:
      rule: "Host(`homelab.tail9f20b.ts.net`)"
      entrypoints:
        - "http"
      service: "dashboard@internal"
      middlewares:
        - "gzip@file"
```
### **config/technitium-web.yml (Technitium admin):**
```yaml
http:
  routers:
    technitium-web:
      rule: "Host(`dns.linuxpad.blog`)"
      entrypoints:
        - "https"
      tls:
        certResolver: "le"
      service: "technitium-web@file"
      middlewares:
        - "authelia@docker"
        - "gzip@file"

  services:
    technitium-web:
      loadBalancer:
        servers:
          - url: "http://technitium:5380"
```

### **config/technitium-doh.yml (DNS-over-HTTPS, optional):**
```yaml
http:
  routers:
    technitium-doh:
      rule: "Host(`doh.linuxpad.blog`)"
      entrypoints:
        - "https"
      tls:
        certResolver: "le"
      service: "technitium-doh@file"

  services:
    technitium-doh:
      loadBalancer:
        servers:
          - url: "http://technitium:8053"
```


### **config/wireguard-ui.yml (optional, to proxy WireGuard UI):**
```yaml
http:
  routers:
    wireguard-ui:
      rule: "Host(`wg.linuxpad.blog`)"
      entrypoints:
        - "https"
      tls:
        certResolver: "le"
      service: "wireguard-ui@file"
      middlewares:
        - "authelia@docker"

  services:
    wireguard-ui:
      loadBalancer:
        servers:
          - url: "http://wireguard:51821"
```

⚡ Tailscale Serve – The Only Command You Need
After the tailscale-serve container is running, execute once:

```bash
docker exec tailscale-serve tailscale --socket=/tmp/tailscaled.sock serve --bg --https=443 http://traefik.:80
```

Verify:

```bash
docker exec tailscale-serve tailscale --socket=/tmp/tailscaled.sock serve status
```

Expected output:

```sh
https://homelab.tail9f20b.ts.net/
|-- proxy http://traefik.:80
No JSON file is used; the CLI command is the official, reliable method.
```

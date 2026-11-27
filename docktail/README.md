crowdsec:


Create ./config/crowdsec.yaml for the middleware:

```yaml
http:
  middlewares:
    crowdsec:
      plugin:
        bouncer:
          enabled: true
          logLevel: INFO
          crowdsecMode: stream
          crowdsecLapiScheme: http
          crowdsecLapiHost: crowdsec:8080
          crowdsecLapiKey: REPLACE_WITH_BOUNCER_KEY
```


Create ./crowdsec/acquis.yaml to tell CrowdSec which log to parse:

```yaml
filenames:
  - /var/log/traefik/access.log
labels:
  type: traefik
```

Generate the key after CrowdSec starts:

```bash
docker compose up -d crowdsec
docker exec crowdsec cscli bouncers add traefik-bouncer
```
Put the printed key in place of REPLACE_WITH_BOUNCER_KEY(crowdsec.yaml), then start or restart Traefik:

```bash
docker compose up -d
```

Attach crowdsec@file to the HTTPS routers you want protected. For example, on your Headplane router:

```bash
- "traefik.http.routers.headplane.middlewares=crowdsec@file"
```
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

For future setups, keep Traefik’s watched directory limited to Traefik dynamic config files, such as crowdsec.yaml:

```bash
docktail/
├── config/                 # Traefik dynamic YAML only
│   └── crowdsec.yaml
├── crowdsec/
│   └── acquis.d/
│       └── traefik.yaml
└── logs/
    └── access.log
```

Keep notification data and other application files outside config/. Make sure the acquisition file mount is a file-to-file mount—or mount its containing directory—and that Traefik’s crowdsecLapiKey matches the key for a registered CrowdSec bouncer. The mode: host warning is separate; remove that setting when using regular Docker Compose rather than Swarm.
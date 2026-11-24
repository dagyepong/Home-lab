The runner image above handles registration on first startup and saves its registration state in runner_data. Create the runner token in Forgejo’s Actions → Runners settings first. The runner executes repository workflows; mounting the Docker socket gives those workflows powerful control over the Docker host. Use this only for repositories and contributors you trust, or put the runner on a separate machine. 
GitHub
1

I removed Authelia from the Forgejo router. Git clients and Actions need direct access to Forgejo’s authentication and API endpoints; putting Authelia in front can break them. Also, your earlier labels specified the HTTPS middleware twice, so this uses one label.

Create the .env and Compose files, then run docker compose up -d. Check startup with docker compose logs -f forgejo runner. Configure backups for both the PostgreSQL data and forgejo_data; the latter contains repositories, uploads, and other persistent Forgejo data.

This is a production-oriented starting point, not a complete production-readiness guarantee: you’ll also want tested off-host backups, an upgrade plan, monitoring, and a runner isolated from the Forgejo host for untrusted workflows. Forgejo’s official Docker installation docs cover its image and database configuration. 
forgejo.org
# Ghost with Let's Encrypt Using Docker Compose

❗ Change variables in the `.env` to meet your requirements.

💡 Note that the `.env` file should be in the same directory as `ghost-traefik-letsencrypt-docker-compose.yml`.

Create networks for your services before deploying the configuration using the commands:

`docker network create traefik-network`

`docker network create ghost-network`

Deploy Ghost using Docker Compose:

`docker compose -f ghost-traefik-letsencrypt-docker-compose.yml -p ghost up -d`

# Author


🌐 My [website](https://tech.nanaoware.online/) with detailed IT guides\
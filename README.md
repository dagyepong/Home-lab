# Home-lab
This is a collection of my current docker-compose files for my home-lab set-up. Anyone willing to replicate such set-up must have a working docker and docker-compose installed in their system first.
# Traefik
docker network create web
touch acme.json
chmod 600 acme.json

docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD/traefik.toml:/traefik.toml \
  -v $PWD/traefik_dynamic.toml:/traefik_dynamic.toml \
  -v $PWD/acme.json:/acme.json \
  -p 80:80 \
  -p 443:443 \
  --network web \
  --name traefik \
  traefik:v2.2

  # navigate to https://monitor.nanaoware.online/dashboard/
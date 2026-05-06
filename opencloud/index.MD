mkdir -p /home/nana/docker/opencloud/config
mkdir -p /home/nana/docker/opencloud/data

# Set ownership to match the OpenCloud container user (usually 1000)
sudo chown -R 1000:1000 /home/nana/docker/opencloud


# start containers
docker compose --profile apps up -d

docker compose --profile apps logs -f opencloud
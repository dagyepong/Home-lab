#!/bin/bash

# Ensure required tools
command -v jq >/dev/null 2>&1 || { echo "jq is required."; exit 1; }

# 1. Load configuration
MANIFEST="manifest.json"
NAME=$(jq -r '.name' "$MANIFEST")
REQUIRES_DB=$(jq -r '.requires_db' "$MANIFEST")
OPTIONS=$(jq -r '.options | keys[]' "$MANIFEST")

echo "--- Installing $NAME ---"
declare -A ANSWERS

# 2. Dynamic Prompting
for opt in $OPTIONS; do
    DESC=$(jq -r ".options.$opt.description" "$MANIFEST")
    TYPE=$(jq -r ".options.$opt.type" "$MANIFEST")

    if [ "$TYPE" == "boolean" ]; then
        read -p "$DESC (y/n) " val; [[ "$val" =~ ^[Yy]$ ]] && ANSWERS[$opt]="true" || ANSWERS[$opt]="false"
    elif [ "$TYPE" == "select" ]; then
        echo "$DESC"
        select item in $(jq -r ".options.$opt.options[]" "$MANIFEST"); do ANSWERS[$opt]=$item; break; done
    else
        read -p "$DESC " val; ANSWERS[$opt]=$val
    fi
done

# 3. Generate Docker Compose Dynamically
cat > docker-compose.yaml <<EOF
services:
  app:
    image: nextcloud:latest
    restart: always
EOF

# Append Traefik if requested
if [ "${ANSWERS[use_traefik]}" == "true" ]; then
    cat >> docker-compose.yaml <<EOF
    labels:
      - "traefik.http.routers.nextcloud.rule=Host(\`${ANSWERS[domain]}\`)"
EOF
fi

# Append Database if requested (and supported)
if [ "$REQUIRES_DB" == "true" ] && [ "${ANSWERS[database]}" == "postgres" ]; then
    cat >> docker-compose.yaml <<EOF
  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: password
EOF
fi

echo "--- Configuration Complete ---"
docker compose up -d
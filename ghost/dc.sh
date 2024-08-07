#!/usr/bin/env bash

if [ "$1" == "start" ]; then
    docker-compose start
fi

if [ "$1" == "stop" ]; then
    docker-compose stop
fi

if [ "$1" == "update" ]; then
    docker-compose down
    docker-compose pull && docker-compose up -d
fi

if [ "$1" == "setup" ]; then
  echo 'Updating system...' \
  && apt upgrade -y \
  && rm -rf ghost; git clone https://github.com/clean-docker/ghost-cms ghost \
  && cd ghost \
  && sed -e "s/<domain>/$2/g" docker-compose.yml \
  && sed -e "s/<domain>/$2/g" nginx/default.conf \
  && sed -e "s/<domain>/$2/g" config.production.json \
  && echo 'Installing SSL...' \
  && sudo apt install software-properties-common -y \
  && sudo add-apt-repository ppa:certbot/certbot -y \
  && sudo apt update -y \
  && sudo apt install certbot -y \
  && sudo certbot certonly --standalone -d $2 \
  && echo 'Installing Docker...' \
  && apt install apt-transport-https ca-certificates curl software-properties-common gnupg -y \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
  && apt-key fingerprint 0EBFCD88 \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y \
  && apt update -y \
  && apt-get install docker-ce docker-ce-cli containerd.io -y \
  && echo 'Installing Docker Compose...' \
  && curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose \
  && echo 'Preparing Ghost...' \
  && mkdir ./content; mkdir ./mysql; mkdir -p /usr/share/nginx/html;
  echo 'Configuring cron...' \
  && echo "0 23 * * * certbot certonly -n --webroot -w /usr/share/nginx/html -d $2 --deploy-hook='docker exec ghost_nginx_1 nginx -s reload'" >> mycron \
  && crontab mycron; rm mycron \
  && echo 'Starting Docker...' \
  && docker-compose up -d \
  && echo 'Done! 🎉' \
  && echo 'by Rafael Correa Gomes' \
  && echo 'Access your host: https://'; echo $2;
fi
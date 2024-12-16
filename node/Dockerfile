FROM node:18-slim

RUN apt-get update && apt-get install curl -y

ENV APP_ROOT /src
WORKDIR ${APP_ROOT}
ADD . ${APP_ROOT}

RUN npm install

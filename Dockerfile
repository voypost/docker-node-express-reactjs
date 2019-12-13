FROM node:12-alpine

ONBUILD ARG NODE_ENV=development

RUN mkdir -p /usr/app
WORKDIR /usr/app

ONBUILD COPY package.json yarn.lock .npmrc .yarnrc ./
ONBUILD RUN sh -c "[ \"$NODE_ENV\" == \"production\" ] \
    && yarn install --prod \
    || yarn install"

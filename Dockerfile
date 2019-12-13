FROM node:12-alpine

ONBUILD ARG NODE_ENV=development

RUN mkdir -p /usr/app
WORKDIR /usr/app

ONBUILD COPY --from=installer /usr/app/node_modules ./node_modules
ONBUILD COPY --from=builder /usr/app/lib ./lib
ONBUILD COPY --from=builder /usr/app/build ./build
ONBUILD COPY package.json yarn.lock ./

ONBUILD ENV NODE_ENV=${NODE_ENV}

CMD ["yarn", "serve"]

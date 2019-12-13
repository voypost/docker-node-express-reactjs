FROM node:12-alpine

ONBUILD ARG NODE_ENV=development

ONBUILD ARG RUN_ESLINT=false
ONBUILD ARG RUN_JEST=false

RUN mkdir -p /usr/app
WORKDIR /usr/app

ONBUILD COPY --from=installer /usr/app/node_modules ./node_modules
ONBUILD COPY --from=installer /usr/app/package.json ./
ONBUILD COPY --from=installer /usr/app/yarn.lock ./
ONBUILD COPY --from=installer /usr/app/.npmrc ./
ONBUILD COPY --from=installer /usr/app/.yarnrc ./
ONBUILD RUN NODE_ENV=development yarn install

ONBUILD COPY babel.config.js jest.config.js .env.test .env.test.server .eslintrc.js .eslintignore ./
ONBUILD COPY public ./public
ONBUILD COPY src ./src
ONBUILD COPY server ./server
ONBUILD COPY tests ./tests

# Run ESLint
ONBUILD RUN sh -c "if [ $RUN_ESLINT == true ]; then yarn lint; else true; fi"

# Run Jest
ONBUILD RUN sh -c "if [ $RUN_JEST == true ]; then yarn test; else true; fi"

ONBUILD RUN NODE_ENV=$NODE_ENV yarn build

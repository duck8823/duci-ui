FROM node:8 AS build
MAINTAINER shunsuke maeda <duck8823@gmail.com>

RUN npm install -g yarn

WORKDIR /tmp/workdir

ADD . .

RUN yarn install
RUN yarn build

FROM node:8-alpine

WORKDIR /app

ADD package.json ./
ADD nuxt.config.js ./

COPY --from=build /tmp/workdir/node_modules ./node_modules/
COPY --from=build /tmp/workdir/.nuxt ./.nuxt/
COPY --from=build /tmp/workdir/static ./static/

ENV HOST=0.0.0.0

EXPOSE 3000

ENTRYPOINT ["yarn", "start"]

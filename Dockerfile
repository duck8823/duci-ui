FROM node:8
MAINTAINER shunsuke maeda <duck8823@gmail.com>

RUN npm install -g yarn

WORKDIR /tmp/workdir

ADD . .

RUN yarn install
RUN yarn build

EXPOSE 3000

ENTRYPOINT ["yarn"]
CMD ["start"]

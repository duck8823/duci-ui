FROM node:8
MAINTAINER shunsuke maeda <duck8823@gmail.com>

RUN npm install -g yarn

WORKDIR /tmp/workdir

COPY . .

RUN yarn install

ENTRYPOINT ["yarn"]
CMD ["build"]

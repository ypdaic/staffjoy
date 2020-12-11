FROM node:9.2.1-alpine as builder

# Install base packages and set timezone ShangHai
RUN apk update && apk add bash tzdata \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR '/build'
COPY app ./app
COPY resources ./resources
COPY third_party ./third_party

WORKDIR '/build/app'

RUN npm install
RUN npm rebuild node-sass
RUN npm run build

RUN ls /build/app/dist

FROM nginx
EXPOSE 80
COPY --from=builder /build/app/dist /usr/share/nginx/html



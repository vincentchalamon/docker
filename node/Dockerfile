ARG NODE_VERSION="${NODE_VERSION:-11.6.0}"
FROM mhart/alpine-node:${NODE_VERSION}

RUN apk add --no-cache ca-certificates; \
    npm i -g swagger-cli

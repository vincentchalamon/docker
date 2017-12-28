FROM alpine:3.5

RUN apk add --no-cache varnish

COPY start.sh /usr/local/bin/docker-app-start
COPY default.vcl /etc/varnish/default.vcl

RUN chmod +x /usr/local/bin/docker-app-start

CMD ["docker-app-start"]

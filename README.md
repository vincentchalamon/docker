This repository provides Docker images for PHP projects.

Here is an example of a `docker-compose.yml`:

```yml
version: '3'

services:
  app:
    image: vincentchalamon/php:7.2-dev
    volumes:
      - ./:/app:rw

  nginx:
    image: nginx:1.11-alpine
    volumes:
      - ./docker/nginx/conf.d:/etc/nginx/conf.d:ro
      - ./public:/app/public:ro
    ports:
      - 80:80

  varnish:
    image: vincentchalamon/varnish:4.1
    depends_on:
      - app
    ports:
      - 8000:80
```

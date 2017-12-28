This repository provides Docker images.

Here is an example of a `docker-compose.yml`:

```yml
version: '3'

services:
  app:
    image: vincentchalamon/php:7.2
    depends_on:
      - db
    env_file:
      - .env
    volumes:
      - $HOME/.composer/cache:/root/.composer/cache
      - ./:/app:rw
      - /app/var/cache
      - /app/var/log

  db:
    image: healthcheck/mysql
    environment:
      - MYSQL_DATABASE=database
      - MYSQL_ROOT_PASSWORD=password
    volumes:
      - db-data:/var/lib/mysql:rw
    ports:
      - 3306:3306

  nginx:
    image: nginx:1.11-alpine
    volumes:
      - ./docker/nginx/conf.d:/etc/nginx/conf.d:ro
      - ./public:/app/public:ro
    ports:
      - 80:80

  varnish:
    image: interdrinks/varnish:4-alpine
    depends_on:
      - app
    ports:
      - 8000:80

volumes:
  db-data: {}
```

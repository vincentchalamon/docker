A Dockerfile implementing php:7.1-fpm-alpine with dependencies for PHP projects.

**This configuration is built for development. It is not recommended to use it in production.**

## Installation

Run following command to build & run container:

```bash
docker run -d -p 9000:9000 vincentchalamon/php:7.1-dev
```

## Configuration

Want to integrate it with MySql? Let's use [Docker Compose](https://docs.docker.com/compose/).

Create `docker-compose.yml` file as following:

```yml
version: '3'

services:
  app:
    image: vincentchalamon/php:7.1-dev
    depends_on:
      - db
    volumes:
      - ./:/var/www:rw

  db:
    image: mysql:5.7
    environment:
      MYSQL_DATABASE: foo
      MYSQL_ROOT_PASSWORD: bar
    volumes:
      - db-data:/var/lib/mysql:rw
    ports:
      - 3306:3306

  nginx:
    image: nginx:alpine
    ports:
      - 80:80

volumes:
  db-data: {}
```

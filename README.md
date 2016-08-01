# Docker Symfony

A Dockerfile for [Symfony](http://symfony.com/) Web container: Nginx, PHP-FPM…

This image is ready for MySQL, SQLite & PostgreSQL. Feel free to connect with your required database system.

**This configuration is built for development. You can use it in production at your own risks !**

## Installation

Run following command to build & run container:

```
docker run -d -p 80:80 vincentchalamon/symfony
```

To install a specific tag, for example `wheezy-php55`, run:

```
docker run -d -p 80:80 vincentchalamon/symfony:wheezy-php55
```

Your project is available at [http://127.0.0.1](http://127.0.0.1).

## Configuration

Want to integrate it with MySql? Let's use [Docker Compose](https://docs.docker.com/compose/).

Create `docker-compose.yml` file as following:

```yml
web:
    image: vincentchalamon/symfony
    volumes:
        - .:/var/www

mysql:
    image: mysql
    environment:
        MYSQL_DATABASE: "symfony"
        MYSQL_USER: "root"
        MYSQL_ROOT_PASSWORD: "root"
```

Then run `docker-compose up -d`, your Symfony project is ready to access MySQL through `127.0.0.1:3306`.

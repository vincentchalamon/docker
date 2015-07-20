# Docker Symfony

A Dockerfile for [Symfony](http://symfony.com/) Web container: Nginx, PHP-FPM…

**This configuration is built for development. You can use it in production at your own risks !**

[Don't know Docker yet ?](http://blog.vincent-chalamon.fr/docker/)

## Installation

Install [Docker](https://www.docker.com/) ([Boot2docker](http://boot2docker.io/) or [Kitematic](https://kitematic.com/) for OS X & Windows).

Then, run following command to run container:

```
docker run -d -P vincentchalamon/symfony
```

Your project is available at [http://127.0.0.1](http://127.0.0.1) (for Boot2docker, follow [http://192.168.59.103](http://192.168.59.103)).

## Configuration

Want to integrate it with MySql ? I recommand to use [Docker Compose](https://docs.docker.com/compose/).

Create `docker-compose.yml` file as following:

```yml
web:
    image: vincentchalamon/symfony
    volumes:
        - .:/var/www
    net: "host"
    tty: true

mysql:
    image: mysql
    net: "host"
    environment:
        MYSQL_DATABASE: symfony
        MYSQL_USER: root
        MYSQL_ALLOW_EMPTY_PASSWORD: yes
```

Then run `docker-compose up -d`, your Symfony project is ready to access MySql through `127.0.0.1:3306`.

## Customize ports

By default, _web_ container run on port 80, _mysql_ container on port 3306. But in some case (for example to prevent ports conflicts on Linux),
you may need to use customize ports.

Let's imagine we'll run Nginx on port 8888, and MySql on port 3386. Update your `docker-compose.yml` file as following:

```yml
web:
    image: vincentchalamon/docker-symfony
    ports:
        - 8888:80
    volumes:
        - .:/var/www
    tty: true

db:
    image: mysql
    command: mysqld --port 3386
    net: "host"
    environment:
        MYSQL_DATABASE: erb_api
        MYSQL_USER: root
        MYSQL_ALLOW_EMPTY_PASSWORD: yes
```

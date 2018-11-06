FROM composer:latest as composer
FROM php:5.6-fpm-alpine

ARG MONGODB_VERSION=1.5.3
ARG APCU_VERSION=4.0.11

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY php.ini /usr/local/etc/php/php.ini
COPY php-fpm.conf /usr/local/etc/php-fpm.d/php-fpm.conf
COPY healthcheck /usr/local/bin/healthcheck

WORKDIR /app

RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps \
        fcgi \
        git \
        icu-libs \
        zlib \
        postgresql-client \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev \
        zlib-dev \
        postgresql-dev \
        sqlite-dev \
    && docker-php-ext-install \
        intl \
        pgsql \
        pdo_pgsql \
        pdo_mysql \
        pdo_sqlite \
        zip \
    && pecl install \
        apcu-${APCU_VERSION} \
        mongodb-${MONGODB_VERSION} \
    && docker-php-ext-enable \
        apcu \
        opcache \
        mongodb \
    && apk del .build-deps \
    && composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --optimize-autoloader --classmap-authoritative \
    && composer clear-cache \
    && chmod +x /usr/local/bin/healthcheck \
    && wget https://github.com/jwilder/dockerize/releases/download/v0.3.0/dockerize-linux-amd64-v0.3.0.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.3.0.tar.gz \
    && rm dockerize-linux-amd64-v0.3.0.tar.gz

HEALTHCHECK CMD /usr/local/bin/healthcheck

CMD ["php-fpm"]

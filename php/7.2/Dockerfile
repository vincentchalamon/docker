FROM composer:latest as composer
FROM php:7.2-fpm-alpine

ENV APCU_VERSION 5.1.8
# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY php.ini /usr/local/etc/php/php.ini
COPY docker-entrypoint.sh /usr/local/bin/docker-app-entrypoint

WORKDIR /app

RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps \
        git \
        icu-libs \
        zlib \
        git \
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
    && docker-php-ext-enable --ini-name 20-apcu.ini apcu \
    && docker-php-ext-enable --ini-name 05-opcache.ini opcache \
    && apk del .build-deps \
    && composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --optimize-autoloader --classmap-authoritative \
    && composer clear-cache \
    && mkdir -p var/cache var/log \
    && chmod -R 777 var \
    && chmod +x /usr/local/bin/docker-app-entrypoint

ENTRYPOINT ["/usr/local/bin/docker-app-entrypoint"]
CMD ["php-fpm"]

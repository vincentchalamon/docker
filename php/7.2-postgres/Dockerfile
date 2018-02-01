FROM php:7.2-fpm-alpine

ENV APCU_VERSION 5.1.8

COPY php.ini /usr/local/etc/php/php.ini

WORKDIR /app

RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps \
        icu-libs \
        zlib \
        postgresql-client \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev \
        zlib-dev \
        postgresql-dev \
    && docker-php-ext-install \
        intl \
        pgsql \
        pdo_pgsql \
        zip \
    && pecl install \
        apcu-${APCU_VERSION} \
    && docker-php-ext-enable \
        apcu \
        opcache \
    && apk del .build-deps \
    && mkdir -p var/cache var/log \
    && chmod -R 777 var

CMD ["php-fpm"]

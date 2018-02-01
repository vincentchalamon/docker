FROM php:7.1-fpm-alpine

ENV APCU_VERSION 5.1.8

COPY php.ini /usr/local/etc/php/php.ini

WORKDIR /app

RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps \
        icu-libs \
        zlib \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev \
        zlib-dev \
    && docker-php-ext-install \
        intl \
        pdo_mysql \
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

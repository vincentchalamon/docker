FROM php:7.1-fpm-alpine

ARG MONGODB_VERSION=1.5.3
ARG APCU_VERSION=5.1.8

COPY php.ini /usr/local/etc/php/php.ini
COPY php-fpm.conf /usr/local/etc/php-fpm.d/php-fpm.conf
COPY healthcheck /usr/local/bin/healthcheck

WORKDIR /app

RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps \
        fcgi \
        icu-libs \
        zlib \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev \
        zlib-dev \
    && docker-php-ext-install \
        intl \
        zip \
    && pecl install \
        apcu-${APCU_VERSION} \
        mongodb-${MONGODB_VERSION} \
    && docker-php-ext-enable \
        apcu \
        opcache \
        mongodb \
    && apk del .build-deps \
    && chmod +x /usr/local/bin/healthcheck

HEALTHCHECK CMD /usr/local/bin/healthcheck

CMD ["php-fpm"]

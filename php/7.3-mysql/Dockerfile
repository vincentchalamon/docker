FROM php:7.3-fpm-alpine

ARG APCU_VERSION=5.1.8
ARG REDIS_VERSION=4.2.0

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
        pdo_mysql \
        zip \
    && pecl install \
        apcu-${APCU_VERSION} \
        redis-${REDIS_VERSION} \
    && docker-php-ext-enable \
        apcu \
        opcache \
        redis \
    && apk del .build-deps \
    && chmod +x /usr/local/bin/healthcheck

HEALTHCHECK CMD /usr/local/bin/healthcheck

CMD ["php-fpm"]

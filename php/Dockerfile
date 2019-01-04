ARG PHP_VERSION="${PHP_VERSION:-7.3.0}"
FROM php:${PHP_VERSION}-fpm-alpine

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
        libzip-dev \
    && docker-php-ext-install \
        intl \
        pgsql \
        pdo_pgsql \
        pdo_mysql \
        pdo_sqlite \
        zip \
    && pecl install \
        apcu \
		mongodb \
		redis \
    && docker-php-ext-enable \
        apcu \
        opcache \
        mongodb \
        redis \
    && apk del .build-deps \
    && composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --optimize-autoloader --classmap-authoritative \
    && composer clear-cache \
    && chmod +x /usr/local/bin/healthcheck

HEALTHCHECK CMD /usr/local/bin/healthcheck

CMD ["php-fpm"]

FROM vincentchalamon/php:7.1-dev

RUN apk add --no-cache --virtual .build-deps make g++ autoconf \
    && docker-php-source extract \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable xdebug \
    && docker-php-source delete \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && rm -rf /tmp/pear \
    && apk del .build-deps

EXPOSE 9000

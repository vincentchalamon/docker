FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      git \
      curl \
      nginx \
      php5 \
      php5-curl \
      php5-fpm \
      php5-intl \
      php5-mysql \
      php5-memcache \
      supervisor \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM & Nginx
RUN sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf
RUN sed -e 's/;listen\.owner/listen.owner/' -i /etc/php5/fpm/pool.d/www.conf
RUN sed -e 's/;listen\.group/listen.group/' -i /etc/php5/fpm/pool.d/www.conf
RUN echo "opcache.enable=1" >> /etc/php5/mods-available/opcache.ini
RUN echo "opcache.enable_cli=1" >> /etc/php5/mods-available/opcache.ini
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD vhost.conf /etc/nginx/sites-available/default

RUN usermod -u 1000 www-data

VOLUME ["/var/www"]
WORKDIR /var/www

EXPOSE 80

CMD ["/usr/bin/supervisord"]

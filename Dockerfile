FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
      ca-certificates \
      git \
      curl \
      nginx \
      php5 \
      php-apc \
      php5-cli \
      php5-curl \
      php5-fpm \
      php5-intl \
      php5-json \
      php5-mysql \
      php5-memcache \
      --no-install-recommends \
      supervisor \
    && rm -rf /var/lib/apt/lists/*

RUN sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf
RUN sed -e 's/;listen\.owner/listen.owner/' -i /etc/php5/fpm/pool.d/www.conf
RUN sed -e 's/;listen\.group/listen.group/' -i /etc/php5/fpm/pool.d/www.conf
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN echo "apc.enabled=1" >> /etc/php5/conf.d/20-apc.ini
RUN echo "apc.stat=1" >> /etc/php5/conf.d/20-apc.ini

ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

ADD vhost.conf /etc/nginx/sites-available/default

RUN usermod -u 1000 www-data

VOLUME ["/var/www"]
WORKDIR /var/www

EXPOSE 80

CMD ["/usr/bin/supervisord"]

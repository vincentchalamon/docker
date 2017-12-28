#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- php-fpm "$@"
fi

# Detect the host IP
export DOCKER_BRIDGE_IP
DOCKER_BRIDGE_IP=$(ip ro | grep default | cut -d' ' -f 3)

# Permissions hack because setfacl does not work on Mac and Windows
chmod -R 777 var

exec docker-php-entrypoint "$@"

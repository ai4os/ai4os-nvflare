#!/bin/bash

# credits: https://github.com/Tecktron/docker-python-waitress

set -e

if [ -f /app/app/wsgi.py ]; then
    DEFAULT_MODULE_NAME=app.wsgi
elif [ -f /app/wsgi.py ]; then
    DEFAULT_MODULE_NAME=wsgi
fi
MODULE_NAME=${MODULE_NAME:-$DEFAULT_MODULE_NAME}
VARIABLE_NAME=${VARIABLE_NAME:-application}
export APP_MODULE=${APP_MODULE:-"$MODULE_NAME:$VARIABLE_NAME"}

# docker --env-file passes values verbatim, including any surrounding quotes
# (unlike docker-compose, which strips them). Newer waitress rejects a quoted
# module spec such as wsgi:"app", so strip stray quotes from APP_MODULE.
APP_MODULE=${APP_MODULE//\"/}
APP_MODULE=${APP_MODULE//\'/}
export APP_MODULE

exec "$@"


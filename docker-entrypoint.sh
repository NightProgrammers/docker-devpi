#!/usr/bin/env bash

function initialize {
    echo "[RUN]: Initialise devpi-server"
    devpi-server --restrict-modify root --start --host 127.0.0.1 --port 4040 --init
    devpi-server --status
    devpi use http://localhost:4040
    devpi login root --password ''
    devpi user -m root password="${DEVPI_PASSWORD}"
    devpi index -y -c public pypi_whitelist='*'
    devpi-server --stop
    devpi-server --status
}

function defaults {
    : ${DEVPI_SERVERDIR="/data/server"}
    : ${DEVPI_CLIENTDIR="/data/client"}

    echo "DEVPI_SERVERDIR is ${DEVPI_SERVERDIR}"
    echo "DEVPI_CLIENTDIR is ${DEVPI_CLIENTDIR}"

    export DEVPI_SERVERDIR DEVPI_CLIENTDIR
}

defaults

if [ "$1" = 'devpi' ]; then
    if [ ! -f  $DEVPI_SERVERDIR/.serverversion ]; then
        initialize
    fi

    echo "[RUN]: Launching devpi-server"
    exec devpi-server --restrict-modify root --host 0.0.0.0 --port 4040
fi

echo "[RUN]: Builtin command not provided [devpi]"
echo "[RUN]: $@"

exec "$@"

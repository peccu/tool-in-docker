#!/bin/bash

if [ \
     -z "${TUNNEL_TARGET_HOST:-}" \
        -o -z "${TUNNEL_TARGET_PORT:-}" \
        -o -z "${TUNNEL_BASTION_HOST:-}" \
    ]
then
    echo "Must provide following environments" 1>&2
    echo 1>&2
    echo "  TUNNEL_LOCAL_PORT   : local tunnel port (default 8080)" 1>&2
    echo "  TUNNEL_TARGET_HOST  : target host" 1>&2
    echo "  TUNNEL_TARGET_PORT  : target port" 1>&2
    echo "  TUNNEL_BASTION_HOST : bastion ssh host" 1>&2
    echo 1>&2
    echo "local pc -- TUNNEL_LOCAL_PORT -- TUNNEL_BASTION_HOST -- TUNNEL_TARGET_HOST:TUNNEL_TARGET_PORT" 1>&2
    exit 1
fi

ssh \
    -v \
    -4 \
    -N \
    -L 0.0.0.0:${TUNNEL_LOCAL_PORT:=8080}:${TUNNEL_TARGET_HOST}:${TUNNEL_TARGET_PORT} \
    ${TUNNEL_BASTION_HOST}

#!/bin/bash
# -*- shell-script -*-
# docker-compose.yml's path
BASEDIR=~/Codes/tool-in-docker
NAME=tool-in-docker
source $BASEDIR/.tool_functions.sh

# try exec or up and exec if failed in 10 seconds
# ignore when execed after 10 seconds
restarttime=10
launch=$(date "+%s")
wd=$(pwd)

docker_exec "$wd" "$@" \
    && : \
    || (\
        inShortTime $launch $restarttime \
            && docker_compose_up-d app \
            && docker_exec "$wd" "$@"\
       )

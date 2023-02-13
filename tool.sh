#!/bin/bash
# -*- shell-script -*-
# docker-compose.yml's path
BASEDIR=~/Codes/tool-in-docker
NAME=tool-in-docker
COMPOSE_FILE_PATH=$BASEDIR/docker-compose.yml

function docker_compose_up-d(){
    docker-compose \
        -f ${COMPOSE_FILE_PATH} \
        up -d
}

function docker_exec(){
    docker exec \
           -it \
           -e LINES="`tput lines`" \
           -e COLUMNS="`tput cols`" \
           $NAME \
           /usr/local/bin/bash "$@"
    #      ^ is 5.2 for zoxide's <Space>+<Tab> Shortcut key
    #      /bin/bash

    # 履歴検索がまだ
    # /usr/bin/zsh
}

# try exec or up and exec if failed
docker_exec "$@" && : || (docker_compose_up-d && docker_exec "$@")

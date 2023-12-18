#!/bin/bash
# -*- shell-script -*-
# docker-compose.yml's path
BASEDIR=~/Codes/tool-in-docker
NAME=tool-in-docker
COMPOSE_FILE_PATH=$BASEDIR/docker-compose.yml

function docker_compose_up-d(){
    docker compose \
        -f ${COMPOSE_FILE_PATH} \
        up -d
}

function docker_exec(){
    wd=$1
    shift
    docker exec \
           -w $wd \
           -it \
           --user "$(id -u):$(id -g)" \
           -e LINES="`tput lines`" \
           -e COLUMNS="`tput cols`" \
           $NAME \
           /usr/local/bin/bash "$@"
    #      ^ is 5.2 for zoxide's <Space>+<Tab> Shortcut key
    #      /bin/bash

    # 履歴検索がまだ
    # /usr/bin/zsh
}

function inShortTime(){
    local launch=$1
    local restarttime=$2
    [ $(($(date +%s) - launch)) -lt $restarttime ]
}

# try exec or up and exec if failed in 10 seconds
# ignore when execed after 10 seconds
restarttime=10
launch=$(date "+%s")
wd=$(pwd | sed "s|$(echo $(cd;pwd))|/home/user|")

docker_exec "$wd" "$@" \
    && : \
    || (\
        inShortTime $launch $restarttime \
            && docker_compose_up-d \
            && docker_exec "$wd" "$@"\
       )

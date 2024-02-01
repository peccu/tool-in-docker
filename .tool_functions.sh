#!/bin/bash
# -*- shell-script -*-
COMPOSE_FILE_PATH=$BASEDIR/docker-compose.yml
COMPOSE_FILE2_PATH=$BASEDIR/docker-compose-ext.yml

function docker_compose(){
    if [ -f ${COMPOSE_FILE2_PATH} ]
    then
        docker compose \
               -f ${COMPOSE_FILE_PATH} \
               -f ${COMPOSE_FILE2_PATH} \
               "$@"
    else
        docker compose \
               -f ${COMPOSE_FILE_PATH} \
               "$@"
    fi
}

function docker_compose_up-d(){
    docker_compose up -d "$@"
}

function _docker_exec(){
    gid=$1
    shift
    shellpath=$1
    shift
    wd=$1
    shift
    docker exec \
           -w $wd \
           -it \
           --user "$(id -u):${gid}" \
           -e LINES="`tput lines`" \
           -e COLUMNS="`tput cols`" \
           $NAME \
           $shellpath "$@"
}

function docker_exec(){
    wd=$1
    shift
    # for dind
    gid=docker
    _docker_exec $gid /usr/local/bin/bash "$wd"
    #                 ^ is 5.2 for zoxide's <Space>+<Tab> Shortcut key
    #                 /bin/bash

    # zshは履歴検索がまだ
    # /usr/bin/zsh
}

function inShortTime(){
    local launch=$1
    local restarttime=$2
    [ $(($(date +%s) - launch)) -lt $restarttime ]
}

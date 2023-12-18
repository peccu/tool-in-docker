#!/bin/bash
# -*- shell-script -*-
# docker-compose.yml's path
BASEDIR=~/Codes/tool-in-docker
NAME=tool-in-docker-dind
source $BASEDIR/.tool_functions.sh

docker_compose \
    build \
    --build-arg username=$(basename $HOME) \
    --build-arg homedir=$(dirname $HOME)

docker_compose down
docker_compose up -d

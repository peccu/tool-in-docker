# tool-in-docker

The container already installed some useful tools.

When I use this container, I can use same toolset in various environment like WSL, CodeSandbox, CodeSpaces or so.

## Initialize

```bash
# pull from docker hub (or you canuse github packages: ghcr.io/peccu/tool-in-docker)
docker pull peccu/tool-in-docker
# launch with home direcory
docker run -d --name tool -v $HOME:/root peccu/tool-in-docker
```

## Usage

```bash
docker exec -it tool /usr/local/bin/bash
```

## Installed tools

WIP

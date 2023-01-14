# tool-in-docker

The container already installed some useful tools.

When I use this container, I can use same toolset in various environment like WSL, CodeSandbox, CodeSpaces or so.

## Initialize

```bash
# pull from docker hub
docker pull peccu/tool-in-docker
# or from github packages
docker pull ghcr.io/peccu/tool-in-docker
# launch with home direcory
docker run -d --name tool -v $HOME:/root peccu/tool-in-docker
```

## Usage

```bash
docker exec --entrypoint /usr/local/bin/bash tool
```

## Installed tools

WIP

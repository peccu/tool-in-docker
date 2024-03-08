##################################################
FROM ubuntu:22.04 as base
##################################################

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
    curl

# support variables
ENV GH=https://github.com
ENV GHAPI=https://api.github.com
ENV GHREPO=${GHAPI}/repos
ENV RD=releases/download
ENV RLD=releases/latest/download
ENV RL=releases/latest

# binary output directory
ENV OUT=/a
RUN mkdir -p $OUT

## other branch's space
## other branch's space

##################################################
FROM base as build
##################################################

# tmux : terminal multiplexer
# some package depends on tzdata so need to specify TZ
# https://serverfault.com/a/1016972
ENV TZ=Asia/Tokyo
ENV V=3.3a
ENV A=tmux-${V}
ENV GU=tmux/tmux
# (sort-packages-in-dockerfile)
RUN apt-get install -y \
    bison \
    build-essential \
    libevent-dev \
    ncurses-dev \
    pkg-config \
    && echo installed

ADD ${GH}/${GU}/${RD}/${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xf ${A}.tar.gz \
    && cd ${A} \
    && ./configure --enable-static \
    && make -j$(nproc) \
    && make install \
    && mv /usr/local/bin/tmux ${OUT} \
    && rm -rf /tmp/${A}

# reptyr : re-attach disowned process
# USAGE: reptyr PID
ENV V=0.9.0
ENV A=reptyr-${V}
ENV GU=nelhage/reptyr
ADD ${GH}/${GU}/archive/refs/tags/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xf ${A}.tar.gz \
    && cd reptyr-${A} \
    && make -j$(nproc) \
    && mv reptyr ${OUT} \
    && rm -rf /tmp/${A}

# datamash : ? csv aggregator ?
ENV V=1.8
ENV A=datamash-${V}
ADD http://ftp.gnu.org/gnu/datamash/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}.tar.gz \
    && cd ${A} \
    && ./configure \
    && make -j$(nproc) \
    && make install \
    && mv /usr/local/bin/datamash ${OUT} \
    && rm -rf /tmp/${A}

# bash 5.2 : newer version for zoxide <Space>+<Tab> key
# with curses option is for readline's "horizontal-scroll off"
# ref. https://lists.gnu.org/archive/html/bug-readline/2015-11/msg00006.html
ENV V=5.2
ENV A=bash-${V}
# RUN apt-get install libncurses5-dev
ADD http://ftp.gnu.org/gnu/bash/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xf ${A}.tar.gz \
    && cd ${A} \
    && ./configure --with-curses \
    && make -j$(nproc) \
    && make install \
    && mv /usr/local/bin/bash ${OUT} \
    && rm -rf /tmp/${A}

## other branch's space
## other branch's space

##################################################
FROM base as bin
##################################################

#------------------
# Archived binary
#------------------
RUN apt-get install -y p7zip-full

# ripgrep : grep alternative
# https://github.com/BurntSushi/ripgrep/releases
ENV V=14.1.0
ENV A=ripgrep-${V}-x86_64-unknown-linux-musl
ENV B=${A}/rg
ENV GU=BurntSushi/ripgrep
ADD ${GH}/${GU}/${RD}/${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}* \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# delta : for git diff
ENV V=0.16.5
ENV GU=dandavison/delta
ENV A=delta-${V}-x86_64-unknown-linux-gnu
# muls version for amazon linux?
# ENV A=delta-${V}-x86_64-unknown-linux-musl
ENV B=${A}/delta
ADD ${GH}/${GU}/${RD}/${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}* \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# unison : bi directonal file sync
# https://github.com/bcpierce00/unison/releases
ENV V=2.53.3
ENV A=unison-${V}-ubuntu-x86_64
ENV GU=bcpierce00/unison
ENV B=bin/unison
ADD ${GH}/${GU}/${RD}/v${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}* \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# atuin : ?
ENV V=v12.0.0
ENV A=atuin-${V}-x86_64-unknown-linux-gnu
ENV GU=ellie/atuin
ENV B=${A}/atuin
ADD ${GH}/${GU}/${RD}/${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}.tar.gz \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# fzf : fuzzy search. mainly used in history search (C-r)
ENV V=0.46.0
ENV A=fzf-${V}-linux_amd64
ENV GU=junegunn/fzf
ENV B=fzf
ADD ${GH}/${GU}/${RD}/${V}/${A}.tar.gz /tmp/${A}/
ADD ${GH}/${GU}/raw/${V}/bin/fzf-tmux ${OUT}/
RUN cd /tmp/${A} \
    && tar xzf ${A}.tar.gz \
    && mv ${B} ${OUT} \
    && chmod +x ${OUT}/fzf-tmux \
    && rm -rf /tmp/${A}

# skim : fuzzy search ?
ENV V=v0.9.4
ENV A=skim-${V}-x86_64-unknown-linux-musl
ENV GU=lotabout/skim
ENV B=sk
ADD ${GH}/${GU}/${RD}/${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}.tar.gz \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# xsv : csv tool
ENV V=0.13.0
ENV A=xsv-${V}-x86_64-unknown-linux-musl
ENV GU=BurntSushi/xsv
ENV B=xsv
ADD ${GH}/${GU}/${RD}/${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}.tar.gz \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# bat : cat alternative
ENV V=v0.22.1
ENV A=bat-${V}-x86_64-unknown-linux-musl
ENV GU=sharkdp/bat
ENV B=${A}/bat
ADD ${GH}/${GU}/${RD}/${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}.tar.gz \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# fd : find alternative
ENV V=v8.6.0
ENV A=fd-${V}-x86_64-unknown-linux-musl
ENV GU=sharkdp/fd
ENV B=${A}/fd
ADD ${GH}/${GU}/${RD}/${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}.tar.gz \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# jless : less command for JSON
ENV V=v0.8.0
ENV A=jless-${V}-x86_64-unknown-linux-gnu
ENV GU=PaulJuliusMartinez/jless
ENV B=jless
ADD ${GH}/${GU}/${RD}/${V}/${A}.zip /tmp/${A}/
RUN cd /tmp/${A} \
    && 7za x ${A}.zip \
    && chmod +x jless \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

## CloudFormation related
# rain : Cfn support tool
# https://github.com/aws-cloudformation/rain
ENV V=v1.7.5
ENV A=rain-${V}_linux-amd64
ENV GU=aws-cloudformation/rain
ENV B=${A}/rain
ADD ${GH}/${GU}/${RD}/${V}/${A}.zip /tmp/${A}/
RUN cd /tmp/${A} \
    && 7za x ${A}.zip \
    && mv ${B} ${OUT} \
    && rm -rf ${A} ${A}.zip \
    && ${OUT}/rain --version
# bash completions for rain
ADD ${GH}/aws-cloudformation/rain/raw/${V}/docs/bash_completion.sh /usr/share/bash-completion/completions/rain

# cfn-skeleton : Cfn template builder
# https://github.com/awslabs/aws-cloudformation-template-builder
ENV V=v0.2.0
ENV A=cfn-skeleton-${V}_linux-amd64
ENV GU=awslabs/aws-cloudformation-template-builder
ENV B=${A}/cfn-skeleton
ADD ${GH}/${GU}/${RD}/${V}/${A}.zip /tmp/${A}/
RUN cd /tmp/${A} \
    && 7za x ${A}.zip \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# cfn-format : Cfn template formatter
# https://github.com/awslabs/aws-cloudformation-template-formatter
ENV V=v1.1.2-1
ENV A=cfn-format-${V}_linux-amd64
ENV GU=awslabs/aws-cloudformation-template-formatter
ENV B=${A}/cfn-format
ADD ${GH}/${GU}/${RD}/${V}/${A}.zip /tmp/${A}/
RUN cd /tmp/${A} \
    && 7za x ${A}.zip \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# zoxide : auto jump history
ENV V=0.9.0
ENV A=zoxide-${V}-x86_64-unknown-linux-musl
ENV GU=ajeetdsouza/zoxide
ENV B=zoxide
ADD ${GH}/${GU}/${RD}/v${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xzf ${A}.tar.gz \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# watchexec : watch file event and exec command
ENV V=1.21.0
ENV A=watchexec-${V}-x86_64-unknown-linux-musl
ENV GU=watchexec/watchexec
ENV B=watchexec
ADD ${GH}/${GU}/${RD}/v${V}/${A}.tar.xz /tmp/${A}/
RUN cd /tmp/${A} \
    && 7za x ${A}.tar.xz \
    && tar xf ${A}.tar \
    && cd ${A} \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# ncdu : NCurses Disk Usage
ENV V=2.2.1
ENV A=ncdu-${V}-linux-x86_64
ENV B=ncdu
ADD https://dev.yorhel.nl/download/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && tar xf ${A}.tar.gz \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# terraform : IaC
ENV V=1.7.0
ENV A=terraform_${V}_linux_amd64.zip
ADD https://releases.hashicorp.com/terraform/${V}/${A} /tmp/${A}
RUN cd ${OUT} \
    && 7za x /tmp/${A} \
    && rm -rf /tmp/${A}

# GitHub CLI
ENV V=2.42.1
ENV A=gh_${V}_linux_amd64
ENV GU=cli/cli
ENV B=${A}/bin/gh
ADD ${GH}/${GU}/${RD}/v${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && 7za x ${A}.tar.gz \
    && tar xf ${A}.tar \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# csvlens : csv less tool
# https://github.com/YS-L/csvlens
ENV V=0.6.0
ENV A=csvlens-x86_64-unknown-linux-gnu
ENV GU=YS-L/csvlens
ENV B=csvlens
ADD ${GH}/${GU}/${RD}/v${V}/${A}.tar.xz /tmp/${A}/
RUN cd /tmp/${A} \
    && 7za x ${A}.tar.xz \
    && tar xf ${A}.tar \
    && cd ${A} \
    && mv ${B} ${OUT} \
    && rm -rf /tmp/${A}

# glow : Render markdown and stash them
# https://github.com/charmbracelet/glow
ENV V=1.5.1
ENV A=glow_Linux_x86_64
ENV GU=charmbracelet/glow
ENV B=glow
ADD ${GH}/${GU}/${RD}/v${V}/${A}.tar.gz /tmp/${A}/
RUN cd /tmp/${A} \
    && 7za x ${A}.tar.gz \
    && tar xf ${A}.tar \
    && mv ${B} ${OUT} \
    && mv completions/glow.bash /usr/share/bash-completion/completions/ \
    && rm -rf /tmp/${A}

#---------------
# Direct binary
#---------------

# jd : ?
ENV V=v1.6.1
ENV A=jd-amd64-linux
ENV B=jd
ENV GU=josephburnett/jd
ADD ${GH}/${GU}/${RD}/${V}/${A} ${OUT}/${B}
RUN chmod +x ${OUT}/${B}

# tailwindcss : Tailwind CSS Standalone CLI
ENV A=tailwindcss-linux-x64
ENV B=tailwindcss
ENV GU=tailwindlabs/tailwindcss
ADD ${GH}/${GU}/${RLD}/${A} ${OUT}/${B}
RUN chmod +x ${OUT}/${B}

# jq : json query
ENV V=1.6
ENV A=jq-linux64
ENV B=jq
ENV GU=jqlang/jq
ADD ${GH}/${GU}/${RD}/jq-${V}/${A} ${OUT}/${B}
RUN chmod +x ${OUT}/${B}

## other branch's space
## other branch's space

##################################################
FROM golang:latest as go
##################################################

# git-xlsx-textconv : git diff xlsx file
# https://stackoverflow.com/a/72742770
ENV GOPROXY=direct
RUN go install -v github.com/tokuhirom/git-xlsx-textconv@latest

## other branch's space
## other branch's space

##################################################
FROM rust:slim as rust
##################################################

# the-way : snippet manager
RUN cargo install the-way

## other branch's space
## other branch's space

##################################################
FROM base as dind
##################################################

# install tools from apt
# |> bash-completion : completions
# |> dnsutils (dig, nslookup)
# |> groff (for aws help)
# |> iputils-ping (ping)
# |> libxcb-shape0 (for jless deps)
# |> nkf
# |> p7zip-full (7za)
# |> psmisc (for pstree)
# |> pv : progress viewer
# |> rsync
# |> sudo
# |> unzip : for bun installation
# sort packages (ignore first line (apt-get) and last line (echo))
# (sort-packages-in-dockerfile)
RUN apt-get install -y \
    bash-completion \
    dnsutils \
    groff \
    iputils-ping \
    libxcb-shape0 \
    nkf \
    p7zip-full \
    psmisc \
    pv \
    rsync \
    sudo \
    unzip \
    && echo installed

# not installed packages
# do I use them?
# list from amazon linux 2 yum pakage
# need to update the pakage name
# bc
# emacs-nox
# libevent
# nmap
# python3-pip
# whois
# zsh

# docker
# Add Docker's official GPG key:
RUN apt-get install -y \
    ca-certificates \
    gnupg \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
    > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin

# setup locale en_US.UTF-8
# https://stackoverflow.com/a/55077451
RUN apt-get install -y \
    locales \
    && locale-gen en_US.UTF-8 \
    && echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    && echo "LANG=en_US.UTF-8" > /etc/locale.conf

# aws cli
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
ENV A=awscli-exe-linux-x86_64.zip
ADD https://awscli.amazonaws.com/${A} /${A}
RUN 7za x /${A} \
    && ./aws/install \
    && rm -rf /${A} ./aws

# aws cli session manager plugin
# uninstall via dpkg -r session-manager-plugin
# session-manager-plugin command is for verify installation
ENV A=session-manager-plugin.deb
ADD https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/${A} /${A}
RUN dpkg -i /${A} \
    && rm /${A} \
    && session-manager-plugin

# aws sam cli
# sam --version command is for verify installation
ENV A=aws-sam-cli-linux-x86_64.zip
ENV GU=aws/aws-sam-cli
ADD ${GH}/${GU}/${RLD}/${A} /${A}
RUN 7za x -osam-installer ${A} \
    && ./sam-installer/install \
    && rm -rf sam-installer ${A} \
    && sam --version

# q : csv (text) query
ENV V=3.1.6
ENV A=q-text-as-data-${V}-1.x86_64.deb
ENV GU=harelba/q
ADD ${GH}/${GU}/${RD}/v${V}/${A} /${A}
RUN dpkg -i /${A} \
    && rm /${A}

# chezmoi : dotfiles manager
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

# bun : JavaScript and TypeScript toolkit
ENV V=1.0.25
RUN curl -fsSL https://bun.sh/install | bash -s "bun-v${V}" \
    && cd /usr/local/bin/ \
    && mv ~/.bun/bin/bun ./ \
    && ln -s bun bunx
ENV BUN_INSTALL_CACHE_DIR=/tmp/bun-cache

# # this needs python3-pip package and maybe dont used in current situation
# # install azure-cli percol, cfn-lint
# # stick urllib3's version to ignore OpenSSL version error
# # (sort-packages-in-dockerfile)
# RUN pip3 install \
#     azure-cli \
#     cfn-lint \
#     percol \
#     urllib3==1.26.6 \
#     && echo installed

# ansible : setup multiple environment
# https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu
RUN apt install -y \
    software-properties-common \
    && add-apt-repository --yes --update ppa:ansible/ansible \
    && apt install -y \
    ansible

# bruno : API testing (Re-Inventing the API Client)
RUN bun i -g @usebruno/cli

## other branch's space
## other branch's space

# copy from build layer
COPY --from=build ${OUT}/bash /usr/local/bin/
COPY --from=build ${OUT}/datamash /usr/local/bin/
COPY --from=build ${OUT}/reptyr /usr/local/bin/
COPY --from=build ${OUT}/tmux /usr/local/bin/
# copy from bin layer
COPY --from=bin ${OUT}/atuin /usr/local/bin/
COPY --from=bin ${OUT}/bat /usr/local/bin/
COPY --from=bin ${OUT}/cfn-format /usr/local/bin/
COPY --from=bin ${OUT}/cfn-skeleton /usr/local/bin/
COPY --from=bin ${OUT}/csvlens /usr/local/bin/
COPY --from=bin ${OUT}/delta /usr/local/bin/
COPY --from=bin ${OUT}/fd /usr/local/bin/
COPY --from=bin ${OUT}/fzf /usr/local/bin/
COPY --from=bin ${OUT}/fzf-tmux /usr/local/bin/
COPY --from=bin ${OUT}/gh /usr/local/bin/
COPY --from=bin ${OUT}/glow /usr/local/bin/
COPY --from=bin ${OUT}/jd /usr/local/bin/
COPY --from=bin ${OUT}/jless /usr/local/bin/
COPY --from=bin ${OUT}/jq /usr/local/bin/
COPY --from=bin ${OUT}/ncdu /usr/local/bin/
COPY --from=bin ${OUT}/rain /usr/local/bin/
COPY --from=bin ${OUT}/rg /usr/local/bin/
COPY --from=bin ${OUT}/sk /usr/local/bin/
COPY --from=bin ${OUT}/tailwindcss /usr/local/bin/
COPY --from=bin ${OUT}/terraform /usr/local/bin/
COPY --from=bin ${OUT}/unison /usr/local/bin/
COPY --from=bin ${OUT}/watchexec /usr/local/bin/
COPY --from=bin ${OUT}/xsv /usr/local/bin/
COPY --from=bin ${OUT}/zoxide /usr/local/bin/
COPY --from=bin /usr/share/bash-completion/completions/rain /usr/share/bash-completion/completions/
COPY --from=bin /usr/share/bash-completion/completions/glow.bash /usr/share/bash-completion/completions/
# copy from golang layer
COPY --from=go /go/bin/git-xlsx-textconv /usr/local/bin/
# copy from rust layer
COPY --from=rust /usr/local/cargo/bin/the-way /usr/local/bin/

# setup user environment
ARG username=user
ARG homedir=/mnt/c/Users
RUN mkdir -p ${homedir}
RUN groupadd -g 1000 ${username} \
    && useradd \
    -d ${homedir}/${username} \
    -g 1000 \
    -lMN \
    -s /usr/local/bin/bash \
    -u 1000 \
    ${username} \
    && echo "${username} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$(echo ${username} | sed 's/[.~]/_/g') \
    && chmod 0440 /etc/sudoers.d/$(echo ${username} | sed 's/[.~]/_/g')

# add user to docker group for access to docker
RUN usermod -a -G docker ${username}

USER ${username}
STOPSIGNAL SIGKILL
VOLUME ["${homedir}/${username}"]
WORKDIR ${homedir}/${username}
ENTRYPOINT ["/usr/bin/sleep", "infinity"]
# ENTRYPOINT ["/usr/local/bin/bash"]

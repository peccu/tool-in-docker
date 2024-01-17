##################################################
FROM ubuntu:22.04 as base
##################################################

RUN apt-get update
RUN apt-get install -y \
    curl

# support variables
ENV GH=https://github.com
ENV RD=releases/download

# binary output directory
ENV OUT=/a
RUN mkdir -p $OUT

## other branch's space
## other branch's space

##################################################
FROM base as build
##################################################

# tmux
ENV V=3.3a
# some package depends on tzdata so need to specify TZ
# https://serverfault.com/a/1016972
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV A=tmux-${V}
RUN apt-get install -y \
    libevent-dev \
    ncurses-dev \
    build-essential \
    bison \
    pkg-config
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/tmux/tmux/${RD}/${V}/${A}.tar.gz \
    && tar xf ${A}.tar.gz \
    && cd ${A} \
    && ./configure --enable-static \
    && make -j$(nproc) \
    && make install \
    && mv /usr/local/bin/tmux ${OUT} \
    && rm -rf /tmp/${A}

# reptyr PID
# re-attach disowned process
ENV V=0.9.0
ENV A=reptyr-${V}
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/nelhage/reptyr/archive/refs/tags/${A}.tar.gz \
    && tar xf ${A}.tar.gz \
    && cd reptyr-${A} \
    && make -j$(nproc) \
    && mv reptyr ${OUT} \
    && rm -rf /tmp/${A}

# install datamash
ENV V=1.8
ENV A=datamash-${V}
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO http://ftp.gnu.org/gnu/datamash/${A}.tar.gz \
    && tar xzf ${A}.tar.gz \
    && cd ${A} \
    && ./configure \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/${A}

# bash 5.2 for zoxide <Space>+<Tab>
# with curses option is for readline's "horizontal-scroll off"
# ref. https://lists.gnu.org/archive/html/bug-readline/2015-11/msg00006.html
ENV V=5.2
ENV A=bash-${V}
# RUN apt-get install libncurses5-dev
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO http://ftp.gnu.org/gnu/bash/${A}.tar.gz \
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

RUN apt-get install -y p7zip-full

# install ripgrep
# https://github.com/BurntSushi/ripgrep/releases
ENV V=14.1.0
ENV A=ripgrep-${V}-x86_64-unknown-linux-musl
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/BurntSushi/ripgrep/${RD}/${V}/${A}.tar.gz \
    && tar xzf ${A}* \
    && mv ${A}/rg ${OUT} \
    && rm -rf /tmp/${A}

# install delta for git
ENV V=0.16.5
ENV A=delta-${V}-x86_64-unknown-linux-gnu
# muls version
# ENV A=delta-${V}-x86_64-unknown-linux-musl
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/dandavison/delta/${RD}/${V}/${A}.tar.gz \
    && tar xzf ${A}* \
    && mv ${A}/delta ${OUT} \
    && rm -rf /tmp/${A}

# install unison (bi directonal sync)
# https://github.com/bcpierce00/unison/releases
ENV V=2.53.3
ENV A=unison-${V}-ubuntu-x86_64
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/bcpierce00/unison/${RD}/v${V}/${A}.tar.gz \
    && tar xzf ${A}* \
    && mv bin/unison ${OUT} \
    && rm -rf /tmp/${A}

ENV V=v12.0.0
ENV A=atuin-${V}-x86_64-unknown-linux-gnu
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/ellie/atuin/${RD}/${V}/${A}.tar.gz \
    && tar xzf ${A}.tar.gz \
    && mv ${A}/atuin ${OUT} \
    && rm -rf /tmp/${A}

ENV V=0.38.0
ENV A=fzf-${V}-linux_amd64
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/junegunn/fzf/${RD}/${V}/${A}.tar.gz \
    && tar xzf ${A}.tar.gz \
    && mv fzf ${OUT} \
    && rm -rf /tmp/${A}

ENV V=0.13.0
ENV A=xsv-${V}-x86_64-unknown-linux-musl
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/BurntSushi/xsv/${RD}/${V}/${A}.tar.gz \
    && tar xzf ${A}.tar.gz \
    && mv xsv ${OUT} \
    && rm -rf /tmp/${A}

ENV V=v0.9.4
ENV A=skim-${V}-x86_64-unknown-linux-musl
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/lotabout/skim/${RD}/${V}/${A}.tar.gz \
    && tar xzf ${A}.tar.gz \
    && mv sk ${OUT} \
    && rm -rf /tmp/${A}

ENV V=v0.22.1
ENV A=bat-${V}-x86_64-unknown-linux-musl
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/sharkdp/bat/${RD}/${V}/${A}.tar.gz \
    && tar xzf ${A}.tar.gz \
    && mv ${A}/bat ${OUT} \
    && rm -rf /tmp/${A}

ENV V=v8.6.0
ENV A=fd-${V}-x86_64-unknown-linux-musl
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/sharkdp/fd/${RD}/${V}/${A}.tar.gz \
    && tar xzf ${A}.tar.gz \
    && mv ${A}/fd ${OUT} \
    && rm -rf /tmp/${A}

ENV V=v0.8.0
ENV A=jless-${V}-x86_64-unknown-linux-gnu
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/PaulJuliusMartinez/jless/${RD}/${V}/${A}.zip \
    && 7za x ${A}.zip \
    && chmod +x jless \
    && mv jless ${OUT} \
    && rm -rf /tmp/${A}

ENV V=v1.6.1
ENV A=jd-amd64-linux
RUN cd ${OUT} \
    && curl -sLo jd ${GH}/josephburnett/jd/${RD}/${V}/${A} \
    && chmod +x jd

## CloudFormation related
# this version is old. fetch on golang layer
# # install rain
# # https://github.com/aws-cloudformation/rain
# ENV V=v1.2.0
# ENV A=rain-${V}_linux-amd64
# RUN mkdir -p /tmp/${A} \
#     && cd /tmp/${A} \
#     && curl -LO ${GH}/aws-cloudformation/rain/${RD}/${V}/${A}.zip \
#     && 7za x ${A}.zip \
#     && mv ${A}/rain ${OUT} \
#     && rm -rf ${A} ${A}.zip \
#     && rain --version \
#     && curl -sLo /usr/share/bash-completion/completions/rain ${GH}/aws-cloudformation/rain/raw/main/docs/bash_completion.sh
# but in golang layer need machine power, so back to here with forked repo's binary
# install rain
# https://github.com/peccu/rain
ENV V=v1.3.0
ENV A=rain-${V}_linux-amd64
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/peccu/rain/${RD}/${V}/${A}.zip \
    && 7za x ${A}.zip \
    && mv ${A}/rain ${OUT} \
    && rm -rf /tmp/${A}
# add completions
RUN curl -sLo /usr/share/bash-completion/completions/rain ${GH}/peccu/rain/raw/${V}/docs/bash_completion.sh

# install template builder
# https://github.com/awslabs/aws-cloudformation-template-builder
ENV V=v0.2.0
ENV A=cfn-skeleton-${V}_linux-amd64
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/awslabs/aws-cloudformation-template-builder/${RD}/${V}/${A}.zip \
    && 7za x ${A}.zip \
    && mv ${A}/cfn-skeleton ${OUT} \
    && rm -rf /tmp/${A}

# install template formatter
# https://github.com/awslabs/aws-cloudformation-template-formatter
ENV V=v1.1.2-1
ENV A=cfn-format-${V}_linux-amd64
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/awslabs/aws-cloudformation-template-formatter/${RD}/${V}/${A}.zip \
    && 7za x ${A}.zip \
    && mv ${A}/cfn-format ${OUT} \
    && rm -rf /tmp/${A}

ENV V=0.9.0
ENV A=zoxide-${V}-x86_64-unknown-linux-musl
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/ajeetdsouza/zoxide/${RD}/v${V}/${A}.tar.gz \
    && tar xzf ${A}.tar.gz \
    && mv zoxide ${OUT} \
    && rm -rf /tmp/${A}

# install Tailwind CSS Standalone CLI
ENV A=tailwindcss-linux-x64
RUN cd ${OUT} \
    && curl -sLo tailwindcss ${GH}/tailwindlabs/tailwindcss/releases/latest/download/${A} \
    && chmod +x tailwindcss

ENV V=1.21.0
ENV A=watchexec-${V}-x86_64-unknown-linux-musl
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -LO ${GH}/watchexec/watchexec/${RD}/v${V}/${A}.tar.xz \
    && 7za x ${A}.tar.xz \
    && tar xf ${A}.tar \
    && cd ${A} \
    && mv watchexec ${OUT} \
    && rm -rf /tmp/${A}

# NCurses Disk Usage
ENV V=2.2.1
ENV A=ncdu-${V}-linux-x86_64
RUN mkdir -p /tmp/${A} \
    && cd /tmp/${A} \
    && curl -sLO https://dev.yorhel.nl/download/${A}.tar.gz \
    && tar xf ${A}.tar.gz \
    && mv ncdu ${OUT} \
    && rm -rf /tmp/${A}

# install JQ latest version
ENV V=1.6
ENV A=jq-linux64
RUN cd ${OUT} \
    && curl -sLo jq ${GH}/jqlang/jq/${RD}/jq-${V}/${A} \
    && chmod +x jq

## other branch's space
## other branch's space

##################################################
FROM golang:latest as go
##################################################

# git-xlsx-textconv
# https://stackoverflow.com/a/72742770
ENV GOPROXY=direct
RUN go install -v github.com/tokuhirom/git-xlsx-textconv@latest

# this needs machine power
# moved to bin layer
# RUN go install -v github.com/aws-cloudformation/rain/cmd/rain@main

## other branch's space
## other branch's space

##################################################
FROM rust:slim as rust
##################################################

RUN cargo install the-way

## other branch's space
## other branch's space

##################################################
FROM base as dind
##################################################

# setup docker
RUN apt-get install -y \
    ca-certificates \
    gnupg \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
    > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install docker-ce docker-ce-cli  docker-buildx-plugin docker-compose-plugin -y

# setup locale en_US.UTF-8
# https://stackoverflow.com/a/55077451
RUN apt-get install \
    locales \
    && locale-gen en_US.UTF-8 \
    && echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    && echo "LANG=en_US.UTF-8" > /etc/locale.conf

# install aws cli
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip /awscliv2.zip
RUN apt-get install \
    unzip \
    && unzip /awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip ./aws

# copy from build layer
COPY --from=build ${OUT}/tmux /usr/local/bin/
COPY --from=build ${OUT}/reptyr /usr/local/bin/
COPY --from=build /usr/local/bin/datamash /usr/local/bin/
COPY --from=build ${OUT}/bash /usr/local/bin/
# copy from bin layer
COPY --from=bin ${OUT}/rg /usr/local/bin/
COPY --from=bin ${OUT}/delta /usr/local/bin/
COPY --from=bin ${OUT}/unison /usr/local/bin/
COPY --from=bin ${OUT}/atuin /usr/local/bin/
COPY --from=bin ${OUT}/fzf /usr/local/bin/
COPY --from=bin ${OUT}/xsv /usr/local/bin/
COPY --from=bin ${OUT}/sk /usr/local/bin/
COPY --from=bin ${OUT}/bat /usr/local/bin/
COPY --from=bin ${OUT}/fd /usr/local/bin/
COPY --from=bin ${OUT}/jless /usr/local/bin/
COPY --from=bin ${OUT}/jd /usr/local/bin/
COPY --from=bin ${OUT}/rain /usr/local/bin/
COPY --from=bin /usr/share/bash-completion/completions/rain /usr/share/bash-completion/completions/
COPY --from=bin ${OUT}/cfn-skeleton /usr/local/bin/
COPY --from=bin ${OUT}/cfn-format /usr/local/bin/
COPY --from=bin ${OUT}/zoxide /usr/local/bin/
COPY --from=bin ${OUT}/tailwindcss /usr/local/bin/
COPY --from=bin ${OUT}/watchexec /usr/local/bin/
COPY --from=bin ${OUT}/ncdu /usr/local/bin/
COPY --from=bin ${OUT}/jq /usr/local/bin/
# copy from golang layer
COPY --from=go /go/bin/git-xlsx-textconv /usr/local/bin/
# COPY --from=go /go/bin/rain /usr/local/bin/rain
# copy from rust layer
COPY --from=rust /usr/local/cargo/bin/the-way /usr/local/bin/

## other branch's space
## other branch's space

# setup user environment
ARG username=user
# /usr/local/bin/bash has built in build layer
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
    && apt-get install sudo \
    && echo "${username} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$(echo ${username} | sed 's/[.~]/_/g') \
    && chmod 0440 /etc/sudoers.d/$(echo ${username} | sed 's/[.~]/_/g')

# add user to docker group for access to docker
RUN usermod -a -G docker ${username}

USER ${username}
STOPSIGNAL SIGKILL
VOLUME ["${homedir}/${username}"]
WORKDIR ${homedir}/${username}
ENTRYPOINT ["/usr/bin/sleep", "infinity"]

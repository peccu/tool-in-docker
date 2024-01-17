##################################################
FROM ubuntu:22.04 as base
##################################################

RUN apt-get update
RUN apt-get install -y \
    curl

## other branch's space
## other branch's space

##################################################
FROM base as build
##################################################

# tmux
ENV VER_tmux=3.3a
# some package depends on tzdata so need to specify TZ
# https://serverfault.com/a/1016972
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
RUN apt-get install -y \
    libevent-dev \
    ncurses-dev \
    build-essential \
    bison \
    pkg-config
RUN curl -LO https://github.com/tmux/tmux/releases/download/${VER_tmux}/tmux-${VER_tmux}.tar.gz \
    && tar xf tmux-${VER_tmux}.tar.gz \
    && cd tmux-${VER_tmux} \
    && ./configure --enable-static \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf tmux-${VER_tmux}{,.tar.gz}

## other branch's space
## other branch's space

##################################################
FROM base as bin
##################################################

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
COPY --from=build /usr/local/bin/tmux /usr/local/bin/
# copy from bin layer

## other branch's space
## other branch's space

# setup user environment
ARG username=user
    # -s /usr/local/bin/bash \
ARG homedir=/mnt/c/Users
RUN mkdir -p ${homedir}
RUN groupadd -g 1000 ${username} \
    && useradd \
    -d ${homedir}/${username} \
    -g 1000 \
    -lMN \
    -s /usr/bin/bash \
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

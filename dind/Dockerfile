FROM ubuntu:22.04 as dind

# setup docker
RUN apt-get update \
    && apt-get install ca-certificates curl gnupg -y \
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

# setup user environment
ARG username=user
RUN groupadd -g 1000 ${username} \
    && useradd \
    -d /home/${username} \
    -g 1000 \
    -lMN \
    -s /usr/local/bin/bash \
    -u 1000 \
    ${username} \
    && apt-get install sudo \
    && echo "${username} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${username} \
    && chmod 0440 /etc/sudoers.d/${username}

USER ${username}
STOPSIGNAL SIGKILL
VOLUME ["/home/${username}"]
WORKDIR /home/${username}
ENTRYPOINT ["/usr/bin/sleep", "infinity"]

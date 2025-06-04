##################################################
FROM peccu/tool-in-docker:emacs-x
##################################################

# setup user environment
USER root
ARG username=user
ARG uid=1000
ARG gid=1000
ARG homedir=/mnt/c/Users
RUN mkdir -p ${homedir}
RUN groupadd -g 1000 ${username} \
    && useradd \
    -d ${homedir}/${username} \
    -g ${gid} \
    -lMN \
    -s /usr/local/bin/bash \
    -u ${uid} \
    ${username} \
    && echo "${username} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$(echo ${username} | sed 's/[.~]/_/g') \
    && chmod 0440 /etc/sudoers.d/$(echo ${username} | sed 's/[.~]/_/g')

# add user to docker group for access to docker
RUN usermod -a -G docker ${username}

USER ${username}
VOLUME ["${homedir}/${username}"]
WORKDIR ${homedir}/${username}

# STOPSIGNAL SIGKILL
# ENTRYPOINT ["/usr/bin/sleep", "infinity"]
# ENTRYPOINT ["/usr/local/bin/bash"]

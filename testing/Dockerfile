#################################################
FROM amazon/aws-cli:latest as rust
#################################################

RUN yum install -y gcc
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN source /root/.cargo/env \
    && cargo install the-way

#################################################
FROM amazon/aws-cli:latest as runtime
#################################################

COPY --from=rust /root/.cargo/bin/the-way /usr/local/bin/

ENTRYPOINT bash

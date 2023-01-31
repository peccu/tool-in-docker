##################################################
FROM amazon/aws-cli:latest as build
##################################################

RUN yum update -y \
        && yum install -y make gcc tar gzip p7zip

# install datamash
ENV VER_datamash=1.8
RUN set -x && cd /tmp \
        && curl -LO http://ftp.gnu.org/gnu/datamash/datamash-${VER_datamash}.tar.gz \
        && tar xzf datamash-${VER_datamash}.tar.gz \
        && cd datamash-${VER_datamash} \
        && ./configure \
        && make \
        && make install

# bash 5.2 for zoxide <Space>+<Tab>
# with curses option is for readline's "horizontal-scroll off"
# ref. https://lists.gnu.org/archive/html/bug-readline/2015-11/msg00006.html
ENV VER_bash=5.2
RUN yum install -y ncurses-devel
RUN curl -O http://ftp.gnu.org/gnu/bash/bash-${VER_bash}.tar.gz \
        && tar xf bash-${VER_bash}.tar.gz \
        && cd bash-${VER_bash} \
        && ./configure --with-curses \
        && make \
        && make install \
        && rm -rf bash-${VER_bash}.tar.gz bash-${VER_bash}

# tmux
ENV VER_tmux=3.3a
# ncurses-devel is already installed for bash
RUN yum install -y libevent-devel ncurses-devel gcc make bison pkg-config
RUN curl -LO https://github.com/tmux/tmux/releases/download/${VER_tmux}/tmux-${VER_tmux}.tar.gz \
        && tar xf tmux-${VER_tmux}.tar.gz \
	&& cd tmux-${VER_tmux} \
	&& ./configure \
	&& make \
	&& make install \
	&& rm -rf tmux-${VER_tmux}{,.tar.gz}

##################################################
FROM amazon/aws-cli:latest as bin
##################################################

# epel-release is for nkf p7zip
RUN amazon-linux-extras enable epel \
        && yum clean metadata && yum install -y epel-release \
        && yum update -y \
        && yum install -y \
        tar p7zip gzip

# install ripgrep
ENV VER_RG=13.0.0
RUN cd /usr/local \
        && curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${VER_RG}/ripgrep-${VER_RG}-x86_64-unknown-linux-musl.tar.gz \
        && tar xzf ripgrep-* \
        && cd bin \
        && mv ../ripgrep-*/rg ./\
        && rm -rf ../ripgrep-*

# install delta for git
ENV VER_delta=0.15.1
RUN curl -LO https://github.com/dandavison/delta/releases/download/${VER_delta}/delta-${VER_delta}-x86_64-unknown-linux-musl.tar.gz \
        && tar xzf delta-${VER_delta}-x86_64-unknown-linux-musl.tar.gz \
        && mv delta-${VER_delta}-x86_64-unknown-linux-musl/delta /usr/local/bin \
        && rm -rf delta-${VER_delta}-x86_64-unknown-linux-musl*

# install atuin
ENV VER_atuin=v12.0.0
RUN curl -LO https://github.com/ellie/atuin/releases/download/${VER_atuin}/atuin-${VER_atuin}-x86_64-unknown-linux-gnu.tar.gz \
        && tar xzf atuin-${VER_atuin}-x86_64-unknown-linux-gnu.tar.gz \
        && mv atuin-${VER_atuin}-x86_64-unknown-linux-gnu/atuin /usr/local/bin \
        && rm -rf atuin-${VER_atuin}-x86_64-unknown-linux-gnu*

ENV VER_fzf=0.37.0
RUN curl -LO https://github.com/junegunn/fzf/releases/download/${VER_fzf}/fzf-${VER_fzf}-linux_amd64.tar.gz \
        && tar xzf fzf-${VER_fzf}-linux_amd64.tar.gz \
        && mv fzf /usr/local/bin \
        && rm -rf fzf-${VER_fzf}-linux_amd64.tar.gz

ENV VER_xsv=0.13.0
RUN curl -LO https://github.com/BurntSushi/xsv/releases/download/${VER_xsv}/xsv-${VER_xsv}-x86_64-unknown-linux-musl.tar.gz \
        && tar xzf xsv-${VER_xsv}-x86_64-unknown-linux-musl.tar.gz \
        && mv xsv /usr/local/bin \
        && rm -rf xsv-${VER_xsv}-x86_64-unknown-linux-musl.tar.gz

ENV VER_skim=v0.9.4
RUN curl -LO https://github.com/lotabout/skim/releases/download/${VER_skim}/skim-${VER_skim}-x86_64-unknown-linux-musl.tar.gz \
        && tar xzf skim-${VER_skim}-x86_64-unknown-linux-musl.tar.gz \
        && mv sk /usr/local/bin \
        && rm -rf skim-${VER_skim}-x86_64-unknown-linux-musl.tar.gz

ENV VER_bat=v0.22.1
RUN curl -LO https://github.com/sharkdp/bat/releases/download/${VER_bat}/bat-${VER_bat}-x86_64-unknown-linux-musl.tar.gz \
        && tar xzf bat-${VER_bat}-x86_64-unknown-linux-musl.tar.gz \
        && mv bat-${VER_bat}-x86_64-unknown-linux-musl/bat /usr/local/bin \
        && rm -rf bat-${VER_bat}-x86_64-unknown-linux-musl bat-${VER_bat}-x86_64-unknown-linux-musl.tar.gz

ENV VER_fd=v8.6.0
RUN curl -LO https://github.com/sharkdp/fd/releases/download/${VER_fd}/fd-${VER_fd}-x86_64-unknown-linux-musl.tar.gz \
        && tar xzf fd-${VER_fd}-x86_64-unknown-linux-musl.tar.gz \
        && mv fd-${VER_fd}-x86_64-unknown-linux-musl/fd /usr/local/bin \
        && rm -rf fd-${VER_fd}-x86_64-unknown-linux-musl fd-${VER_fd}-x86_64-unknown-linux-musl.tar.gz

ENV VER_jless=v0.8.0
RUN curl -LO https://github.com/PaulJuliusMartinez/jless/releases/download/${VER_jless}/jless-${VER_jless}-x86_64-unknown-linux-gnu.zip \
        && 7za x jless-${VER_jless}-x86_64-unknown-linux-gnu.zip \
        && chmod +x jless \
        && mv jless /usr/local/bin \
        && rm -rf jless-${VER_jless}-x86_64-unknown-linux-gnu.zip

ENV VER_jd=v1.6.1
RUN cd /usr/local/bin \
        && curl -Lo jd https://github.com/josephburnett/jd/releases/download/${VER_jd}/jd-amd64-linux \
        && chmod +x jd

## CloudFormation related
# this version is old. fetch on golang layer
# # install rain
# # https://github.com/aws-cloudformation/rain
# ENV VER_rain=v1.2.0
# RUN curl -LO https://github.com/aws-cloudformation/rain/releases/download/${VER_rain}/rain-${VER_rain}_linux-amd64.zip \
#         && 7za x rain-${VER_rain}_linux-amd64.zip \
#         && mv rain-${VER_rain}_linux-amd64/rain /usr/local/bin \
#         && rm -rf rain-${VER_rain}_linux-amd64 rain-${VER_rain}_linux-amd64.zip \
#         && rain --version \
#         && curl -Lo /usr/share/bash-completion/completions/rain https://github.com/aws-cloudformation/rain/raw/main/docs/bash_completion.sh
# but in golang layer need machine power, so back to here with forked repo's binary
# install rain
# https://github.com/peccu/rain
ENV VER_rain=v1.3.0
RUN curl -LO https://github.com/peccu/rain/releases/download/${VER_rain}/rain-${VER_rain}_linux-amd64.zip \
        && 7za x rain-${VER_rain}_linux-amd64.zip \
        && mv rain-${VER_rain}_linux-amd64/rain /usr/local/bin \
        && rm -rf rain-${VER_rain}_linux-amd64 rain-${VER_rain}_linux-amd64.zip \
        && rain --version \
        && curl -Lo /usr/share/bash-completion/completions/rain https://github.com/peccu/rain/raw/${VER_rain}/docs/bash_completion.sh

# install template builder
# https://github.com/awslabs/aws-cloudformation-template-builder
ENV VER_cfn_skelton=v0.2.0
RUN curl -LO https://github.com/awslabs/aws-cloudformation-template-builder/releases/download/${VER_cfn_skelton}/cfn-skeleton-${VER_cfn_skelton}_linux-amd64.zip \
        && 7za x cfn-skeleton-${VER_cfn_skelton}_linux-amd64.zip \
        && mv cfn-skeleton-${VER_cfn_skelton}_linux-amd64/cfn-skeleton /usr/local/bin \
        && rm -rf cfn-skeleton-${VER_cfn_skelton}_linux-amd64 cfn-skeleton-${VER_cfn_skelton}_linux-amd64.zip

# install template formatter
# https://github.com/awslabs/aws-cloudformation-template-formatter
ENV VER_cfn_format=v1.1.2-1
RUN curl -LO https://github.com/awslabs/aws-cloudformation-template-formatter/releases/download/${VER_cfn_format}/cfn-format-${VER_cfn_format}_linux-amd64.zip \
        && 7za x cfn-format-${VER_cfn_format}_linux-amd64.zip \
        && mv cfn-format-${VER_cfn_format}_linux-amd64/cfn-format /usr/local/bin \
        && rm -rf cfn-format-${VER_cfn_format}_linux-amd64 cfn-format-${VER_cfn_format}_linux-amd64.zip

ENV VER_zoxide=0.9.0
RUN curl -LO https://github.com/ajeetdsouza/zoxide/releases/download/v${VER_zoxide}/zoxide-${VER_zoxide}-x86_64-unknown-linux-musl.tar.gz \
        && mkdir zoxide \
        && cd zoxide \
        && tar xzf ../zoxide-${VER_zoxide}-x86_64-unknown-linux-musl.tar.gz \
        && mv zoxide /usr/local/bin \
        && cd .. \
        && rm -rf zoxide zoxide-${VER_zoxide}-x86_64-unknown-linux-musl.tar.gz

##################################################
FROM golang:latest as go
##################################################

# https://stackoverflow.com/a/72742770
ENV GOPROXY=direct
RUN go install -v github.com/tokuhirom/git-xlsx-textconv@latest
# this needs machine power
# moved to bin layer
# RUN go install -v github.com/aws-cloudformation/rain/cmd/rain@main

##################################################
FROM amazon/aws-cli:latest
##################################################

# epel-release is for nkf p7zip
RUN amazon-linux-extras enable epel \
        && yum clean metadata && yum install -y epel-release \
        && yum update -y \
        && yum install -y \
        which jq git emacs-nox tar nkf rsync p7zip python2-pip \
        bash-completion bash-completion-extras pv openssl bc nmap \
        python3 python3-pip \
        yum-utils \
        whois bind-utils iputils procps zsh \
        libevent

# install q
ENV VER_q=3.1.6
RUN curl -LO https://github.com/harelba/q/releases/download/v${VER_q}/q-text-as-data-${VER_q}.x86_64.rpm \
        && rpm -ivh q-text-as-data-*.rpm \
        && rm q-text-as-data-*.rpm

# install aws cli session manager plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm" \
        && yum install -y session-manager-plugin.rpm \
        && rm session-manager-plugin.rpm

# install aws sam cli
RUN curl -LO https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip \
        && 7za x aws-sam-cli-linux-x86_64.zip -o./sam-installation \
        && ./sam-installation/install \
        && rm -rf sam-installation aws-sam-cli-linux-x86_64.zip \
        && sam --version

# install azure-cli percol, cfn-lint
RUN pip3 install azure-cli percol cfn-lint

# install terraform
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo \
        && yum -y install terraform

# zoxide
# RUN curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
# moved to bin layer

# install chezmoi
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

## other branch's space
## other branch's space

# copy datamash from build layer
COPY --from=build /usr/local/bin/datamash /usr/local/bin/datamash
COPY --from=build /usr/local/bin/bash /usr/local/bin/bash
COPY --from=build /usr/local/bin/tmux /usr/local/bin/tmux
# copy from golang layer
COPY --from=go /go/bin/git-xlsx-textconv /usr/local/bin/git-xlsx-textconv
# COPY --from=go /go/bin/rain /usr/local/bin/rain
# copy from bin layer
COPY --from=bin /usr/local/bin/rg /usr/local/bin/rg
# delta for git
COPY --from=bin /usr/local/bin/delta /usr/local/bin/delta
COPY --from=bin /usr/local/bin/atuin /usr/local/bin/atuin
# # copy fzf from bin layer
# -> skim
COPY --from=bin /usr/local/bin/fzf /usr/local/bin/fzf
COPY --from=bin /usr/local/bin/xsv /usr/local/bin/xsv
COPY --from=bin /usr/local/bin/sk /usr/local/bin/sk
COPY --from=bin /usr/local/bin/bat /usr/local/bin/bat
COPY --from=bin /usr/local/bin/fd /usr/local/bin/fd
COPY --from=bin /usr/local/bin/jless /usr/local/bin/jless
COPY --from=bin /usr/local/bin/rain /usr/local/bin/rain
COPY --from=bin /usr/local/bin/cfn-skeleton /usr/local/bin/cfn-skeleton
COPY --from=bin /usr/local/bin/cfn-format /usr/local/bin/cfn-format
COPY --from=bin /usr/local/bin/jd /usr/local/bin/jd
COPY --from=bin /usr/local/bin/zoxide /usr/local/bin/zoxide

STOPSIGNAL SIGKILL
VOLUME ["/root"]
WORKDIR /root
ENTRYPOINT ["/usr/bin/sleep", "infinity"]
# ENTRYPOINT ["/usr/local/bin/bash"]

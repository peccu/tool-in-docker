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
        && cd .. \
        && rm -rf tmux-${VER_tmux}{,.tar.gz}

# reptyr PID
# re-attach disowned process
ENV VER_reptyr=0.9.0
RUN curl -LO https://github.com/nelhage/reptyr/archive/refs/tags/reptyr-${VER_reptyr}.tar.gz \
        && tar xf reptyr-${VER_reptyr}.tar.gz \
        && cd reptyr-reptyr-${VER_reptyr} \
        && make \
        && mv reptyr /usr/local/bin/

##################################################
FROM amazon/aws-cli:latest as bin
##################################################

# epel-release is for nkf p7zip
RUN amazon-linux-extras enable epel \
        && yum clean metadata && yum install -y epel-release \
        && yum update -y \
        && yum install -y \
        tar p7zip gzip xz

# install ripgrep
ENV VER_RG=13.0.0
RUN cd /usr/local \
        && curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${VER_RG}/ripgrep-${VER_RG}-x86_64-unknown-linux-musl.tar.gz \
        && tar xzf ripgrep-* \
        && cd bin \
        && mv ../ripgrep-*/rg ./\
        && rm -rf ../ripgrep-*

# install delta for git
ENV VER_delta=0.7.1
RUN curl -LO https://github.com/dandavison/delta/releases/download/${VER_delta}/delta-${VER_delta}-x86_64-unknown-linux-gnu.tar.gz \
        && tar xzf delta-${VER_delta}-x86_64-unknown-linux-gnu.tar.gz \
        && mv delta-${VER_delta}-x86_64-unknown-linux-gnu/delta /usr/local/bin \
        && rm -rf delta-${VER_delta}-x86_64-unknown-linux-gnu*
# some diff was broken
# ENV VER_delta=0.15.1
# RUN curl -LO https://github.com/dandavison/delta/releases/download/${VER_delta}/delta-${VER_delta}-x86_64-unknown-linux-musl.tar.gz \
#         && tar xzf delta-${VER_delta}-x86_64-unknown-linux-musl.tar.gz \
#         && mv delta-${VER_delta}-x86_64-unknown-linux-musl/delta /usr/local/bin \
#         && rm -rf delta-${VER_delta}-x86_64-unknown-linux-musl*

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

# install Tailwind CSS Standalone CLI
RUN curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 \
        && chmod +x tailwindcss-linux-x64 \
        && mv tailwindcss-linux-x64 /usr/local/bin/tailwindcss

ENV VER_watchexec=1.21.0
RUN curl -LO https://github.com/watchexec/watchexec/releases/download/v${VER_watchexec}/watchexec-${VER_watchexec}-x86_64-unknown-linux-musl.tar.xz \
        && tar xf watchexec-${VER_watchexec}-x86_64-unknown-linux-musl.tar.xz \
        && cd watchexec-${VER_watchexec}-x86_64-unknown-linux-musl \
        && mv watchexec /usr/local/bin \
        && cd .. \
        && rm -rf watchexec-${VER_watchexec}-x86_64-unknown-linux-musl{,.tar.xz}

# NCurses Disk Usage
ENV VER_ncdu=2.2.1
RUN curl -sLO https://dev.yorhel.nl/download/ncdu-${VER_ncdu}-linux-x86_64.tar.gz \
        && tar xf ncdu-${VER_ncdu}-linux-x86_64.tar.gz \
        && mv ncdu /usr/local/bin/

# https://github.com/adobe-fonts/source-han-sans/tree/release#otf
RUN mkdir -p /usr/share/fonts/SourceHanSans-VF/ \
        && curl -Lo /usr/share/fonts/SourceHanSans-VF/SourceHanSans-VF.otf \
        https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/OTF/SourceHanSans-VF.otf

# https://github.com/tonsky/FiraCode
RUN mkdir -p /tmp/fonts \
        && curl -LO $(curl -s https://api.github.com/repos/tonsky/FiraCode/releases/latest | grep browser_download_url | awk '{print $2}' | tr -d '"' ) \
        && 7za x Fira_Code_*.zip \
        && mkdir -p /usr/share/fonts/FilaCode/ \
        && mv variable_ttf/FiraCode-VF.ttf /usr/share/fonts/FilaCode/

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
FROM amazon/aws-cli:latest as rust
##################################################

RUN yum install -y gcc
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN source /root/.cargo/env \
    && cargo install the-way

## other branch's space
##################################################
FROM amazon/aws-cli:latest
##################################################

RUN yum install -y \
        rpm-build \
        rpmdevtools \
        git-core \
        && rpmdev-setuptree
ADD emacs.spec.patch /aws/
RUN git clone https://src.fedoraproject.org/rpms/emacs.git \
        && cp ./* /root/rpmbuild/SOURCES/ \
        && cd /root/rpmbuild/SOURCES/ \
        && patch < /aws/emacs.spec.patch \
        && mv emacs.spec ../SPECS/ \
        && cd .. \
        && spectool -g -R SPECS/emacs.spec \
        && sed -ni.bak '/^%changelog/q;p' SPECS/emacs.spec \
        && yum install -y $(rpmbuild -bb SPECS/emacs.spec 2>&1 | grep 'is needed by' | awk '{print $1}')
        # && rpmbuild -bb SPECS/emacs.spec
## other branch's space

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

# copy datamash from build layer
COPY --from=build /usr/local/bin/datamash /usr/local/bin/
COPY --from=build /usr/local/bin/bash /usr/local/bin/
COPY --from=build /usr/local/bin/tmux /usr/local/bin/
COPY --from=build /usr/local/bin/reptyr /usr/local/bin/
# copy from golang layer
COPY --from=go /go/bin/git-xlsx-textconv /usr/local/bin/
# COPY --from=go /go/bin/rain /usr/local/bin/rain
COPY --from=rust /root/.cargo/bin/the-way /usr/local/bin/
# copy from bin layer
COPY --from=bin /usr/local/bin/rg /usr/local/bin/
# delta for git
COPY --from=bin /usr/local/bin/delta /usr/local/bin/
COPY --from=bin /usr/local/bin/atuin /usr/local/bin/
# # copy fzf from bin layer
# -> skim
COPY --from=bin /usr/local/bin/fzf /usr/local/bin/
COPY --from=bin /usr/local/bin/xsv /usr/local/bin/
COPY --from=bin /usr/local/bin/sk /usr/local/bin/
COPY --from=bin /usr/local/bin/bat /usr/local/bin/
COPY --from=bin /usr/local/bin/fd /usr/local/bin/
COPY --from=bin /usr/local/bin/jless /usr/local/bin/
COPY --from=bin /usr/local/bin/rain /usr/local/bin/
COPY --from=bin /usr/local/bin/cfn-skeleton /usr/local/bin/
COPY --from=bin /usr/local/bin/cfn-format /usr/local/bin/
COPY --from=bin /usr/local/bin/jd /usr/local/bin/
COPY --from=bin /usr/local/bin/zoxide /usr/local/bin/
COPY --from=bin /usr/local/bin/tailwindcss /usr/local/bin/
COPY --from=bin /usr/local/bin/watchexec /usr/local/bin/
COPY --from=bin /usr/local/bin/ncdu /usr/local/bin/

## other branch's space
# Emacs for WSLg related
RUN yum install -y emacs

# add fonts
COPY --from=bin /usr/share/fonts/SourceHanSans-VF/SourceHanSans-VF.otf /usr/share/fonts/SourceHanSans-VF/
COPY --from=bin /usr/share/fonts/FilaCode/FiraCode-VF.ttf /usr/share/fonts/FilaCode/
RUN fc-cache -fv && fc-list

# for vGPU container
ENV LD_LIBRARY_PATH=/usr/lib/wsl/lib
RUN yum install -y mesa-libGLw
## other branch's space

STOPSIGNAL SIGKILL
VOLUME ["/root"]
WORKDIR /root
ENTRYPOINT ["/usr/bin/sleep", "infinity"]
# ENTRYPOINT ["/usr/local/bin/bash"]

FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Setup up user and working directory
ARG GROUP_ID
ARG USER_ID
RUN addgroup --gid ${GROUP_ID} notarygroup
RUN adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} komodian
WORKDIR /home/komodian

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install  libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev \
        libboost-test-dev libboost-thread-dev build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev python3-zmq \
        zlib1g-dev wget curl bsdmainutils automake cmake clang libsodium-dev libcurl4-gnutls-dev libssl-dev git unzip python jq htop -y

# Build
COPY build.sh /build.sh
RUN /build.sh

# Setup symbolic links to binaries
RUN ln -sf /AYAv2/src/aryacoin-cli /usr/local/bin/aryacoin-cli
RUN ln -sf /AYAv2/src/aryacoind /usr/local/bin/aryacoind
RUN PATH=/AYAv2/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh

# Setup up user and working directory
RUN chown -R komodian:notarygroup /home/komodian
USER komodian

ENTRYPOINT [ "/entrypoint.sh" ]

# Start the daemon
CMD ["/run.sh"]

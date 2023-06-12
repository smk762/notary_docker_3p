FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Setup up user and working directory
RUN groupadd -r notarygroup
RUN useradd -r -g notarygroup komodian
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
RUN ln -sf /einsteinium/src/einsteinium-cli /usr/local/bin/einsteinium-cli
RUN ln -sf /einsteinium/src/einsteiniumd /usr/local/bin/einsteiniumd
RUN PATH=/einsteinium/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh

RUN chown -R komodian:notarygroup /home/komodian
USER komodian

ENTRYPOINT [ "/entrypoint.sh" ]

# Start the daemon
CMD ["/run.sh"]

# Build stage for MIL Core
FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Enter your pubkey here
ENV PUBKEY="02b3c168ed4acd96594288cee3114c77de51b6afe1ab6a866887a13a96ee80f33c"

# Set an environment variable for the commit hash
ENV COMMITHASH="master"

# Create non-root user
RUN groupadd -r notarygroup
RUN useradd -r -g notarygroup komodian
WORKDIR /home/komodian

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install  libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev \
        libboost-test-dev libboost-thread-dev build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev python3-zmq \
        zlib1g-dev wget curl bsdmainutils automake cmake clang libsodium-dev libcurl4-gnutls-dev libssl-dev git unzip python jq htop -y


# Install nanomsg
RUN git clone https://github.com/nanomsg/nanomsg
RUN cd nanomsg && cmake . -DNN_TESTS=OFF -DNN_ENABLE_DOC=OFF && make -j2 && make install && ldconfig

## Clean the nanomsg build source
RUN rm -rf nanomsg

# Build 
COPY build.sh /build.sh
RUN /build.sh

# Setup symbolic links to binaries
RUN ln -sf /home/komodian/komodo/src/komodo-cli /usr/local/bin/komodo-cli
RUN ln -sf /home/komodian/komodo/src/komodod /usr/local/bin/komodod
RUN PATH=/home/komodian/komodo/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh

## Create the data dir
RUN chown -R komodian:notarygroup /home/komodian
USER komodian

ENTRYPOINT ["/entrypoint.sh"]

# Start daemon with the data directory mounted
CMD ["/run.sh"]

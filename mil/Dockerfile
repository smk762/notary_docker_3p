# Build stage for MIL Core
FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Enter your pubkey here
ENV PUBKEY="02b3c168ed4acd96594288cee3114c77de51b6afe1ab6a866887a13a96ee80f33c"

# Set an environment variable for the commit hash for MIL
ENV MIL_COMMIT=578bed7


# Setup up user and working directory
RUN groupadd -r notarygroup
RUN useradd -r -g notarygroup komodian
WORKDIR /home/komodian

# Install necessary packages to build MIL from source
ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev \
    libboost-program-options-dev libboost-test-dev libboost-thread-dev build-essential pkg-config libc6-dev \
    m4 g++-multilib autoconf libtool ncurses-dev python3-zmq zlib1g-dev wget curl bsdmainutils automake cmake \
    clang libsodium-dev libcurl4-gnutls-dev libssl-dev git unzip python2 jq htop -y

# Build
COPY build.sh /build.sh
RUN /build.sh

# Setup symbolic links to binaries
RUN ln -sf /mil/src/mil-cli /usr/local/bin/mil-cli
RUN ln -sf /mil/src/mild /usr/local/bin/mild
RUN PATH=/mil/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh

RUN chown -R komodian:notarygroup /home/komodian
USER komodian

ENTRYPOINT [ "/entrypoint.sh" ]

# Start the MIL daemon with the data directory mounted
CMD ["/run.sh"]

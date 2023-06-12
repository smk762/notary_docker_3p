# Build stage for MIL Core
FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Enter your pubkey here
ENV PUBKEY="02b3c168ed4acd96594288cee3114c77de51b6afe1ab6a866887a13a96ee80f33c"

RUN groupadd -r notarygroup
RUN useradd -r -g notarygroup komodian
WORKDIR /home/komodian

RUN apt-get update -y

# Install Required Dependencies
RUN apt-get install -y build-essential pkg-config bsdmainutils \
	libtool libsodium-dev libc6-dev libssl-dev libcurl4-gnutls-dev \
	ncurses-dev zlib1g-dev cmake clang m4 automake autoconf g++-multilib \
	python python3 python3-zmq curl wget jq git unzip libboost-system-dev \
	libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev \
	libboost-test-dev libboost-thread-dev

# Build
COPY build.sh /build.sh
RUN /build.sh

# Setup symbolic links to binaries
RUN ln -sf /home/komodian/marmara/src/komodo-cli /usr/local/bin/komodo-cli
RUN ln -sf /home/komodian/marmara/src/marmarad /usr/local/bin/marmarad
RUN PATH=/home/komodian/marmara/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh


## Create the data dir
RUN mkdir -p /home/komodian/.komodo
RUN chown -R komodian:notarygroup /home/komodian
USER komodian

ENTRYPOINT ["/entrypoint.sh"]

# Start daemon with the data directory mounted
CMD ["/run.sh"]

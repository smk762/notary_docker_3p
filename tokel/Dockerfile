FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Create non-root user
RUN groupadd -r notarygroup
RUN useradd -r -g notarygroup komodian
WORKDIR /home/komodian

# Install Required Dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install build-essential pkg-config bsdmainutils \
	libtool libsodium-dev libc6-dev libssl-dev libcurl4-gnutls-dev \
	ncurses-dev zlib1g-dev cmake clang m4 automake autoconf g++-multilib \
	python python3 python3-zmq curl wget jq git unzip libboost-system-dev \
	libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev \
	libboost-test-dev libboost-thread-dev -y

# Build 
COPY build.sh /build.sh
RUN /build.sh

# Setup symbolic links to binaries
RUN ln -sf /home/komodian/tokel/src/tokel-cli /usr/local/bin/tokel-cli
RUN ln -sf /home/komodian/tokel/src/tokeld /usr/local/bin/tokeld
RUN PATH=/home/komodian/tokel/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh

## Create the data dir
RUN chown -R komodian:notarygroup /home/komodian
USER komodian

ENTRYPOINT ["/entrypoint.sh"]

# Start daemon with the data directory mounted
CMD ["/run.sh"]

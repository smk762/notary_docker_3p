FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Setup up user and working directory
ARG GROUP_ID
ARG USER_ID
RUN addgroup --gid ${GROUP_ID} notarygroup
RUN adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} komodian
WORKDIR /home/komodian

ENV BUILD_PACKAGES="libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev curl \
        libboost-test-dev libboost-thread-dev build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev python3-zmq \
        zlib1g-dev wget bsdmainutils automake cmake clang libsodium-dev libcurl4-gnutls-dev libssl-dev git unzip python jq htop"

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install $BUILD_PACKAGES -y

# Build
COPY build.sh /build.sh
RUN /build.sh

RUN apt remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) && \
    rm -rf /var/lib/apt/lists/* 

RUN apt update && apt install -y libcurl4-gnutls-dev libgomp1 telnet curl nano

# Configure
COPY configure.sh /configure.sh
RUN /configure.sh

# Setup symbolic links to binaries
RUN ln -sf /home/komodian/chips/src/chips-cli /usr/local/bin/chips-cli
RUN ln -sf /home/komodian/chips/src/chipsd /usr/local/bin/chipsd
RUN PATH=/home/komodian/chips/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh

# Setup up user and working directory
RUN chown -R komodian:notarygroup /home/komodian
USER komodian

ENTRYPOINT [ "/entrypoint.sh" ]

# Start the daemon
CMD ["/run.sh"]

FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Setup up user and working directory
ARG GROUP_ID
ARG USER_ID
RUN addgroup --gid ${GROUP_ID} notarygroup
RUN adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} komodian
WORKDIR /home/komodian
RUN apt-get update -y

# Install Required Dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git zlib1g-dev wget bsdmainutils automake curl -y

# Build
COPY build.sh /build.sh
RUN /build.sh

# Setup symbolic links to binaries
RUN ln -sf /home/komodian/VerusCoin/src/verus /usr/local/bin/verus
RUN ln -sf /home/komodian/VerusCoin/src/verusd /usr/local/bin/verusd
RUN PATH=/home/komodian/VerusCoin/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh

ENTRYPOINT ["/entrypoint.sh"]

# Setup up user and working directory
RUN chown -R komodian:notarygroup /home/komodian
USER komodian

# Start daemon with the data directory mounted
CMD ["/run.sh"]

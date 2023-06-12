# Build stage for MIL Core
FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Enter your pubkey here
ENV PUBKEY="02b3c168ed4acd96594288cee3114c77de51b6afe1ab6a866887a13a96ee80f33c"

# Set an environment variable for the commit hash
ENV COMMITHASH=3f0f435

RUN groupadd -r notarygroup
RUN useradd -r -g notarygroup komodian
WORKDIR /home/komodian

RUN apt-get update -y

# Install Required Dependencies
RUN sudo apt-get install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git zlib1g-dev wget bsdmainutils automake curl

# Build
COPY build.sh /build.sh
RUN /build.sh

# Setup symbolic links to binaries
RUN ln -sf /home/komodian/VerusCoin/src/verus /usr/local/bin/verus
RUN ln -sf /home/komodian/VerusCoin/src/verusd /usr/local/bin/verusd
RUN PATH=/home/komodian/VerusCoin/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh

## Change ownership to non-root user
RUN chown -R komodian:notarygroup /home/komodian
USER komodian

ENTRYPOINT ["/entrypoint.sh"]

# Start daemon with the data directory mounted
CMD ["/run.sh"]

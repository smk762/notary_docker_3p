FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Enter your pubkey here
ENV PUBKEY="02b3c168ed4acd96594288cee3114c77de51b6afe1ab6a866887a13a96ee80f33c"

# Set an environment variable for the commit hash
ENV COMMITHASH=578bed7

# Setup up user and working directory
RUN groupadd -r notarygroup
RUN useradd -r -g notarygroup komodian
WORKDIR /home/komodian

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install software-properties-common autoconf git build-essential libtool libprotobuf-c-dev \
        libgmp-dev libsqlite3-dev python python3 zip jq libevent-dev pkg-config libssl-dev libcurl4-gnutls-dev cmake -y
RUN add-apt-repository ppa:bitcoin/bitcoin && apt-get update && apt-get install libdb4.8-dev libdb4.8++-dev -y 

# Build
COPY build.sh /build.sh
RUN /build.sh

# Setup symbolic links to binaries
RUN ln -sf /chips/src/chips-cli /usr/local/bin/chips-cli
RUN ln -sf /chips/src/chipsd /usr/local/bin/chipsd
RUN PATH=/chips/src:/usr/local/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /run.sh

RUN chown -R komodian:notarygroup /home/komodian
USER komodian

ENTRYPOINT [ "/entrypoint.sh" ]

# Start the daemon
CMD ["/run.sh"]

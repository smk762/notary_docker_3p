FROM komodoofficial/atomicdexapi:dev-19c8218
LABEL maintainer="smk@komodoplatform.com"

# Setup up user and working directory
ARG DEBIAN_FRONTEND=noninteractive 
ARG GROUP_ID
ARG USER_ID
RUN addgroup --gid ${GROUP_ID} notarygroup
RUN adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} komodian

WORKDIR /home/komodian/mm2

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install nano -y

ENV MM2_CONF_PATH=/home/komodian/mm2/MM2.json
ENV MM_COINS_PATH=/home/komodian/mm2/coins
ENV MM_LOG=/home/komodian/mm2/mm2.log
ENV USERPASS=${userpass}
COPY ./ /home/komodian/mm2/

ENV PATH=/app:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Setup user and working directory
RUN chown -R komodian:notarygroup /home/komodian
USER komodian

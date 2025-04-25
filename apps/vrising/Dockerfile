# syntax=docker/dockerfile:1

FROM docker.io/library/ubuntu:24.10

ARG VERSION
ARG DEBIAN_FRONTEND="noninteractive"

ENV STEAM_APP_ID="1829350"

ENV GAME_PORT="27015"
ENV QUERY_PORT="27016"
ENV BIND_ADDRESS="0.0.0.0"
ENV HIDE_IP="true"
ENV LOWER_FPS_EMPTY="true"
ENV SECURE="true"
ENV DESCRIPTION="A VRISING SERVER"
ENV EOS_LIST="true"
ENV STEAM_LIST="false"
ENV GAME_PRESET="StandardPvP"
ENV DIFFICULTY="Difficulty_Normal"
ENV SAVE_NAME="vrising_world"

USER root

RUN useradd -m steam \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y \
      apt-utils \
      software-properties-common \
    && add-apt-repository multiverse \
    && dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get upgrade -y \
    && echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections \
    && apt-get install --no-install-recommends -y \
      catatonit \
      tzdata \
      wget \
      wine64 \
      wine32 \
      winetricks \
      xvfb \
      steamcmd \
      vim \
      && ln -s /usr/games/steamcmd /usr/bin/steamcmd \
      && rm -rf /var/lib/apt/lists/* \
      && apt-get clean \
      && apt-get autoremove -y

COPY entrypoint.sh /entrypoint.sh

USER steam

VOLUME ["/serverdata", "/savedata"]
ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
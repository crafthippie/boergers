FROM ghcr.io/dockhippie/minecraft-vanilla:1.20.1@sha256:e3a8e4059e2a95e7c1a23737001d8fbecb93fbaee16d55a370b1f8ca12597625

EXPOSE 25565 25575 8123

ENV FORGE_VERSION=47.1.106
ENV FORGE_URL=https://maven.neoforged.net/releases/net/neoforged/forge/${MINECRAFT_VERSION}-${FORGE_VERSION}/forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar

ENV DYNMAP_JAR=Dynmap-3.7-beta-4-forge-1.20.jar
ENV DYNMAP_URL=https://mediafilez.forgecdn.net/files/4979/24/${DYNMAP_JAR}

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl --create-dirs -sLo /usr/share/minecraft/forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar ${FORGE_URL} && \
    cd /usr/share/minecraft && \
    mkdir mods && \
    java -jar forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar --installServer && \
    rm -f forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar.log run.bat run.sh && \
    curl --create-dirs -sLo /usr/share/minecraft/mods/${DYNMAP_JAR} ${DYNMAP_URL}

ENV MINECRAFT_LEVEL_TYPE=DEFAULT

COPY ./overlay/ /
COPY ./mods /usr/share/minecraft/mods
COPY ./config /usr/share/minecraft/config

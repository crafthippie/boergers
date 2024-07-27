#!/usr/bin/env bash

if [ ! -d ${MINECRAFT_BACKUPS_DIR} ]; then
    echo "> creating backups dir"
    mkdir -p ${MINECRAFT_BACKUPS_DIR}
fi

if [ ! -L ${MINECRAFT_GAME_DIR}/backups ]; then
    echo "> creating backups symlink"
    ln -sf ${MINECRAFT_BACKUPS_DIR} ${MINECRAFT_GAME_DIR}/backups
fi

if [ ! -d ${MINECRAFT_DYNMAP_DIR} ]; then
    echo "> creating dynmap dir"
    mkdir -p ${MINECRAFT_DYNMAP_DIR}
fi

if [ ! -L ${MINECRAFT_GAME_DIR}/dynmap ]; then
    echo "> creating dynmap symlink"
    ln -sf ${MINECRAFT_DYNMAP_DIR} ${MINECRAFT_GAME_DIR}/dynmap
fi

true

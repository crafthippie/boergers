#!/usr/bin/env bash

if [ ! -d ${MINECRAFT_MODS_DIR} ]; then
    echo "> creating mods dir"
    mkdir -p ${MINECRAFT_MODS_DIR}
fi

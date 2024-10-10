#!/bin/bash

# Directory of currently executed file
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Repo root
REPO_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && cd ../.. &> /dev/null && pwd )

# create the steam box
distrobox create steam --name steam --hostname steam --nvidia --image fedora:40 --home ${REPO_DIR}/homedirs/steam_home
# enter and init the steam box
distrobox enter steam -- bash -c ${SCRIPT_DIR}/init_steam_box.sh

ICON_PATH=${REPO_DIR}/homedirs/steam_home/.local/share/Steam/resource/icon_steam_vr.png

# "install" desktop shortcut
cp $SCRIPT_DIR/steam.desktop ~/.local/share/applications/steam.desktop
sed -i -e 's|X_ICON_PATH_X|'${ICON_PATH}'|g' ~/.local/share/applications/steam.desktop
cp $SCRIPT_DIR/start_steam.sh ${REPO_DIR}/homedirs/steam_home/start_steam.sh

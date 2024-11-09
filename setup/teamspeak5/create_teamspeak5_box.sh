#!/bin/bash

# Directory of currently executed file
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Repo root
REPO_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && cd ../.. &> /dev/null && pwd )

# create the rust box
distrobox create teamspeak5 --name teamspeak5 --hostname teamspeak5 --nvidia --image fedora:41 --home ${REPO_DIR}/homedirs/teamspeak5_home --additional-flags "--env GTK_THEME=Adwaita:dark"
# enter and init the rust box
distrobox enter teamspeak5 -- bash -c ${SCRIPT_DIR}/init_teamspeak5_box.sh

# "install" desktop shortcut
cp $SCRIPT_DIR/teamspeak5.desktop ~/.local/share/applications/teamspeak5.desktop
sed -i -e 's|X_ICON_PATH_X|'${REPO_DIR}/homedirs/teamspeak5_home/teamspeak-client/logo-256.png'|g' ~/.local/share/applications/teamspeak5.desktop
cp $SCRIPT_DIR/start_teamspeak5.sh ${REPO_DIR}/homedirs/teamspeak5_home/start_teamspeak5.sh

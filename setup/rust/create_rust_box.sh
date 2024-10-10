#!/bin/bash

# Directory of currently executed file
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Repo root
REPO_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && cd ../.. &> /dev/null && pwd )

# create the rust box
distrobox create rust --name rust --hostname rust --nvidia --image fedora:40 --home ${REPO_DIR}/homedirs/rust_home --additional-flags "--env GTK_THEME=Adwaita:dark"
# enter and init the rust box
distrobox enter rust -- bash -c ${SCRIPT_DIR}/init_rust_box.sh

cp ~/.gitconfig ${REPO_DIR}/homedirs/rust_home/.gitconfig


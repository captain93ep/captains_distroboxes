#!/bin/bash

# Directory of currently executed file.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Repo root
REPO_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && cd ../.. &> /dev/null && pwd )

# Check home
if [ ! -d ~ ]; then
    echo "Some fecker removed my home dir! Recreating. But you might want to recreate the container."
    echo
    mkdir -p ~
fi

# Go home
cd ~
echo "teamspeak5 home: $PWD"
echo

dnf check-update
sudo dnf update -y

sudo dnf install -y wget
sudo dnf install -y gtk3
sudo dnf install -y libXScrnSaver

# make bash look nice
mkdir -p ~/.bashrc.d
cp -r ${REPO_DIR}/setup/common/bash_prompt ~/.bashrc.d/bash_prompt

CURRENT_URL="https://files.teamspeak-services.com/pre_releases/client/5.0.0-beta77/teamspeak-client.tar.gz"

# Try to parse download page for link to tar.gz file
NEW_URL=$(curl -s https://www.teamspeak.com/de/downloads/ | grep "action=\"copy\"" | grep "client/5" | grep ".tar.gz" | awk '{ sub(/.*data-clipboard-text="/, ""); sub(/\.tar\.gz.*/, ""); print }')".tar.gz"

if [ -f "${REPO_DIR}/binaries/teamspeak-client.tar.gz" ]; then
    echo "Using local copy of teamspeak5"
    cp "${REPO_DIR}/binaries/teamspeak-client.tar.gz" ./
else
    echo "Downloading teamspeak5 from $CURRENT_URL"
    wget "${CURRENT_URL}"
fi

if [ -d "teamspeak-client" ]; then
    rm -rf teamspeak-client
fi

mkdir -p teamspeak-client
tar -xzf "teamspeak-client.tar.gz" -C teamspeak-client

# Only check for the new url, to not accidentally download something weird. Update must then be done manually.
if [ "$CURRENT_URL" != "$NEW_URL" ]; then
    echo "There seems to be a new teamspeak version. You might want to update. Your url:"
    echo "$CURRENT_URL"
    echo "The new url"
    echo "$NEW_URL"
fi

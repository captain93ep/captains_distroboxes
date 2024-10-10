#!/bin/bash

# Directory of currently executed file.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

dnf check-update
sudo dnf update -y

# make bash look nice
mkdir -p ~/.bashrc.d
cp -r ${SCRIPT_DIR}/../common/bash_prompt ~/.bashrc.d/bash_prompt

# add fusion repos to install steam
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y steam

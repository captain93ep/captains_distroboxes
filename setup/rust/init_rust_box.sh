#!/bin/bash

# Directory of currently executed file.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# from the official setup guide: https://code.visualstudio.com/docs/setup/linux
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf update -y

sudo dnf install -y code

sudo dnf install -y bash-completion
sudo dnf install -y clang
sudo dnf install -y lldb
sudo dnf install -y git

# install rust unattended with defaults
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# make bash look nice
mkdir -p ~/.bashrc.d
cp -r ${SCRIPT_DIR}/../common/bash_prompt ~/.bashrc.d/bash_prompt

# update current session shell, to get cargo command into path
. ~/.profile

# attempt one more rust update
rustup update
rustup component add rust-analyzer

distrobox-export --app code --extra-flags "--disable-gpu"

sudo dnf install kdiff3 -y
distrobox-export --app kdiff3

sudo dnf install dnf-plugins-core -y

sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit -y

sudo dnf install -y neovim
distrobox-export --app nvim

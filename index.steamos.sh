#!/bin/bash

# My needs for my steamdeck are quite different from MacOS
# and ChromeOS, so this may be quite radically different.
# 
# I also want to avoid making the root filesystem writable, so
# I rely heavily on flatpak and brew installed to the home folder
# to work.

set -e 

trap 'ctrlC' INT
trap 'theEnd $?' EXIT

ctrlC() {
    ./print.sh "You canceled beleyenv!  This may leave you in a weird state.\n\
Since belyenv is idempotent, you can most likely just re-run beleyenv"

    exit 1
}

theEnd() {
    if [[ "$1" != "0" ]]; then
        ./print.sh 'Beleyenv install failed!'
    else
        ./print.sh 'SUCCESS!  BELEYENV HAS BEEN FULLY INSTALLED!'
    fi
}

./configScripts/setup-ssh-keys.sh 

flatpak install -y flathub com.google.Chrome org.videolan.VLC
flatpak install -y flathub io.github.streetpea.Chiaki4deck

# Flatpak Chrome home directory access
flatpak override --user --filesystem=home com.google.Chrome

# Flatpak Chrome Controller Access
flatpak --user override --filesystem=/run/udev:ro com.google.Chrome

# Brew should be installed by bootstrap.sh,
# so we just update the local repo and upgrade packages.
# Noticed issues on steamdeck. Not sure what's up though. Defaults seemed sane.
# To investigate on a later day.
ulimit -n 6000 
brew update
brew upgrade
brew install asdf shellcheck fd thefuck jq fzf bat yq lsd lazygit git-delta

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest 

# shellcheck disable=SC1091
. "$(brew --prefix asdf)/libexec/asdf.sh"
npm install --global yarn

# Decky Plugin loader
curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh

./installScripts/install-zsh.sh
./installScripts/install-fonts.sh
./installScripts/install-yarn-pkgs.sh

# Enable SSHD
systemctl enable sshd
sudo systemctl start sshd

# User configuration
./configScripts/link-configs.sh
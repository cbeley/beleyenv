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

# Flatpak home directory access
flatpak override --user --filesystem=home com.google.Chrome

# Flatpak Controller Access
flatpak --user override --filesystem=/run/udev:ro com.google.Chrome

brew install shellcheck imagemagick fd thefuck jq fzf bat yq
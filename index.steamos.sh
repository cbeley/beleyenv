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

# Install Chrome with proper permissions for home directory
# and controller access (For Stadia).
flatpak install flathub com.google.Chrome
flatpak override --user --filesystem=home com.google.Chrome
flatpak --user override --filesystem=/run/udev:ro com.google.Chrome
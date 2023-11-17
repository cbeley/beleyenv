#!/bin/bash

set -e

./print.sh "Running Ubuntu-Specific Install Scripts!"

sudo apt-get -y install steam guvcview \
    gnome-shell-extension-manager gnome-tweaks \
    ubuntu-restricted-extras openssh-server \
    ffmpegthumbnailer chrome-gnome-shell flatpak \
    dconf-editor pavucontrol kitty-terminfo

# Solaar - Logitech Device Support
sudo add-apt-repository -y ppa:solaar-unifying/ppa
sudo apt-get update
sudo apt-get -y install solaar

sudo flatpak remote-add --if-not-exists \
    flathub https://flathub.org/repo/flathub.flatpakrepo

sudo snap install discord
sudo snap install slack
sudo snap install zoom-client

# Discord dmesg log spam suppression
# https://github.com/snapcrafters/discord/issues/23
sudo apt-get -y install auditd
sudo auditctl -a exit,never \
    -F exe=/snap/discord/current/usr/share/discord/Discord

# snapcraft suggests it: https://snapcraft.io/discord
snap connect discord:system-observe

./installScripts/install-dconf-backup.sh
./installScripts/installGarminExpress/index.sh

# Remove shit.
# Maybe I'll use arch again and be happy...
# Note that the core install of Ubuntu does
# not include most of this, but keeping it here
# for completions-sake.

sudo apt-get -y purge thunderbird aisleriot \
    gnome-sudoku gnome-mahjongg gnome-mines \
    shotwell rhythmbox
sudo apt-get -y purge 'libreoffice*'
sudo apt-get -y auto-remove
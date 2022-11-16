#!/bin/bash

set -e

./print.sh "Running ChromeOS-Specific Install Scripts!"

./installScripts/install-chromeos-theme.sh
./installScripts/install-chromeos-etc-hosts-watcher.sh

# Install Flatpak repositories & packages
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub com.valvesoftware.Steam

# This may be undesirable on 1080p screens.
flatpak override --user --env=GDK_SCALE=3 com.valvesoftware.Steam

./print.sh "Installed flatpak & flatpak packages!"


./print.sh "Hints of what to do next:\n\
                         \n\
 * Run ./devScripts/switch-to-ssh-remote.sh to switch from https to ssh if you are Chris.\n\
 * Some changes only will take effect after a reboot of the container.\n\
   Right click 'Terminal' and click 'Shut Down Linux', then start kitty via the app launcher.\n\
 * You will have to manually run the 'Install Package Control' command in sublime."

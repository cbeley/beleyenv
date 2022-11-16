#!/bin/bash

set -e
source ./devScripts/trap-handler.sh

sudo apt update

# Install the minimum for the few things that require
# prompting the user to do something.
sudo apt-get -y install jq libnotify-bin

./configScripts/setup-ssh-keys.sh 

# TODO: Need a new environment before first run.
#./configScripts/setup-borg-env.sh ubuntu

sudo apt-get -y dist-upgrade

### Everything below this line should require zero prompting from the user ###

# xdg-open does not properly work with paths outside the user's
# home directory. I have some things (like markdown previewing) that
# use xdg-open to display a temporarily generated webpage. 
# 
# For better or worse, simply using a symlinked path to /tmp does the trick.
ln -sf /tmp ~/.tmp

sudo apt-get -y install xz-utils nano apt-transport-https python3-pip \
    python3-libtorrent python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-appindicator3 \
    python3-dev python3-setuptools git zsh jq shellcheck imagemagick borgbackup \
    ca-certificates gnupg-agent software-properties-common vlc traceroute gimp rsync \
    dnsutils dnsmasq gocryptfs calibre fdupes archivemount fd-find unrar-free sshfs fzf \
    bat htop feh

./print.sh "Installed general apt-get packages!"

# Install Pip dependencies
# pygments is required by https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
sudo pip3 install deluge thefuck pygments

./print.sh "Installed general pip packages!"

# TODO: Differs from ChromeOS. Take into consideration for eventual merge.
# Flatpak is used on ChromeOS instead for Debian.
sudo apt install steam

# TODO: I do not think this will matter for Ubuntu? Verify if GDK_SCALE needs to 
# be fiddled with.
# flatpak override --user --env=GDK_SCALE=3 com.valvesoftware.Steam

# ./print.sh "Installed flatpak & flatpak packages!"

# Package installs that require more effort -- mostly because debian LTS tends to have
# very old packages.
./installScripts/installKitty/index.sh
./installScripts/install-zsh.sh
./installScripts/installSublime/index.sh
./installScripts/install-todo.sh
./installScripts/install-lsd.sh
./installScripts/install-fonts.sh
./installScripts/install-hostess.sh
./installScripts/install-docker.sh
./installScripts/install-node.sh
./installScripts/install-lazygit.sh
./installScripts/install-delta.sh
./installScripts/installKCC/index.sh
./installScripts/install-yarn-pkgs.sh
./installScripts/install-signal.sh

# User configuration
./configScripts/link-configs.sh
./configScripts/update-hosts.sh
./configScripts/setup-git.sh

# Install packages dependent on user configuration being present first.
./installScripts/installBorgTools/index.sh

./print.sh "Hints of what to do next:\n\
                         \n\
 * Run ./devScripts/switch-to-ssh-remote.sh to switch from https to ssh if you are Chris.\n\
 * Some changes only will take effect after a reboot of the container.\n\
   Right click 'Terminal' and click 'Shut Down Linux', then start kitty via the app launcher.\n\
 * You will have to manually run the 'Install Package Control' command in sublime."

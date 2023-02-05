#!/bin/bash

set -e
source ./devScripts/trap-handler.sh

if grep -q 'ubuntu' /etc/os-release; then 
   distro='ubuntu'
else 
   distro='chromeOS'
fi 

sudo apt update

# Install the minimum for the few things that require
# prompting the user to do something.
sudo apt-get -y install jq libnotify-bin

./configScripts/setup-ssh-keys.sh 
./configScripts/setup-borg-env.sh $distro

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
    bat htop feh curl rclone

./print.sh "Installed general apt-get packages!"

# Install Pip dependencies
# pygments is required by https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
sudo pip3 install deluge thefuck pygments

./print.sh "Installed general pip packages!"

# Multi-platform install scripts
# 
# Exist for a variety of reasons:
#  * Cross-platform support.
#  * Supporting newer packages on LTS Debian
#  * Some packages I just always want the latest.
#  * etc...

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
./installScripts/install-ncdu.sh
./installScripts/install-caprine.sh
./installScripts/install-yq.sh

# User configuration
./configScripts/link-configs.sh
./configScripts/update-hosts.sh
./configScripts/setup-git.sh

# Install packages dependent on user configuration being present first.
./installScripts/installBorgTools/index.sh

if [[ $distro == 'ubuntu' ]]; then
    ./index.ubuntu.sh 
else 
    ./index.chromeos.sh 
fi

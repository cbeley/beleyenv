#!/bin/bash
set -e

sudo apt update

# Install the minimum for the few things that require
# prompting the user to do something.
sudo apt-get -y install jq

./configScripts/setup-ssh-keys.sh 

### Everything below this line should require zero prompting from the user ###

sudo apt-get -y install xz-utils nano apt-transport-https flatpak python3-pip \
	python3-libtorrent python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-appindicator3 \
	python3-dev python3-setuptools git zsh jq shellcheck git-cola

# Install Pip dependencies
# pygments is required by https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
sudo pip3 install deluge thefuck pygments

# Install Flatpak repositories & packages
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.valvesoftware.Steam

# Package installs that require more effort -- mostly because debian LTS tends to have
# very old packages.
./installScripts/installKitty/index.sh
./installScripts/install-zsh.sh
./installScripts/install-sublime.sh
./installScripts/install-todo.sh
./installScripts/install-lsd.sh
./installScripts/install-fonts.sh
./installScripts/install-node.sh

# User configuration
./configScripts/link-configs.sh
./configScripts/append-hosts.sh
./configScripts/setup-git.sh

# Still working on themeing
# ./install-theme.sh
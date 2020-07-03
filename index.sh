#!/bin/bash
set -e

sudo apt update
sudo apt-get -y install xz-utils nano apt-transport-https flatpak python3-pip \
	python3-libtorrent python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-appindicator3 \
	python3-dev python3-setuptools git zsh jq shellcheck git-cola REMOVEAFTERTHISMAYBE arc-theme \
	software-properties-common qt5-style-plugins

./install-kitty.sh
./install-zsh.sh
./install-sublime.sh
./install-node.sh
./install-todo.sh
./install-lsd.sh

./install-configs.sh
./appennd-hosts.sh
./setup-git.sh

# todo: Probally should be higher up.
./setup-ssh-keys.sh 

# Install Flatpak repositories & packages
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.valvesoftware.Steam

# Install Pip dependencies
# pygments is required by https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
pip3 install deluge thefuck pygments


# Set up GTK theme.
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/arc-kde/master/install.sh | sh
gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"

# new theme stuff probally:
gsettings set org.gnome.desktop.interface gtk-theme "Adapta-Nokto"
gsettings set org.gnome.desktop.interface icon-theme "Adapta-Nokto"
gsettings set org.gnome.desktop.wm.preferences theme "Adapta-Nokto"
sudo apt-get install adapta-gtk-theme adapta-ke

export QT_STYLE_OVERRIDE=gtk && export QT_QPA_PLATFORMTHEME=gtk2



sudo apt-get install qt5ct
#!/usr/bin/env bash
set -e 

sudo apt-get -y install adapta-gtk-theme dconf-editor
gsettings set org.gnome.desktop.interface gtk-theme "Adapta-Nokto"

./print.sh "Adapta-Nokto theme installed!"
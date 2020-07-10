#!/bin/bash
set -e 

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get -y install sublime-text sublime-merge

SUBLIME_LICENSE=$(jq -r '.sublimeLicense' config.json)
mkdir -p ~/.config/sublime-text-3/Local/
echo -e "$SUBLIME_LICENSE" > ~/.config/sublime-text-3/Local/License.sublime_license

echo "Sublime text installed with license!"

mkdir -p ~/.config/sublime-text-3/Packages
cp installScripts/installSublime/Systemd.sublime-syntax ~/.config/sublime-text-3/Packages

echo "Sublime text plugins not under package control installed"
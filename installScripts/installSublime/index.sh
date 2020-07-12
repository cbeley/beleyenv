#!/bin/bash
set -e 

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get -y install sublime-text sublime-merge

./print.sh "Sublime text installed!"

SUBLIME_LICENSE=$(jq -r '.sublimeLicense' config.json)

if [[ $SUBLIME_LICENSE = '' ]] || [[ $SUBLIME_LICENSE = 'null' ]]; then
    ./print.sh "No sublime license present in config.json\nSkipping automatic license install..."
else
    mkdir -p ~/.config/sublime-text-3/Local/
    echo -e "$SUBLIME_LICENSE" > ~/.config/sublime-text-3/Local/License.sublime_license
    ./print.sh "Sublime text license installed!"
fi

mkdir -p ~/.config/sublime-text-3/Packages
cp installScripts/installSublime/Systemd.sublime-syntax ~/.config/sublime-text-3/Packages

./print.sh "Sublime text plugins not under package control installed"
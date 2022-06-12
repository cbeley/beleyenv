#!/bin/bash
set -e 

if [[ $OSTYPE == 'darwin'* ]]; then
    brew install --cask sublime-text sublime-merge

    sublimeBaseFolder="$HOME/Library/Application Support"
    sublimeTextFolder="$sublimeBaseFolder/Sublime Text"
    sublimeMergeFolder="$sublimeBaseFolder/Sublime Merge"
else 
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get -y install sublime-text sublime-merge

    sublimeBaseFolder="$HOME/.config"
    sublimeTextFolder="$sublimeBaseFolder/sublime-text-3"
    sublimeMergeFolder="$sublimeBaseFolder/sublime-merge"
fi

./print.sh "Sublime text installed!"

SUBLIME_LICENSE=$(jq -r '.sublimeLicense' config.json)

if [[ $SUBLIME_LICENSE = '' ]] || [[ $SUBLIME_LICENSE = 'null' ]]; then
    ./print.sh "No sublime license present in config.json\nSkipping automatic license install..."
else
    mkdir -p "$sublimeTextFolder/Local/"
    mkdir -p "$sublimeMergeFolder/Local/"

    echo -e "$SUBLIME_LICENSE" > "$sublimeTextFolder/Local/License.sublime_license"
    echo -e "$SUBLIME_LICENSE" > "$sublimeMergeFolder/Local/License.sublime_license"
    ./print.sh "Sublime text license installed!"
fi

mkdir -p "$sublimeTextFolder/Packages"
cp installScripts/installSublime/Systemd.sublime-syntax "$sublimeTextFolder/Packages"

./print.sh "Sublime text plugins not under package control installed"
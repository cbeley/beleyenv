#!/usr/bin/env bash
set -e

# Set up convenience environment for server instances running on Ubuntu

sudo apt-get -y install jq shellcheck rsync \
    gocryptfs fd-find sshfs fzf bat htop rclone \
    fuse3 python3-pyfuse3

./installScripts/install-lazygit.sh
./installScripts/install-lazydocker.sh
./installScripts/install-delta.sh
./installScripts/install-ncdu.sh
./installScripts/install-lsd.sh
./installScripts/install-zsh.sh


./configScripts/link-shell-config.sh
./configScripts/link-lazygit-config.sh



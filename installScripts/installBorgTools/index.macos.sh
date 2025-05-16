#!/bin/bash

set -e

mkdir -p ~/bin
ln -sf "$(pwd)/installScripts/installBorgTools/borg-home-backup.sh" ~/bin
ln -sf "$(pwd)/installScripts/installBorgTools/borg-rclone-home-backup-to-gdrive.sh" ~/bin
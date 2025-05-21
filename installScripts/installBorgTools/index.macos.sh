#!/usr/bin/env bash

set -e

mkdir -p ~/bin
mkdir -p ~/.borgBackupRepo/logs/
ln -sf "$(pwd)/installScripts/installBorgTools/borg-home-backup.sh" ~/bin
ln -sf "$(pwd)/installScripts/installBorgTools/borg-rclone-home-backup-to-gdrive.sh" ~/bin
ln -sf "$(pwd)/installScripts/installBorgTools/borg-check.sh" ~/bin
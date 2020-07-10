#!/bin/bash
set -e 

sudo cp installScripts/installBorgTools/borg-home-backup.sh /usr/local/bin
cp installScripts/installBorgTools/borg-home-backup.service ~/.config/systemd/user/
cp installScripts/installBorgTools/borg-home-backup.timer ~/.config/systemd/user/

systemctl --user enable borg-home-backup.timer
systemctl --user start borg-home-backup.timer
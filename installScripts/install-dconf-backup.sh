#!/usr/bin/env bash 

set -e 

systemctl --user enable dconf-backup.service
systemctl --user enable dconf-backup.path

systemctl --user start dconf-backup.path
systemctl --user start dconf-backup.service

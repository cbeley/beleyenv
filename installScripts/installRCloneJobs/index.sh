#!/usr/bin/env bash
set -e 

# See notes in install-etc-hosts-watcher.sh for why disable.
systemctl --user disable rclone-jobs.timer
systemctl --user enable rclone-jobs.timer
systemctl --user start rclone-jobs.timer
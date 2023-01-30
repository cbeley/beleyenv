#!/bin/bash
set -e 

sudo ln -sf "$(pwd)/installScripts/installRCloneJobs/run-rclone-jobs.sh" /usr/local/bin

# See notes in install-etc-hosts-watcher.sh for why disable.
systemctl --user disable rclone-jobs.timer
systemctl --user enable rclone-jobs.timer
systemctl --user start rclone-jobs.timer
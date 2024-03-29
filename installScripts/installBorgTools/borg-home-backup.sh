#!/bin/bash

# This script is based off of
# https://borgbackup.readthedocs.io/en/stable/quickstart.html#automating-backups
 
notify-send -a "Borg Backup" "Linux currently backing up..."

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

# Generate excludes flags
cd "$HOME/.beleyenv/beleyenv" || exit 1

mapfile -t excludePaths < <(jq -r '.borg.excludes[]' config.json)

excludeFlags=()

for excludePath in "${excludePaths[@]}"; do
    excludeFlags+=(--exclude "$excludePath")
done

info "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:
borg create                 \
    --verbose               \
    --stats                 \
    --exclude-caches        \
    --one-file-system       \
    "${excludeFlags[@]}"    \
                            \
    ::'{now}'               \
    "$HOME"                          

backup_exit=$?

info "Pruning repository"

borg prune                          \
    --list                          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    notify-send -a "Borg Backup" "Successfully Backed Up Linux"
    info "Backup and Prune finished successfully"

    borg-rclone-home-backup-to-gdrive.sh
elif [ ${global_exit} -eq 1 ]; then
    notify-send -a "Borg Backup" "Linux Backed up with WARNINGS!"
    info "Backup and/or Prune finished with warnings"

    borg-rclone-home-backup-to-gdrive.sh
else
    notify-send -a "Borg Backup" "FAILED TO BACK UP LINUX!"
    info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}
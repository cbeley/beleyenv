#!/usr/bin/env bash

# This script is based off of
# https://borgbackup.readthedocs.io/en/stable/quickstart.html#automating-backups
 
notify() {
    local message="$1"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        terminal-notifier -title "Borg Backup" -message "$message"
    else
        notify-send -a "Borg Backup" "$message"
    fi
}

notify "Starting Borg Backup..."

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
    --exclude-if-present .nobackup \
    --patterns-from="$HOME/.beleyenv/beleyenv/configs/borgExcludes/macOS/core.lst" \
    --patterns-from="$HOME/.beleyenv/beleyenv/configs/borgExcludes/macOS/programming.lst" \
    --patterns-from="$HOME/.beleyenv/beleyenv/configs/borgExcludes/macOS/applications.lst" \
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
    notify "Borg Backup Successful!"
    info "Backup and Prune finished successfully"

    borg-rclone-home-backup-to-gdrive.sh
elif [ ${global_exit} -eq 1 ]; then
    notify "Borg Backup exited with WARNINGS!"
    info "Backup and/or Prune finished with warnings"

    borg-rclone-home-backup-to-gdrive.sh
else
    notify "BORG BACKUP FAILED!"
    info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}
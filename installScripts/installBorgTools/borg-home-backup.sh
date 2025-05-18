#!/usr/bin/env bash

# This script is based off of
# https://borgbackup.readthedocs.io/en/stable/quickstart.html#automating-backups

export NOTIFY_APP_NAME="BorgBackup"

cliNotify "Starting Borg Backup..."

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

# Exiting with 1 just means warnings, which is usually fine.
# Exiting > 1 means something went wrong.
if [ ${backup_exit} -gt 1 ]; then
    cliNotify "BORG BACKUP FAILED!"
    info "Borg backup exited with error code ${backup_exit}"
    exit ${backup_exit}
fi

info "Borg backup finished successfully or with warnings"

borg prune                          \
    --list                          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \

prune_exit=$?

if [ ${prune_exit} -gt 0 ]; then
    cliNotify "BORG PRUNE FAILED!"
    info "Borg prune exited with error code ${prune_exit}"
    exit ${prune_exit}
fi

info "Borg prune finished successfully"

borg compact

compact_exit=$?

if [ ${compact_exit} -gt 0 ]; then
    cliNotify "BORG COMPACT FAILED!"
    info "Borg compact exited with error code ${compact_exit}"
    exit ${compact_exit}
fi

info "Borg compact finished successfully"

if [ ${backup_exit} -eq 0 ]; then
    cliNotify "Borg Backup Successful!"
else
    cliNotify "Borg Backup exited with WARNINGS!"
fi

borg-rclone-home-backup-to-gdrive.sh
rclone_exit=$?

if [ "$rclone_exit" -ne 0 ]; then
    exit "$rclone_exit"
else
    exit "$backup_exit"
fi
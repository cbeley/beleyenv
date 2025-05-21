#!/bin/bash

set -e 

trap 'ctrlC' INT
trap 'theEnd $?' EXIT

export NOTIFY_APP_NAME="BorgRCloneSync"

beleyenvRoot="$HOME/.beleyenv/beleyenv"
distro="$("$beleyenvRoot/devScripts/get-distro.sh")"
borgRepo=$(jq -r ".borg.repo.$distro" "$beleyenvRoot/config.json")
borgRepoRCloneRemote=$(jq -r ".borg.rcloneRemote.$distro" "$beleyenvRoot/config.json")

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }

ctrlC() {
    info 'Borg rclone sync interrupted!'
    cliNotify "RClone sync got interrupt signal!"

    exit 1
}

theEnd() {
    if [[ "$1" != "0" ]]; then
        cliNotify "Borg repo rclone sync failed!"
    else
        cliNotify "Successfully rclone synced borg repo to $borgRepoRCloneRemote"
    fi
}

if [[ $borgRepo = '' ]] || [[ $borgRepo = 'null' ]]; then
    info '[WARN] No borg repo configured. Skipping rclone sync.'

    trap - INT EXIT
    exit 0
fi

if [[ $borgRepoRCloneRemote = '' ]] || [[ $borgRepoRCloneRemote = 'null' ]]; then
    info '[WARN] No rclone remote configured for borg on this distro. Skipping rclone sync.'
    
    trap - INT EXIT
    exit 0
fi

info "Starting rclone sync to $borgRepoRCloneRemote"

rclone sync "$borgRepo" "$borgRepoRCloneRemote"
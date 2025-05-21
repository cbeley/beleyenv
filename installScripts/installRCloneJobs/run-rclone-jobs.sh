#!/usr/bin/env bash 

set -e 

trap 'ctrlC' INT
trap 'theEnd $?' EXIT

notifyName="Beleyenv Rclone Jobs"

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }

ctrlC() {
    info 'Rclone jobs interrupted.'
    notify-send -a "$notifyName" "RClone jobs got interrupt signal!"

    exit 1
}

theEnd() {
    if [[ "$1" != "0" ]]; then
        info 'rclone jobs failed'
        notify-send -a "$notifyName" "Rclone jobs failed!"
    else
        info "Successfully ran rclone jobs"
        notify-send -a "$notifyName" "Successfully ran rclone jobs"
    fi
}

beleyenvRoot="$HOME/.beleyenv/beleyenv"
mapfile -t rcloneJobs < <(jq -r '.rcloneJobs[]?' "$beleyenvRoot/config.json")

if [[ ${#rcloneJobs[@]} = 0 ]]; then
    info '[WARN] No rclone jobs configured. Skipping'

    trap - INT EXIT
    exit 0
fi

(
    cd 

    index=0
    while [ "x${rcloneJobs[index]}" != "x" ]; do
        info "Running rclone ${rcloneJobs[index]}"
        eval "rclone --delete-before ${rcloneJobs[index]}"

        index=$(( index + 1 ))
    done
)

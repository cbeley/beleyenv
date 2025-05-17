#!/bin/bash

notify() {
    local message="$1"
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        terminal-notifier -title "Borg Check" -message "$message"
    else
        notify-send -a "Borg Check" "$message"
    fi
}

echo "Running Borg check..."

if borg check; then
    notify "Borg check passed. All is well!"
else
    notify "BORG CHECK FAILED - NEEDS ATTENTION!"
fi
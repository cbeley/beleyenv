#!/bin/bash

export NOTIFY_APP_NAME="BorgCheck"

echo "Running Borg check..."

if borg check; then
    cliNotify "Borg check passed. All is well!"
else
    cliNotify "BORG CHECK FAILED - NEEDS ATTENTION!"
fi
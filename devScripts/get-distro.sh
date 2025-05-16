#!/bin/bash

set -e

if grep -q 'ubuntu' /etc/os-release 2>/dev/null; then
   echo 'ubuntu'
elif [[ "$(uname)" == "Darwin" ]]; then
   echo 'macOS'
else
   echo 'chromeOS'
fi
#!/usr/bin/env bash

set -e

if [[ $OSTYPE == 'darwin'* ]]; then
    echo "$HOME/Library/Application Support"
else
    echo "$HOME/.config"
fi
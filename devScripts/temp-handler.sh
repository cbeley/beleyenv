#!/bin/bash 

rm -rf "$HOME/.beleyenv/beleyenv/temp"
mkdir -p "$HOME/.beleyenv/beleyenv/temp"

trap cleanUp EXIT

cleanUp() {
    rm -rf "$HOME/.beleyenv/beleyenv/temp"
}
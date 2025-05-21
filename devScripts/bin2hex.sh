#!/usr/bin/env bash
# Compliments of https://unix.stackexchange.com/questions/352569/converting-from-binary-to-hex-and-back
hexdump -v -e '1/1 "%02x"' "$1"
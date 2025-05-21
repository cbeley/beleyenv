#!/usr/bin/env bash
set -e 

EMAIL=$(jq -r '.email' config.json)
NAME=$(jq -r '.name' config.json)

git config --global user.email "$EMAIL"
git config --global user.name "$NAME"

./print.sh "git config setup!"
#!/usr/bin/env bash
set -e

OSConfigFolder="$(./configScripts/get-os-config-folder.sh)"

# Lazygit Configs
# Something fishy is going on with lazygit config location and his docs. 
# But this is what seems to work.
if [[ $OSTYPE == 'darwin'* ]]; then
    lazygitBase="$OSConfigFolder"
else
    lazygitBase="$OSConfigFolder/jesseduffield"
fi

mkdir -p "$lazygitBase/lazygit"
ln -sf "$(pwd)/configs/lazygit.config.yml" "$lazygitBase/lazygit/config.yml"

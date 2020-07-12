#!/bin/bash
set -e

# Kitty Config
mkdir -p ~/.config/kitty
ln -sf "$(pwd)/configs/kitty.conf" ~/.config/kitty/kitty.conf
echo "Kitty config installed!"

# Zsh Configs
ln -sf "$(pwd)/configs/.zshrc" ~/.zshrc
ln -sf "$(pwd)/configs/.p10k.zsh" ~/.p10k.zsh
echo "ZSH configs installed!"

# Todo Config
mkdir -p ~/.todo/
ln -sf "$(pwd)/configs/todo.conf" ~/.todo/config
echo "Todo.sh config installed!"

# Systemd Local Units & Overrides
rm -rf ~/.config/systemd
ln -sf "$(pwd)/configs/systemd" ~/.config/systemd
echo "systemd local units & overrides installed!"

# System-wide systemd Config
sudo rm -f /etc/systemd/journald.conf 
sudo ln -sf "$(pwd)/configs/etc/systemd/journald.conf" /etc/systemd/journald.conf 
sudo systemctl restart systemd-journald
echo "system-wide systemd configs installed!"

# Sublime Configs
mkdir -p ~/.config/sublime-text-3/Packages/User
# shellcheck disable=SC2016
find "$(pwd)/configs/sublime" -maxdepth 1 -mindepth 1 -print0 | xargs -n1 -0 -I {} bash -c 'ln -sf "{}" "$HOME/.config/sublime-text-3/Packages/User/$(basename "{}")"'
echo "Sublime configs installed!"

# Sublime Merge Configs
mkdir -p ~/.config/sublime-merge/Packages/User
# shellcheck disable=SC2016
find "$(pwd)/configs/sublime-merge" -maxdepth 1 -mindepth 1 -print0 | xargs -n1 -0 -I {} bash -c 'ln -sf "{}" "$HOME/.config/sublime-merge/Packages/User/$(basename "{}")"'
echo "Sublime merge configs installed!"

INSTALL_ENCRYPTED=$(jq -r '.installThingsWithEncryptedDeps' config.json)

if [[ $INSTALL_ENCRYPTED = 'true' ]]; then
    echo "Installing configs relying on encrypted files..."
    
    # Deluge Configs
    mkdir -p ~/.config/deluge
    ln -sf "$(pwd)/configs/deluge/gtk3ui.conf" ~/.config/deluge/gtk3ui.conf
    ln -sf "$(pwd)/configs/deluge/hostlist.conf" ~/.config/deluge/hostlist.conf
    echo "Deluge configs installed!"

else
    echo "Skipping installing configs relying on encrypted files..."
fi


echo "All configs installed!"
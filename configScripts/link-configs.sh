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

# Overriden Sommelier Config
rm -rf ~/.config/systemd
ln -sf "$(pwd)/configs/systemd" ~/.config/systemd
echo "systemd local overrides installed!"

# System-wide systemd Config
sudo rm -f /etc/systemd/journald.conf 
sudo ln -sf "$(pwd)/configs/etc/systemd/journald.conf" /etc/systemd/journald.conf 
sudo systemctl restart systemd-journald
echo "system-wide systemd configs installed!"

# Deluge Configs
mkdir -p ~/.config/deluge
ln -sf "$(pwd)/configs/deluge/gtk3ui.conf" ~/.config/deluge/gtk3ui.conf
ln -sf "$(pwd)/configs/deluge/hostlist.conf" ~/.config/deluge/hostlist.conf
echo "Deluge configs installed!"

# Sublime Configs
mkdir -p ~/.config/sublime-text-3/Packages/User
ls ./configs/sublime | xargs -I {} ln -sf "$(pwd)/configs/sublime/{}" ~/.config/sublime-text-3/Packages/User/{}

# Sublime Merge Configs
mkdir -p ~/.config/sublime-merge/Packages/User
ls ./configs/sublime-merge | xargs -I {} ln -sf "$(pwd)/configs/sublime-merge/{}" ~/.config/sublime-merge/Packages/User/{}

echo "All configs installed!"
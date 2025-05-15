#!/bin/bash
set -e

# Note that only some people use /Library/Application Support on MacOS.
# ...wonderful.
if [[ $OSTYPE == 'darwin'* ]]; then
    OSConfigFolder="$HOME/Library/Application Support"
else
    OSConfigFolder="$HOME/.config"
fi

# Kitty Config
mkdir -p ~/.config/kitty
ln -sf "$(pwd)/configs/kitty.conf" ~/.config/kitty/kitty.conf
./print.sh "Kitty config installed!"

# Zsh Configs
ln -sf "$(pwd)/configs/.zshrc" ~/.zshrc
ln -sf "$(pwd)/configs/.zprofile" ~/.zprofile
ln -sf "$(pwd)/configs/.zshenv" ~/.zshenv
ln -sf "$(pwd)/configs/.p10k.zsh" ~/.p10k.zsh
./print.sh "ZSH configs installed!"

# Todo Config
# I have rarely used this. May delete. TODO ...lol.
# mkdir -p ~/.todo/
# ln -sf "$(pwd)/configs/todo.conf" ~/.todo/config
# ./print.sh "Todo.sh config installed!"

# Sublime Base Folder
if [[ $OSTYPE == 'darwin'* ]]; then
    sublimeTextFolder="$OSConfigFolder/Sublime Text"
    sublimeMergeFolder="$OSConfigFolder/Sublime Merge"
else
    sublimeTextFolder="$OSConfigFolder/sublime-text-3"
    sublimeMergeFolder="$OSConfigFolder/sublime-merge"
fi 

mkdir -p "$OSConfigFolder/sublime-text-3/Packages/User"
mkdir -p "$OSConfigFolder/sublime-merge/Packages/User"

# Sublime Configs
mkdir -p "$sublimeTextFolder/Packages/User"

# shellcheck disable=SC2016
find "$(pwd)/configs/sublime" -maxdepth 1 -mindepth 1 -print0 | xargs -0 -I {} bash -c "ln -sf \"{}\" \"$sublimeTextFolder/Packages/User/\$(basename \"{}\")\""
./print.sh "Sublime configs installed!"

# Sublime Merge Configs
mkdir -p "$sublimeMergeFolder/Packages/User"

# shellcheck disable=SC2016
find "$(pwd)/configs/sublime-merge" -maxdepth 1 -mindepth 1 -print0 | xargs -0 -I {} bash -c "ln -sf \"{}\" \"$sublimeMergeFolder/Packages/User/\$(basename \"{}\")\""
./print.sh "Sublime merge configs installed!"

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

# tldr config
ln -sf "$(pwd)/configs/.tldrrc" ~/.tldrrc
./print.sh "tldr config installed!"

if [[ $OSTYPE == 'darwin'* ]]; then
    ##### MacOS Specific Configs
    ./print.sh "Installing MacOS Specific Configs"
else 
    ##### ChromeOS & Ubuntu Only Configs
    ./print.sh "Installing Linux Specific Configs"

    # Systemd Local Units & Overrides
    rm -rf ~/.config/systemd
    ln -sf "$(pwd)/configs/systemd" ~/.config/systemd
    ./print.sh "systemd local units & overrides installed!"

    INSTALL_ENCRYPTED=$(jq -r '.installThingsWithEncryptedDeps' config.json)

    if [[ $INSTALL_ENCRYPTED = 'true' ]]; then
        ./print.sh "Installing configs relying on encrypted files..."
        
        # Deluge Configs
        mkdir -p ~/.config/deluge
        ln -sf "$(pwd)/configs/deluge/gtk3ui.conf" ~/.config/deluge/gtk3ui.conf
        ln -sf "$(pwd)/configs/deluge/hostlist.conf" ~/.config/deluge/hostlist.conf
        ./print.sh "Deluge configs installed!"

    else
        ./print.sh "Skipping installing configs relying on encrypted files..."
    fi
fi

if grep -q 'ID=debian' /etc/os-release; then 
    ##### ChromeOS Specific Configs
    ./print.sh "Installing ChromeOS Specific Configs"

    # dnsmasq.d
    sudo rm -rf /etc/dnsmasq.d
    sudo ln -sf "$(pwd)/configs/dnsmasq.d" /etc/dnsmasq.d
    sudo systemctl restart dnsmasq
    ./print.sh "dnsmasq.d configs installed!"

    # gtkrc-2.0 config
    ln -sf "$(pwd)/configs/.gtkrc-2.0" ~/.gtkrc-2.0
    ./print.sh "GTK config installed!"

    # System-wide systemd Config
    sudo rm -f /etc/systemd/journald.conf 
    sudo ln -sf "$(pwd)/configs/etc/systemd/journald.conf" /etc/systemd/journald.conf 
    sudo systemctl restart systemd-journald
    ./print.sh "system-wide systemd configs installed!"
fi

if grep -q 'ID=ubuntu' /etc/os-release; then 
    ./print.sh "Installing Ubuntu specific configs"

    rm -rf ~/.config/solaar
    ln -sf "$(pwd)/configs/solaar" ~/.config/solaar
    ./print.sh "Solaar config installed!"

    # wireplumber/pipewire config
    rm -rf ~/.config/wireplumber
    ln -sf "$(pwd)/configs/wireplumber" ~/.config/wireplumber
    systemctl --user restart wireplumber
    ./print.sh "wireplumber configs installed!"
fi

./print.sh "All configs installed!"
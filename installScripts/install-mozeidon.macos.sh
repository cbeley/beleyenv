#!/usr/bin/env bash 

set -e
# Firefox Mozeidon for programatic control by other apps like Raycast and terminal
# https://github.com/egovelox/mozeidon-native-app/
brew tap egovelox/homebrew-mozeidon
brew install egovelox/mozeidon/mozeidon-native-app egovelox/mozeidon/mozeidon
mkdir -p ~/Library/Application\ Support/Mozilla/NativeMessagingHosts
cat > ~/Library/Application\ Support/Mozilla/NativeMessagingHosts/mozeidon.json <<EOF
{
    "name": "mozeidon",
    "description": "Native messaging add-on to interact with your browser",
    "path": "/opt/homebrew/bin/mozeidon-native-app",
    "type": "stdio",
    "allowed_extensions": [
        "mozeidon-addon@egovelox.com"
    ]
}
EOF
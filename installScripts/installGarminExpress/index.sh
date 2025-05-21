#!/usr/bin/env bash
set -e 

source ./devScripts/temp-handler.sh

# Thanks to
# https://gist.github.com/diegorodrigo90/2be8213f3dab0583446f6cf52d397d30

export WINEARCH=win32
export WINEPREFIX=$HOME/.wine/GarminExpress

winetricks --unattended \
    dotnet472 vcrun2010 corefonts \
    d3dcompiler_47

winetricks win7

(
    cd temp

    wget https://download.garmin.com/omt/express/GarminExpress.exe

    wine explorer \
        /desktop=garmin,1366x768 \
        ./GarminExpress.exe /passive
)

mkdir -p "$HOME/.icons"
ln -sf \
    "$HOME/.beleyenv/beleyenv/installScripts/installGarminExpress/icon.png" \
    "$HOME/.icons/garmin-express.png"

# Remove the original entry that wine adds that will not work in this case.
rm -rf "$HOME/.local/share/applications/wine/Programs/Garmin"

ln -fs "$HOME/.beleyenv/beleyenv/installScripts/installGarminExpress/GarminExpress.desktop" \
    "$HOME/.local/share/applications/Garmin-Express.desktop"
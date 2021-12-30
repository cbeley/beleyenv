#!/bin/bash

set -e

# Install dependencies specific to KCC. Normally I'd 
# stick apt-get deps in index.sh, but I don't forsee needing
# these deps elsewhere for now.

sudo apt-get install pyqt5-dev-tools pyqt5-dev
sudo pip3 install Pillow psutil python-slugify raven

sudo mkdir -p /usr/local/beleyenv/bin/

sudo rm -rf /usr/local/beleyenv/kcc
sudo git clone https://github.com/ciromattia/kcc /usr/local/beleyenv/kcc

kccPaperwhitePatch="$(pwd)/installScripts/installKCC/kindle-paperwhite-support.patch"

(
    cd /usr/local/beleyenv/kcc 

    # To avoid this PR creator from adding anything malicious to their 
    # PR down the line, I've archived a patch I verified in this repo. The
    # PR is at https://github.com/ciromattia/kcc/pull/405.
    # Since KCC seems to be dead, I suspect it may never actually be
    # merged.
    sudo git apply "$kccPaperwhitePatch"
)

sudo cp installScripts/installKCC/kcc /usr/local/beleyenv/bin
sudo cp installScripts/installKCC/kcc.desktop /usr/local/beleyenv/kcc/

# Install and Link the also no longer supported kindlegen.
# Amazon no longer hosts it, but it is on archive.org.
# I'm too afraid to copy it into this repo.
sudo rm -f /usr/local/beleyenv/bin/kindlegen
sudo wget -P /usr/local/beleyenv/bin https://archive.org/download/kindlegen/kindlegen
sudo chmod +x /usr/local/beleyenv/bin/kindlegen

# Link everything new in /usr/local/beleyenv/bin to /usr/local/bin
sudo ln -sf /usr/local/beleyenv/bin/kcc /usr/local/bin/
sudo ln -sf /usr/local/beleyenv/bin/kindlegen /usr/local/bin/

# Link the icon 
sudo ln -fs /usr/local/beleyenv/kcc/kcc.desktop /usr/local/share/applications/
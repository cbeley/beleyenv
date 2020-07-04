#!/bin/bash
set -e 


# this is a work in progress.

# TODO: Find out whether we need to explicitly install qt5-style-plugins
sudo apt-get -y install adapta-gtk-theme qt5-style-plugins 

# optiona packages
sudo apt-get install dconf-editor lxapperance

# These are needed for apps like sublime to work.  gsettings provides this.
gsettings set org.gnome.desktop.interface gtk-theme "Adapta-Nokto"

# I dont' think the two below should be set.
#gsettings set org.gnome.desktop.interface icon-theme "Adapta-Nokto"
#gsettings set org.gnome.desktop.wm.preferences theme "Adapta-Nokto"

# We also may not need gsettings and could instead just save /.config/dconf


# lxappearance sets .gtkrc-2.0.  It's not needed though if you just set the file contents manually.
# TODO: Add .gtkrc-2.0 config to the config restore scripts.
# qt5-style-plugins may need to be explicitly installed though.

# this may get set by something else and likely is not necesary to set manually.  Verify
# this after a clean install.
export QT_QPA_PLATFORMTHEME=gtk2

# this stuff is probally not needed.  Saving for reference.
# export QT_STYLE_OVERRIDE=gtk

# Will probally not use this.  Will play with it more under a clean install.
#sudo apt-get install qt5ct


# possibly tweak more.
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.2
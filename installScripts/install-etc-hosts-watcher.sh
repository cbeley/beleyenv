#!/bin/bash

set -e 

# To keep things simple, we just sym-link the entire systemd/user directory; however,
# this means that we create an absolute symlink that is checked in. This will ensure
# that if someone with a different user name uses this, those symlinks will be cleaned up
# and replaced appropriately.
systemctl --user disable etc-hosts-watcher.service
systemctl --user disable etc-hosts-watcher.path

systemctl --user enable etc-hosts-watcher.service
systemctl --user enable etc-hosts-watcher.path

systemctl --user stop etc-hosts-watcher.path
systemctl --user stop etc-hosts-watcher.service

systemctl --user start etc-hosts-watcher.path
systemctl --user start etc-hosts-watcher.service
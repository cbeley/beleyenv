#!/bin/bash 
set -e 

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker "$USER"

# It seems this is done by default, but adding just for safe-measure.
sudo systemctl enable docker 
echo "Docker installed!"

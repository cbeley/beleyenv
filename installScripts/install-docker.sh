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

sudo mkdir -p /usr/local/beleyenv/bin
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/beleyenv/bin/docker-compose
sudo ln -sf /usr/local/beleyenv/bin/docker-compose /usr/local/bin/
sudo chmod +x /usr/local/beleyenv/bin/docker-compose

./print.sh "Docker installed!"

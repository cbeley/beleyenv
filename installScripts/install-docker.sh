#!/usr/bin/env bash 
set -e 

sudo mkdir -p /etc/apt/keyrings

if grep -q 'ubuntu' /etc/os-release; then 
   distro='ubuntu'
else 
   distro='debian'
fi 

curl -fsSL "https://download.docker.com/linux/$distro/gpg" \
   | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/$distro \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker "$USER"

# It seems this is done by default, but adding just for safe-measure.
sudo systemctl enable docker 

./print.sh "Docker installed!"

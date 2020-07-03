#!/bin/bash
set -e 

# TODO: make this idempotent

cat configs/hosts | sudo tee -a /etc/hosts

echo "Hosts file appended!"
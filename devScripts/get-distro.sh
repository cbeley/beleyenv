#!/bin/bash 

set -e 

if grep -q 'ubuntu' /etc/os-release; then 
   echo 'ubuntu'
else 
   echo 'chromeOS'
fi 
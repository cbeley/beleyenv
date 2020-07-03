#!/bin/bash
set -e 

HOSTS=($(jq -r '.hosts[][1]' config.json))
IPADDRS=($(jq -r '.hosts[][0]' config.json))

index=0
while [ "x${HOSTS[index]}" != "x" ]; do
	sudo hostess add "${HOSTS[index]}" "${IPADDRS[index]}"
	index=$(( $index + 1 ))
done


echo "Hosts file updated!"
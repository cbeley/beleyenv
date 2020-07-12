#!/bin/bash
set -e 

mapfile -t HOSTS < <(jq -r '.hosts[][1]' config.json)
mapfile -t IPADDRS < <(jq -r '.hosts[][0]' config.json)

index=0
while [ "x${HOSTS[index]}" != "x" ]; do
	sudo hostess add "${HOSTS[index]}" "${IPADDRS[index]}"
	index=$(( index + 1 ))
done


./print.sh "Hosts file updated!"
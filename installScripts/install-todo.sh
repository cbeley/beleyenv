#!/bin/bash
set -e

# https://github.com/todotxt/todo.txt-cli
# powerline10k integreates with this.

rm -rf temp
mkdir temp

(
    cd temp

    curl -s https://api.github.com/repos/todotxt/todo.txt-cli/releases/latest \
	   | jq -r '[.assets[].browser_download_url]
		  | map(select(endswith("gz")))
		  | .[0]' \
	   | xargs curl -L \
	   | tar -zxv

    (
        cd ./*
        sudo mkdir -p /usr/local/beleyenv/bin
        sudo cp todo.sh /usr/local/beleyenv/bin/
        sudo ln -sf /usr/local/beleyenv/bin/todo.sh /usr/local/bin/
    )
)

./print.sh "todo.sh installed to /usr/local/bin"
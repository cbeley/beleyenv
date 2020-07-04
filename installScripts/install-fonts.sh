#!/bin/bash
set -e

rm -rf temp
mkdir temp

cd temp

# Unpatched latest Fantasque sans mono
wget https://github.com/belluzj/fantasque-sans/releases/latest/download/FantasqueSansMono-Normal.tar.gz
tar -zxvf FantasqueSansMono-Normal.tar.gz

# Fantasqe Mono patched with nerd fonts for powerline prompt
mkdir patchedFantasqueSansMono

(
	cd patchedFantasqueSansMono
	
	wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FantasqueSansMono.zip
	unzip FantasqueSansMono.zip
	rm ./*Windows*
	
	# Want the monospace fonts only
	rm ./*Complete.ttf
)

mkdir -p ~/.fonts 
cp -R OTF/*.otf ~/.fonts/
cp -R patchedFantasqueSansMono/*.ttf ~/.fonts/

echo "Fonts installed!"
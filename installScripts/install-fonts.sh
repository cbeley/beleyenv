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
	rm -f ./*Windows*
	
	# Want the monospace fonts only
	rm -f ./*Complete.ttf
)



if [[ $OSTYPE == 'darwin'* ]]; then
	fontDir="$HOME/Library/Fonts/"
else 
	fontDir="$HOME/.fonts/"
fi

mkdir -p "$fontDir"

cp -R OTF/*.otf "$fontDir"
cp -R patchedFantasqueSansMono/*.ttf "$fontDir"

../print.sh "Fonts installed!"
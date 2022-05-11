#!/bin/sh

git clone https://aur.archlinux.org/paru
cd paru
makepkg -si
cd ..
rm -rf paru

paru -S archlinux-keyring
paru -Syu - < pkg-files/minimal.txt

cp -r .config ~
cp -r .local ~
ln -s ~/.config/.zshenv ~
git clone https://github.com/streetturtle/awesome-wm-widgets ~/.config/awesome
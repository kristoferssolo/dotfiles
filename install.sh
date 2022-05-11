#!/bin/sh

git clone https://aur.archlinux.org/paru
cd paru
makepkg -si
cd ..

paru -Syu - < pkg-files/minimal.txt

cp -r .config ~
cp -r .local ~
cp .zshenv ~
git clone https://github.com/streetturtle/awesome-wm-widgets ~/.config/awesome
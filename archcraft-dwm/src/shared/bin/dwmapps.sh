#!/usr/bin/env bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>

## Launch Applications

if [[ "$1" == "--file" ]]; then
	thunar
elif [[ "$1" == "--editor" ]]; then
	flatpak run md.obsidian.Obsidian
elif [[ "$1" == "--web" ]]; then
	#cd /opt/mullvad
	#./start-mullvad-browser.desktop
  librewolf
fi

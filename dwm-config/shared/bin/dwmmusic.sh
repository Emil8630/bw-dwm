#!/usr/bin/env bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
##
## Run ncmpcpp with alternate config

# dwm directory
DIR='/usr/share/archcraft/dwm'

CONFIG="$DIR/alacritty/alacritty.yml"

alacritty --class 'Music,Music' --config-file "$CONFIG" \
		  -o window.dimensions.columns=109 window.dimensions.lines=22 \
		  -e ~/.ncmpcpp/scripts/ncmpcpp-art

#!/usr/bin/env bash

# TODO: move this stuff (and seperate appropriately)
#       into a proper startup deal

# initializing wallpaper daemon
swww-daemon &
# setting wallpaper
sleep 2 && swww img ~/Wallpapers/DemonChild.png &

#nm-applet --indicator &

# Aylur's Gtk Shell
ags &

# Clipboard manager
clipse -listen &

# dust
dunst

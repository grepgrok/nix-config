#!/usr/bin/env bash

# initializing wallpaper daemon
swww-daemon &
# setting wallpaper
sleep 2 && swww img ~/Wallpapers/DemonChild.png &

#nm-applet --indicator &

# the bar
#waybar &

# dust
#dunst

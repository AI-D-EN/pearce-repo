#!/bin/bash

# Load colors
source ~/.config/hypr/colors.conf

# Borders
hyprctl keyword general:col.active_border "$active_border"
hyprctl keyword general:col.inactive_border "$inactive_border"

sleep 0.2

# Kitty
kill -SIGUSR1 $(pidof kitty)

sleep 0.2

# Waybar
pkill waybar
sleep 0.5
waybar > /dev/null 2>&1 &

sleep 0.3

# SwayNC
swaync-client --reload-css

sleep 0.2

# SwayOSD
pkill -x swayosd-server
sleep 0.5
nohup swayosd-server > /dev/null 2>&1 &

sleep 0.2

# Notification
notify-send "Matugen" "Theme Reloaded"

sleep 0.2

# Hyprland
hyprctl reload

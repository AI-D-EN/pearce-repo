#!/bin/bash

WALLDIR="$HOME/Pictures/wallpapers"
THUMBDIR="$HOME/.cache/wallthumbs"

mkdir -p "$THUMBDIR"

chosen=$(for img in "$WALLDIR"/*; do
    filename=$(basename "$img")
    thumb="$THUMBDIR/$filename.png"

    if [ ! -f "$thumb" ]; then
        magick "$img" \
            -resize 320x180^ \
            -gravity center \
            -crop 320x180+0+0 \
            +repage \
            "$thumb"
    fi

    printf "%s\x00icon\x1f%s\n" "$filename" "$thumb"

done | rofi \
    -dmenu \
    -i \
    -show-icons \
    -theme ~/.config/rofi/wallpaper.rasi \
    -p "Wallpaper")

[ -z "$chosen" ] && exit

WALL="$WALLDIR/$chosen"

# =========================================
# Change Wallpaper
# =========================================

awww img \
    --transition-type grow \
    --transition-pos top \
    --transition-duration 2 \
    --transition-fps 144 \
    "$WALL"

# =========================================
# Generate Matugen Colors
# =========================================

matugen image "$WALL" \
    -m dark \
    -t scheme-vibrant \
    --prefer saturation \
    -q

# =========================================
# Load Hyprland Colors
# =========================================

source ~/.config/hypr/colors.conf

# =========================================
# Apply Borders
# =========================================

hyprctl keyword general:col.active_border "$active_border"

hyprctl keyword general:col.inactive_border "$inactive_border"

# =========================================
# Reload Kitty
# =========================================

kill -SIGUSR1 $(pidof kitty)

# =========================================
# Reload Waybar
# =========================================

pkill waybar

waybar > /dev/null 2>&1 &

# =========================================
# Reload SwayNC
# =========================================

swaync-client --reload-css

# =========================================
# Reload SwayOSD
# =========================================

pkill -x swayosd-server

nohup swayosd-server > /dev/null 2>&1 &

# =========================================
# Notification
# =========================================

notify-send "Wallpaper Changed" "$chosen"

# =========================================
# Reload Hyprland LAST
# =========================================

hyprctl reload

# =========================================
# Thunar
# =========================================

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
pkill thunar
sleep 0.3
#thunar > /dev/null 2>&1 &

# =========================================
# firefox
# =========================================

sleep 0,5
pkill firefox
#firefox &

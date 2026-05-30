#!/bin/bash

battery=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "$battery" -ge 90 ]; then
    icon="󰁹"
elif [ "$battery" -ge 70 ]; then
    icon="󰂀"
elif [ "$battery" -ge 50 ]; then
    icon="󰁿"
elif [ "$battery" -ge 30 ]; then
    icon="󰁼"
else
    icon="󰂃"
fi

echo "$icon $battery%"

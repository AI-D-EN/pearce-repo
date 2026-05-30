#!/bin/bash

# Single fast weather request
data=$(curl -s 'wttr.in/Bhopal?format=%C|%t')

# Split condition and temperature
weather=$(echo "$data" | cut -d '|' -f1)
temp=$(echo "$data" | cut -d '|' -f2 | sed 's/+//')

# Weather icons
case "$weather" in
    *Sunny*|*Clear*)
        icon="󰖙"
        ;;
    *Cloud*|*Overcast*)
        icon="󰖐"
        ;;
    *Rain*|*Drizzle*)
        icon="󰖗"
        ;;
    *Thunder*)
        icon="󰖓"
        ;;
    *Snow*)
        icon="󰖘"
        ;;
    *Mist*|*Fog*|*Haze*)
        icon="󰖑"
        ;;
    *)
        icon="󰖕"
        ;;
esac

# Final output
echo " Bhopal ➤ $icon $temp $weather"

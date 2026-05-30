#!/usr/bin/env bash

LINE=$(kdeconnect-cli -l | grep "paired and reachable" | head -n 1)

if [ -z "$LINE" ]; then
    echo "📱❌"
    exit 0
fi

DEVICE_NAME=$(echo "$LINE" | sed -E 's/- (.*):.*/\1/')
DEVICE_ID=$(echo "$LINE" | sed -E 's/.*: ([a-f0-9]+).*/\1/')

BATTERY=$(qdbus org.kde.kdeconnect \
/modules/kdeconnect/devices/$DEVICE_ID/battery \
org.kde.kdeconnect.device.battery.charge 2>/dev/null)

CHARGING=$(qdbus org.kde.kdeconnect \
/modules/kdeconnect/devices/$DEVICE_ID/battery \
org.kde.kdeconnect.device.battery.isCharging 2>/dev/null)

if [ -n "$BATTERY" ]; then
    if [ "$CHARGING" = "true" ]; then
        echo "📱 $DEVICE_NAME $BATTERY% ⚡ "
    else
        echo "📱 $DEVICE_NAME $BATTERY%"
    fi
else
    echo "📱 $DEVICE_NAME"
fi

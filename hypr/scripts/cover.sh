#!/bin/bash

mkdir -p ~/.cache

url=$(playerctl metadata mpris:artUrl 2>/dev/null)

if [[ -n "$url" ]]; then
    curl -sL "$url" -o ~/.cache/cover.jpg
fi

#!/usr/bin/env bash

COUNT=$(cliphist list | wc -l)

if [ "$COUNT" -gt 0 ]; then
    echo "󰅌 $COUNT"
else
    echo "󰅌"
fi

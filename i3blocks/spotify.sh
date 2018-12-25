#!/bin/bash

playstatus=$(playerctl status)

if [[ $? -ne 0 || $playstatus == "Not available" ]]; then
    echo ""
    echo ""
    echo ""
    exit 1
fi

track=$(playerctl metadata title)
artist=$(playerctl metadata artist)

str="▶ $artist - $track"
if [[ $playstatus == "Paused" ]]; then
    str=" $artist - $track"
fi

printf '%-40s' "$str"
exit 0

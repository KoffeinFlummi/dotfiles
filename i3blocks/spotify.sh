#!/bin/bash

playstatus=$(playerctl status)

if [ $playstatus == "Not available" ]; then
    echo ""
    echo ""
    echo ""
    exit 1
fi

track=$(playerctl metadata title)
artist=$(playerctl metadata artist)

if [ $playstatus == "Paused" ]; then
    echo " $artist - $track"
    exit 0
fi

echo "▶ $artist - $track"
#echo " $artist - $track"
exit 0

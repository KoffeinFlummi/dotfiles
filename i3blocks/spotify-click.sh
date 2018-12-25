#!/bin/bash

if [[ $BLOCK_BUTTON == "1" ]]; then
    playerctl play-pause
elif [[ $BLOCK_BUTTON == "2" ]]; then
    playerctl previous
elif [[ $BLOCK_BUTTON == "3" ]]; then
    playerctl next
fi
pkill -RTMIN+5 i3blocks
~/tools/update_cover_bg.sh

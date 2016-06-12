#!/bin/bash

if [ $(hostname) != "alfheim" ]; then
    echo ""
    echo ""
    echo ""
    exit 1
fi

brightness=$(cat /sys/class/backlight/mba6x_backlight/actual_brightness | awk '{print int($1 / 2.5)}')

echo " $brightness%"

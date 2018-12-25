#!/bin/bash

targetres=$(xrandr | tr "," "\n" | sed -n '2p' | tail -c +10 | sed 's/ //g')

scrot -q 1 /tmp/screenshot.jpg
convert /tmp/screenshot.jpg -resize 77x45 -scale $targetres /tmp/screenshotblur.png
i3lock -i /tmp/screenshotblur.png

#!/bin/bash

temp=$(sensors | grep Package | grep -o +[0-9]* | head -1 | tail -c +2)

echo " $temp°C"

if [ $usage -ge 90 ]; then
    play --no-show-progress --null --channels 1 synth 0.4 sine 900
fi

if [ $temp -ge 70 ]; then
    exit 33
fi

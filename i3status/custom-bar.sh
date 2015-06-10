#!/bin/bash

i3status | while :
do
    read line
    echo $(~/.config/i3status/custom-segments.py $line)
done

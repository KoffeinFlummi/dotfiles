#!/bin/bash

temp=$(sensors | grep Package | grep -o +[0-9]* | head -1 | tail -c +2)

echo " $temp°C"

if [ $temp -ge 70 ]; then
    exit 33
fi

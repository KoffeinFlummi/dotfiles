#!/bin/bash

if [ $(hostname) != "alfheim" ]; then
    echo ""
    echo ""
    echo ""
    exit 1
fi

ssid=$(iwconfig | grep -o ESSID.*)
address=$(ip addr | grep -o '192\..*\..*\..*/' | head -c -2)

if [ $ssid == "ESSID:off/any" ]; then
    echo " down"
    echo " down"
    echo "#fb4934"
    exit 0
fi

ssid=$(iwconfig | grep -o ESSID.* | tail -c +8 | head -c -4)

echo " $address ($ssid)"
echo " $ssid"
echo "#b8bb26"

#!/bin/bash

if [ $(hostname) != "vanaheim" ]; then
    echo ""
    echo ""
    echo ""
    exit 1
fi

address=$(ip addr | grep -o '192\..*\..*\..*/' | head -c -2)

echo " $address"
echo " $address"
echo "#b8bb26"

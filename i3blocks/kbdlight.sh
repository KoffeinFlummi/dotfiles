#!/bin/bash

if [ $(hostname) != "alfheim" ]; then
    echo ""
    echo ""
    echo ""
    exit 1
fi

brightness=$(kbdlight get | awk '{print int($1 / 2.5)}')

echo " $brightness%"

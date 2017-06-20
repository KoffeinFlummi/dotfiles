#!/bin/bash

if [ $(hostname) != "alfheim" ]; then
    echo ""
    echo ""
    echo ""
    exit 1
fi

brightness=$(xbacklight | awk '{print int($1)}')

echo " $brightness%"

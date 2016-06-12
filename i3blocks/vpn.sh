#!/bin/bash

if [ -d /proc/sys/net/ipv4/conf/tun0 ]; then
    echo " up"
    echo " up"
    echo "#b8bb26"
else
    echo " down"
    echo " down"
    echo "#fb4934"
fi

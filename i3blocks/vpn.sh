#!/bin/bash

color="#b8bb26"
vpn=" down"
firewall=" down"
killswitch=" down"

if [ -d /proc/sys/net/ipv4/conf/tun0 ]; then
    vpn=" up"
else
    color="#fb4934"
fi

enabled=$(ag ENABLED /etc/ufw/ufw.conf)
service=$(systemctl status ufw | ag active | awk '{print $2}')

if [ $enabled == "ENABLED=yes" -a $service == "active" ]; then
    firewall=" up"
else
    color="#fb4934"
fi

output_policy=$(ag DEFAULT_OUTPUT_POLICY /etc/default/ufw)

if [ $output_policy == "DEFAULT_OUTPUT_POLICY=\"DROP\"" ]; then
    killswitch=" up"
else
    color="#fb4934"
fi

echo "$vpn $firewall $killswitch"
echo "$vpn $firewall $killswitch"
echo $color

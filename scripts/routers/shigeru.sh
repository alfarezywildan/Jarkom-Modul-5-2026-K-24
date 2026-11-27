#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sysctl -w net.ipv4.ip_forward=1
ip route replace default via 192.223.4.129
ip route replace 192.223.4.88/29 via 192.223.4.170

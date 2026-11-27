#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sysctl -w net.ipv4.ip_forward=1
ip route replace default via 192.223.4.133
ip route replace 192.223.3.192/27 via 192.223.4.146
ip route replace 192.223.4.72/29 via 192.223.4.150

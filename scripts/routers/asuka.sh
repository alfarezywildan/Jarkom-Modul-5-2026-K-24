#!/bin/sh
sysctl -w net.ipv4.ip_forward=1
ip route replace default via 192.223.4.117
ip route replace 192.223.3.128/26 via 192.223.4.138
ip route replace 192.223.4.48/29 via 192.223.4.142

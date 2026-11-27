#!/bin/sh
sysctl -w net.ipv4.ip_forward=1
ip route replace default via 192.223.4.109
ip route replace 192.223.0.0/23 via 192.223.4.154
ip route replace 192.223.4.0/27 via 192.223.4.158
ip route replace 192.223.4.32/28 via 192.223.4.162

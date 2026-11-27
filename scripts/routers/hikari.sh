#!/bin/sh
sysctl -w net.ipv4.ip_forward=1
ip route replace default via 192.223.4.113
ip route replace 192.223.3.224/27 via 192.223.4.166

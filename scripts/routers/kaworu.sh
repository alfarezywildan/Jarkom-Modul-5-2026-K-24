#!/bin/sh
sysctl -w net.ipv4.ip_forward=1
ip route replace default via 192.223.4.165

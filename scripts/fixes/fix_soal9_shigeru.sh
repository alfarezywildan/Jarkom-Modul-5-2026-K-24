#!/bin/sh
# Perbaikan 4 penyebab sabotase break_routing.sh di Shigeru
sysctl -w net.ipv4.ip_forward=1
ip route del blackhole 192.223.4.72/29 2>/dev/null || true
ip rule del pref 90 2>/dev/null || true
ip route flush table 100 2>/dev/null || true
sh /root/shigeru.sh

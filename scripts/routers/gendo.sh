#!/bin/sh
# === SOAL 2: IP Forwarding ===
sysctl -w net.ipv4.ip_forward=1

# === SOAL 3: Static Routing + Summarization ===
# Cabang Yui (via 192.223.4.110)
ip route replace 192.223.0.0/23 via 192.223.4.110
ip route replace 192.223.3.0/25 via 192.223.4.110
ip route replace 192.223.4.0/27 via 192.223.4.110
ip route replace 192.223.4.32/28 via 192.223.4.110
ip route replace 192.223.4.152/29 via 192.223.4.110
ip route replace 192.223.4.160/30 via 192.223.4.110

# Cabang Hikari (via 192.223.4.114)
ip route replace 192.223.2.0/24 via 192.223.4.114
ip route replace 192.223.3.224/27 via 192.223.4.114
ip route replace 192.223.4.164/30 via 192.223.4.114

# Cabang Asuka (via 192.223.4.118)
ip route replace 192.223.3.128/26 via 192.223.4.118
ip route replace 192.223.4.48/29 via 192.223.4.118
ip route replace 192.223.4.96/30 via 192.223.4.118
ip route replace 192.223.4.136/29 via 192.223.4.118

# Cabang Kaji (via 192.223.4.122)
ip route replace 192.223.4.100/30 via 192.223.4.122

# Cabang Misato (via 192.223.4.126)
ip route replace 192.223.4.64/29 via 192.223.4.126

# Cabang Shigeru (via 192.223.4.130) - Switch-Monolith & Switch-Radar diringkas jadi /28
ip route replace 192.223.4.80/28 via 192.223.4.130
ip route replace 192.223.4.168/30 via 192.223.4.130

# Cabang Fuyutsuki (via 192.223.4.134)
ip route replace 192.223.3.192/27 via 192.223.4.134
ip route replace 192.223.4.56/29 via 192.223.4.134
ip route replace 192.223.4.72/29 via 192.223.4.134
ip route replace 192.223.4.144/29 via 192.223.4.134

# Deteksi interface NAT1 (default eth0)
NAT_IF=$(ip route show default | awk '{print $5; exit}')
[ -z "$NAT_IF" ] && NAT_IF="eth0"

# === SOAL 4: NAT MASQUERADE ===
iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING -s 192.223.0.0/16 -o "$NAT_IF" -j MASQUERADE

# === SOAL 5: Firewall Gendou (Policy INPUT & FORWARD = DROP) ===
iptables -F
iptables -X
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# INPUT: Loopback, ESTABLISHED/RELATED, DHCP dari NAT1, dan internal -> Gendou
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i "$NAT_IF" -p udp --sport 67 --dport 68 -j ACCEPT
iptables -A INPUT ! -i "$NAT_IF" -s 192.223.0.0/16 -j ACCEPT

# FORWARD: (a) ESTABLISHED/RELATED, (b) Internal -> Internet, (c) Antar-LAN
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD ! -i "$NAT_IF" -o "$NAT_IF" -s 192.223.0.0/16 -j ACCEPT
iptables -A FORWARD ! -i "$NAT_IF" ! -o "$NAT_IF" -s 192.223.0.0/16 -d 192.223.0.0/16 -j ACCEPT

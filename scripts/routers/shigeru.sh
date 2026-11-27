#!/bin/bash
# Konfigurasi Router Shigeru
# Soal 18: Filter FORWARD eth0 untuk Zona Sensitif (Switch-Monolith & Switch-Radar)
# Soal 19: Isolasi Layer 3 Armisael (192.223.4.83)

# 1. DNS, IP Forwarding & Rute Statis Idempoten
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sysctl -w net.ipv4.ip_forward=1 >/dev/null
ip route replace default via 192.223.4.129
ip route replace 192.223.4.88/29 via 192.223.4.170

# 2. Bersihkan aturan firewall lama
iptables -F
iptables -X
iptables -t nat -F 2>/dev/null || true
iptables -t nat -X 2>/dev/null || true

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# 3. Soal 19: Isolasi Layer 3 Armisael (192.223.4.83)
# Blokir seluruh akses masuk ke router maupun diteruskan dari/ke Armisael
iptables -A INPUT -s 192.223.4.83 -j DROP
iptables -A FORWARD -s 192.223.4.83 -j DROP
iptables -A FORWARD -d 192.223.4.83 -j DROP

# 4. Soal 18: Pengamanan Gerbang Zona Sensitif (FORWARD eth0)
# - Izinkan paket balasan dari koneksi yang dimulai node di dalam zona sensitif
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
# - Pengecualian: izinkan ping (echo-request) dari Switch-Terminal (192.223.4.56/29) masuk lewat eth0
iptables -A FORWARD -i eth0 -s 192.223.4.56/29 -p icmp --icmp-type echo-request -j ACCEPT
# - Blokir seluruh koneksi baru lainnya yang datang dari arah Gendou (eth0)
iptables -A FORWARD -i eth0 -j DROP

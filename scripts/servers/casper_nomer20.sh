#!/bin/bash
# Script Pemulihan Idempoten Magi-Casper (Soal 20)
# Node: Magi-Casper (192.223.4.58)

# 1. Pulihkan rute default gateway ke Fuyutsuki (192.223.4.57) secara idempoten
ip route replace default via 192.223.4.57

# 2. Bersihkan aturan firewall lama
iptables -F
iptables -X
iptables -t nat -F 2>/dev/null || true
iptables -t nat -X 2>/dev/null || true

# 3. Hardening Soal 12: Kebijakan dasar blokir semua trafik masuk (INPUT DROP)
iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# 4. Izinkan loopback dan balasan koneksi keluar (internet/ping keluar)
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 5. Izinkan akses layanan TCP port 5000
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT

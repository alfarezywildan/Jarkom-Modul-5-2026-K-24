#!/bin/sh
# Konfigurasi Magi-Casper (192.223.4.58)
# Soal 11 & Soal 12 (Hardening Firewall INPUT DROP)

# 1. Pulihkan rute default gateway ke Fuyutsuki secara idempoten
ip route replace default via 192.223.4.57

# 2. Bersihkan aturan firewall lama
iptables -F
iptables -X
iptables -t nat -F 2>/dev/null || true
iptables -t nat -X 2>/dev/null || true

# 3. Kebijakan default ketat: blokir seluruh trafik masuk (INPUT DROP)
iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# 4. Izinkan antarmuka loopback dan balasan koneksi keluar (ESTABLISHED,RELATED)
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 5. Izinkan akses layanan TCP port 5000
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT

# 6. Pastikan background listener nc port 5000 tetap aktif
pkill -f "nc.*5000" 2>/dev/null || true
(while true; do nc -l -p 5000 >> /tmp/casper_5000.log 2>&1; done) &

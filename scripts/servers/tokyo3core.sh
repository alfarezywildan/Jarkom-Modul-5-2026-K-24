#!/bin/bash
# Konfigurasi Tokyo3-Core (192.223.4.106)
# Soal 15 (Mitigasi ICMP Flood Limit 5/s) & Soal 16 (LOG & REJECT Port Scan Dummy-Plug)

# 1. Pulihkan rute default gateway ke Ritsuko secara idempoten
ip route replace default via 192.223.4.105

# 2. Bersihkan aturan firewall lama
iptables -F
iptables -X
iptables -t nat -F 2>/dev/null || true
iptables -t nat -X 2>/dev/null || true

# 3. Policy default tetap ACCEPT
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# 4. Izinkan antarmuka loopback
iptables -A INPUT -i lo -j ACCEPT

# 5. Soal 15: Pembatasan Ping (Rate Limiting ICMP Echo-Request)
# PENTING: Aturan limit dan drop HARUS ditaruh SEBELUM ESTABLISHED,RELATED
# agar conntrack tidak membypass filter untuk paket ke-2 dst.
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/sec --limit-burst 5 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# 6. Soal 16: Deteksi Pemindaian Port Sensitif (22, 23, 3306) dari Dummy-Plug (192.223.4.51)
iptables -A INPUT -s 192.223.4.51 -p tcp -m multiport --dports 22,23,3306 -j LOG --log-prefix "SCAN-NERV: "
iptables -A INPUT -s 192.223.4.51 -p tcp -m multiport --dports 22,23,3306 -j REJECT --reject-with tcp-reset

# 7. Izinkan koneksi ESTABLISHED,RELATED
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 8. Pastikan layanan web port 80 dan port 8080 aktif
pkill -f "nc.*80" 2>/dev/null || true
pkill -f "nc.*8080" 2>/dev/null || true
(while true; do printf "Welcome to Tokyo3-Core\n" | nc -l -p 80 -q 0; done) &
(while true; do printf "syifa imutz\n" | nc -l -p 8080 -q 0; done) &

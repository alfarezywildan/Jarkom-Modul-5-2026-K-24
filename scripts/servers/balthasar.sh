#!/bin/bash
# Konfigurasi Magi-Balthasar (192.223.4.59)
# Soal 13 (Brankas Balthasar - Whitelist Pilots & Casper, TCP Reset REJECT)

# 1. Bersihkan aturan firewall lama
iptables -F
iptables -X
iptables -t nat -F 2>/dev/null || true
iptables -t nat -X 2>/dev/null || true

# 2. Policy default tetap ACCEPT agar lalu lintas non-5000/5001 tidak terganggu
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# 3. Izinkan loopback dan balasan koneksi keluar (termasuk ping 8.8.8.8)
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 4. Izinkan Magi-Casper dan semua Pilot (Unit-01, Unit-02, Unit-00, Sachiel) ke TCP 5000 & 5001
ALLOWED_IPS="192.223.4.58 192.223.4.66 192.223.4.67 192.223.4.68 192.223.3.130"
for ip in $ALLOWED_IPS; do
    iptables -A INPUT -p tcp -s "$ip" -m multiport --dports 5000,5001 -j ACCEPT
done

# 5. Tolak seketika (TCP Reset) koneksi dari IP lain ke port 5000 dan 5001 agar tidak timeout
iptables -A INPUT -p tcp -m multiport --dports 5000,5001 -j REJECT --reject-with tcp-reset

# 6. Pastikan listener nc port 5000 dan 5001 aktif
pkill -f "nc.*5000" 2>/dev/null || true
pkill -f "nc.*5001" 2>/dev/null || true
(while true; do nc -l -p 5000 >> /tmp/balthasar_5000.log 2>&1; done) &
(while true; do nc -l -p 5001 >> /tmp/balthasar_5001.log 2>&1; done) &

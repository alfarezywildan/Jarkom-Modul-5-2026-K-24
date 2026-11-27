#!/bin/sh
# Konfigurasi Router Fuyutsuki
# Soal 17: Destination NAT (DNAT) dari Casper (192.223.4.58) yang menuju Zeruel (192.223.4.82)
# dialihkan ke Pen-Pen (192.223.3.195)

# 1. DNS dan IP Forwarding
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sysctl -w net.ipv4.ip_forward=1 >/dev/null

# 2. Rute Statis Idempoten
ip route replace default via 192.223.4.133
ip route replace 192.223.3.192/27 via 192.223.4.146
ip route replace 192.223.4.72/29 via 192.223.4.150

# 3. Bersihkan tabel NAT lama
iptables -t nat -F
iptables -t nat -X

# 4. Aturan DNAT Soal 17
# Seluruh koneksi TCP dari Magi-Casper ke alamat IP Zeruel dialihkan ke Pen-Pen
iptables -t nat -A PREROUTING -s 192.223.4.58 -d 192.223.4.82 -p tcp -j DNAT --to-destination 192.223.3.195

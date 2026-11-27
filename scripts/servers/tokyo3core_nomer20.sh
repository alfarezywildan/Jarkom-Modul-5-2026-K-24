#!/bin/bash
# Script Pemulihan Idempoten Tokyo3-Core (Soal 20)
# Node: Tokyo3-Core (192.223.4.106)

# 1. Pulihkan rute default gateway ke Ritsuko (192.223.4.105) secara idempoten
ip route replace default via 192.223.4.105

# 2. Bersihkan aturan firewall lama
iptables -F
iptables -X
iptables -t nat -F 2>/dev/null || true
iptables -t nat -X 2>/dev/null || true

# 3. Policy default
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# 4. Izinkan antarmuka loopback
iptables -A INPUT -i lo -j ACCEPT

# 5. Soal 15: Pembatasan Ping (Rate Limiting ICMP Echo-Request)
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/sec --limit-burst 5 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# 6. Soal 16: Deteksi Pemindaian Port Sensitif (22, 23, 3306) dari Dummy-Plug (192.223.4.51)
iptables -A INPUT -s 192.223.4.51 -p tcp -m multiport --dports 22,23,3306 -j LOG --log-prefix "SCAN-NERV: "
iptables -A INPUT -s 192.223.4.51 -p tcp -m multiport --dports 22,23,3306 -j REJECT --reject-with tcp-reset

# 7. Izinkan koneksi ESTABLISHED,RELATED
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

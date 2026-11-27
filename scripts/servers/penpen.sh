#!/bin/bash
# Konfigurasi Pen-Pen (192.223.3.195)
# Soal 14 (Jadwal Kunjungan Berbasis Waktu UTC)

# 1. Bersihkan aturan firewall lama
iptables -F
iptables -X
iptables -t nat -F 2>/dev/null || true
iptables -t nat -X 2>/dev/null || true

# 2. Kebijakan default
iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# 3. Izinkan antarmuka loopback dan koneksi ESTABLISHED,RELATED
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 4. Blokir langsung Dummy Systems tanpa mempedulikan waktu
DUMMY_IPS="192.223.4.51 192.223.4.50 192.223.4.102"
for ip in $DUMMY_IPS; do
    iptables -A INPUT -s "$ip" -j DROP
done

# 5. Aturan akses Pilots: Senin-Jumat pukul 01:00 - 09:00 UTC (08:00 - 16:00 WIB)
PILOT_IPS="192.223.4.66 192.223.4.67 192.223.4.68 192.223.3.130"
for ip in $PILOT_IPS; do
    iptables -A INPUT -s "$ip" -p icmp --icmp-type echo-request -m time --timestart 01:00 --timestop 09:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
    iptables -A INPUT -s "$ip" -p tcp --dport 80 -m time --timestart 01:00 --timestop 09:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
    iptables -A INPUT -s "$ip" -j DROP
done

# 6. Aturan akses Staf Geofront (Lilith): Setiap hari pukul 10:00 - 16:00 UTC (17:00 - 23:00 WIB)
STAFF_IPS="192.223.4.74"
for ip in $STAFF_IPS; do
    iptables -A INPUT -s "$ip" -p icmp --icmp-type echo-request -m time --timestart 10:00 --timestop 16:00 -j ACCEPT
    iptables -A INPUT -s "$ip" -p tcp --dport 80 -m time --timestart 10:00 --timestop 16:00 -j ACCEPT
    iptables -A INPUT -s "$ip" -j DROP
done

# 7. Lalu lintas masuk lainnya diizinkan (ACCEPT)
iptables -A INPUT -j ACCEPT

# 8. Pastikan web server service port 80 dan listener port 9000 (untuk Soal 17 DNAT) aktif
pkill -f "nc.*80" 2>/dev/null || true
pkill -f "nc.*9000" 2>/dev/null || true
(while true; do printf "Welcome to Pen-Pen\n" | nc -l -p 80 -q 0; done) &
(while true; do nc -l -p 9000 >> /tmp/penpen_dnat.log 2>&1; done) &

#!/bin/bash
# Script Uji Kebakaran Idempoten (Soal 20)
# Digunakan untuk pengujian di Shigeru, Magi-Casper, dan Tokyo3-Core

HOST=$(hostname)
case "$HOST" in
  Shigeru)      SCRIPT="/root/shigeru.sh"; RULES="/root/shigeru.rules" ;;
  Magi-Casper)  SCRIPT="/root/casper_nomer20.sh"; RULES="/root/casper.rules" ;;
  Tokyo3-Core)  SCRIPT="/root/tokyo3core_nomer20.sh"; RULES="/root/tokyo3.rules" ;;
  *) echo "Hostname $HOST tidak dikenali"; exit 1 ;;
esac

echo "=== [1] SIMPAN KONFIGURASI AKTIF ($HOST) ==="
iptables-save > "$RULES"
echo "Tersimpan di $RULES"

echo -e "\n=== [2] SIMULASI KEBAKARAN (HAPUS ATURAN & RUTE) ==="
iptables -F && iptables -X
iptables -t nat -F 2>/dev/null && iptables -t nat -X 2>/dev/null
iptables -P INPUT ACCEPT && iptables -P FORWARD ACCEPT && iptables -P OUTPUT ACCEPT
ip route del default 2>/dev/null
ip route del 192.223.4.88/29 2>/dev/null
echo "Aturan iptables setelah dihapus: $(iptables -S | wc -l) baris"
ip route

echo -e "\n=== [3] PEMULIHAN PERTAMA ==="
iptables-restore < "$RULES"
bash "$SCRIPT"
echo "Filter lines (1): $(iptables -S | wc -l)"
echo "NAT lines    (1): $(iptables -t nat -S 2>/dev/null | wc -l)"
ip route

echo -e "\n=== [4] PEMULIHAN KEDUA (UJI IDEMPOTENSI) ==="
iptables-restore < "$RULES"
bash "$SCRIPT"
echo "Filter lines (2): $(iptables -S | wc -l)"
echo "NAT lines    (2): $(iptables -t nat -S 2>/dev/null | wc -l)"
ip route

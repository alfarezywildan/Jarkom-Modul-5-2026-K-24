#!/bin/sh
# Perintah konfigurasi IP permanen (/etc/network/interfaces) untuk 25 Host (Soal 6)
# Copy-paste blok sesuai nama host di konsol masing-masing:

# --- Quarters (192.223.0.2/23, GW 192.223.0.1) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.0.2\n    netmask 255.255.254.0\n    gateway 192.223.0.1\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.0.2/23 dev eth0 && ip route replace default via 192.223.0.1 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Comm-Net (192.223.2.2/24, GW 192.223.2.1) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.2.2\n    netmask 255.255.255.0\n    gateway 192.223.2.1\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.2.2/24 dev eth0 && ip route replace default via 192.223.2.1 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Hangar-Crew (192.223.3.2/25, GW 192.223.3.1) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.3.2\n    netmask 255.255.255.128\n    gateway 192.223.3.1\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.3.2/25 dev eth0 && ip route replace default via 192.223.3.1 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Sachiel (192.223.3.130/26, GW 192.223.3.129) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.3.130\n    netmask 255.255.255.192\n    gateway 192.223.3.129\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.3.130/26 dev eth0 && ip route replace default via 192.223.3.129 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Medic-Bay (192.223.3.194/27, GW 192.223.3.193) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.3.194\n    netmask 255.255.255.224\n    gateway 192.223.3.193\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.3.194/27 dev eth0 && ip route replace default via 192.223.3.193 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Pen-Pen (192.223.3.195/27, GW 192.223.3.193) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.3.195\n    netmask 255.255.255.224\n    gateway 192.223.3.193\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.3.195/27 dev eth0 && ip route replace default via 192.223.3.193 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Relay-Node (192.223.3.226/27, GW 192.223.3.225) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.3.226\n    netmask 255.255.255.224\n    gateway 192.223.3.225\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.3.226/27 dev eth0 && ip route replace default via 192.223.3.225 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Garden-Staff (192.223.4.2/27, GW 192.223.4.1) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.2\n    netmask 255.255.255.224\n    gateway 192.223.4.1\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.2/27 dev eth0 && ip route replace default via 192.223.4.1 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Dock-Crew (192.223.4.34/28, GW 192.223.4.33) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.34\n    netmask 255.255.255.240\n    gateway 192.223.4.33\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.34/28 dev eth0 && ip route replace default via 192.223.4.33 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Entry-Plug (192.223.4.50/29, GW 192.223.4.49) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.50\n    netmask 255.255.255.248\n    gateway 192.223.4.49\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.50/29 dev eth0 && ip route replace default via 192.223.4.49 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Dummy-Plug (192.223.4.51/29, GW 192.223.4.49) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.51\n    netmask 255.255.255.248\n    gateway 192.223.4.49\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.51/29 dev eth0 && ip route replace default via 192.223.4.49 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Magi-Casper (192.223.4.58/29, GW 192.223.4.57) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.58\n    netmask 255.255.255.248\n    gateway 192.223.4.57\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.58/29 dev eth0 && ip route replace default via 192.223.4.57 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Magi-Balthasar (192.223.4.59/29, GW 192.223.4.57) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.59\n    netmask 255.255.255.248\n    gateway 192.223.4.57\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.59/29 dev eth0 && ip route replace default via 192.223.4.57 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Magi-Melchior (192.223.4.60/29, GW 192.223.4.57) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.60\n    netmask 255.255.255.248\n    gateway 192.223.4.57\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.60/29 dev eth0 && ip route replace default via 192.223.4.57 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Unit-01 (192.223.4.66/29, GW 192.223.4.65) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.66\n    netmask 255.255.255.248\n    gateway 192.223.4.65\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.66/29 dev eth0 && ip route replace default via 192.223.4.65 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Unit-02 (192.223.4.67/29, GW 192.223.4.65) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.67\n    netmask 255.255.255.248\n    gateway 192.223.4.65\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.67/29 dev eth0 && ip route replace default via 192.223.4.65 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Unit-00 (192.223.4.68/29, GW 192.223.4.65) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.68\n    netmask 255.255.255.248\n    gateway 192.223.4.65\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.68/29 dev eth0 && ip route replace default via 192.223.4.65 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Lilith (192.223.4.74/29, GW 192.223.4.73) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.74\n    netmask 255.255.255.248\n    gateway 192.223.4.73\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.74/29 dev eth0 && ip route replace default via 192.223.4.73 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Adam (192.223.4.75/29, GW 192.223.4.73) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.75\n    netmask 255.255.255.248\n    gateway 192.223.4.73\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.75/29 dev eth0 && ip route replace default via 192.223.4.73 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Zeruel (192.223.4.82/29, GW 192.223.4.81) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.82\n    netmask 255.255.255.248\n    gateway 192.223.4.81\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.82/29 dev eth0 && ip route replace default via 192.223.4.81 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Armisael (192.223.4.83/29, GW 192.223.4.81) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.83\n    netmask 255.255.255.248\n    gateway 192.223.4.81\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.83/29 dev eth0 && ip route replace default via 192.223.4.81 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Radar-Array (192.223.4.90/29, GW 192.223.4.89) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.90\n    netmask 255.255.255.248\n    gateway 192.223.4.89\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.90/29 dev eth0 && ip route replace default via 192.223.4.89 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Archive-Vault (192.223.4.98/30, GW 192.223.4.97) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.98\n    netmask 255.255.255.252\n    gateway 192.223.4.97\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.98/30 dev eth0 && ip route replace default via 192.223.4.97 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Spy (192.223.4.102/30, GW 192.223.4.101) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.102\n    netmask 255.255.255.252\n    gateway 192.223.4.101\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.102/30 dev eth0 && ip route replace default via 192.223.4.101 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

# --- Tokyo3-Core (192.223.4.106/30, GW 192.223.4.105) ---
printf 'auto eth0\niface eth0 inet static\n    address 192.223.4.106\n    netmask 255.255.255.252\n    gateway 192.223.4.105\n    up echo nameserver 8.8.8.8 > /etc/resolv.conf\n' > /etc/network/interfaces && ip link set eth0 up && ip addr replace 192.223.4.106/30 dev eth0 && ip route replace default via 192.223.4.105 && echo "nameserver 8.8.8.8" > /etc/resolv.conf

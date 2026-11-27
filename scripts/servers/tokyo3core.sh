#!/bin/sh
apt-get update && apt-get install -y iptables netcat-traditional
pkill -f "nc.traditional -l -p 80" 2>/dev/null || true
pkill -f "nc.traditional -l -p 8080" 2>/dev/null || true
(while true; do printf "Welcome to Tokyo3-Core\n" | nc.traditional -l -p 80 -q 0; done) &
(while true; do printf "syifa imutz\n" | nc.traditional -l -p 8080 -q 0; done) &

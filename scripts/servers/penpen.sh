#!/bin/sh
apt-get update && apt-get install -y iptables netcat-traditional
pkill -f "nc.traditional -l -p 80" 2>/dev/null || true
(while true; do printf "Welcome to Pen-Pen\n" | nc.traditional -l -p 80 -q 0; done) &

#!/bin/sh
apt-get update && apt-get install -y iptables netcat-traditional
pkill -f "nc.traditional -l -p 5000" 2>/dev/null || true
pkill -f "nc.traditional -l -p 5001" 2>/dev/null || true
(while true; do nc.traditional -l -p 5000 >> /tmp/balthasar_5000.log; done) &
(while true; do nc.traditional -l -p 5001 >> /tmp/balthasar_5001.log; done) &

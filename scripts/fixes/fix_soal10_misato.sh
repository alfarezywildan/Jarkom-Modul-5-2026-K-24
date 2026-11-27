#!/bin/sh
# Perbaikan sabotase SNAT break_nat.sh di Misato
iptables -t nat -F POSTROUTING

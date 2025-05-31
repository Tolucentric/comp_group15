#!/bin/bash

echo "=== System Information ==="

# OS distribution and version
echo -e "\n[1] OS Distribution and Version:"
grep -E 'PRETTY_NAME=|VERSION=' /etc/os-release | sed 's/PRETTY_NAME=//;s/VERSION=//'

# Kernel version and architecture
echo -e "\n[2] Kernel Version and Architecture:"
uname -rms
echo -n "Uptime: " 
uptime -p

# Hostname and uptime
echo -e "\n[3] Hostname and Uptime:"
hostname
uptime -p

# CPU information (model, cores, speed)
echo -e "\n[4] CPU Information:"
lscpu | grep -E 'Model name|Socket|Core|MHz' | sed 's/^[ \t]*//'

# Memory usage (total, used, free, cached)
echo -e "\n[5] Memory Usage:"
free -h

# Swap usage statistics
echo -e "\n[6] Swap Usage:"
swapon --show || echo "No swap configured"

# Disk utilization
echo -e "\n[7] Disk Utilization:"
df -hT --exclude-type=tmpfs --exclude-type=devtmpfs

# Load averages
echo -e "\n[8] Load Averages:"
cut -d ' ' -f 1-3 /proc/loadavg

# System temperature reading
echo -e "\n[9] System Temperature Readings:"
if command -v sensors &>/dev/null; then
    sensors | grep -E 'Core|Package'
else
    echo "Temperature data not available."
    echo "Tip: Install lm-sensors using 'sudo apt install lm-sensors' and run 'sudo sensors-detect'"
fi

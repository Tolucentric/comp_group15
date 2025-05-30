#!/bin/bash
echo"=System information"
# OS distribution and version
echo -e "\nOS Distribution and Version:"
cat /etc/os-release | grep -E 'NAME= | VERSION='
# Kernel version and architecture
echo -e "\nKernel Version and Architecture:"
uname -r && uptime -p
# Hostname and uptime
echo -e "\nHostname and Uptime:"
hostname && uptime -p
# CPU information (model, cores, speed)
echo -e "\nCPU Information:"
lscpu | grep -E 'Model name|Socket|Core|Mhz'
# Memory usage (total, used ,free, cached)
echo -e "\nMemory Usage:"
free -h
# Swap usage statistics
echo -e "\nSwap Usage:"
swapon --show
# Disk utilization (partition-by-partition breakdown)
echo -e "\nDisk Utilization:"
df -hT | grep -v tmpfs
# Load averages (1, 5, and 15-minute)
echo -e "\nLoad Averages:"
cat /proc/loadavg
# System temperature reading (if available)
echo -e "\nSystem Temperature Readings:"
if command -v sensors &> /dev/null; then 
echo "Temperature data not available."
echo "Tip: Install it using 'sudo apt install 1m-sensors' and run 'sudo sensors-detect'"
fi 

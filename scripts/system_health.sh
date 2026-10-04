#!/bin/bash

LOG_FILE="logs/system_health.log"

echo "======================================" | tee "$LOG_FILE"
echo "IT SYSTEM HEALTH DIAGNOSTIC REPORT" | tee -a "$LOG_FILE"
echo "======================================" | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "Hostname:" | tee -a "$LOG_FILE"
hostname | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "Current User:" | tee -a "$LOG_FILE"
whoami | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "Current Date:" | tee -a "$LOG_FILE"
date | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "System Uptime:" | tee -a "$LOG_FILE"
uptime | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "CPU Cores:" | tee -a "$LOG_FILE"
nproc | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "LOAD AVERAGE" | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

uptime | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "MEMORY USAGE" | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

free -h | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "DISK USAGE" | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

df -h | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "TOP CPU PROCESSES" | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

ps -eo pid,comm,%cpu,%mem \
    --sort=-%cpu \
    | head -n 6 \
    | tee -a "$LOG_FILE"

echo | tee -a "$LOG_FILE"

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "TOP MEMORY PROCESSES" | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

ps -eo pid,comm,%cpu,%mem \
    --sort=-%mem \
    | head -n 6 \
    | tee -a "$LOG_FILE"

echo | tee -a "$LOG_FILE"

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "FAILED SERVICES" | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

if command -v systemctl >/dev/null 2>&1; then
    systemctl --failed --no-pager \
        | tee -a "$LOG_FILE"
else
    echo "systemctl is not available." \
        | tee -a "$LOG_FILE"
fi

echo | tee -a "$LOG_FILE"

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "HEALTH WARNINGS" | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

memory_usage=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

disk_usage=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

if [ "$memory_usage" -ge 80 ]; then
    echo "WARNING: Memory usage is ${memory_usage}%." \
        | tee -a "$LOG_FILE"
else
    echo "OK: Memory usage is ${memory_usage}%." \
        | tee -a "$LOG_FILE"
fi

if [ "$disk_usage" -ge 80 ]; then
    echo "WARNING: Root disk usage is ${disk_usage}%." \
        | tee -a "$LOG_FILE"
else
    echo "OK: Root disk usage is ${disk_usage}%." \
        | tee -a "$LOG_FILE"
fi

echo | tee -a "$LOG_FILE"

echo "Diagnostic check completed." \
    | tee -a "$LOG_FILE"

echo "Report saved to: $LOG_FILE" \
    | tee -a "$LOG_FILE"
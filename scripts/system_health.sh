#!/bin/bash

echo "======================================"
echo "IT SYSTEM HEALTH CHECK"
echo "======================================"
echo

echo "Hostname:"
hostname
echo

echo "Current User:"
whoami
echo

echo "Current Date:"
date
echo

echo "System Uptime:"
uptime
echo

echo "Memory Usage:"
free -h
echo

echo "Disk Usage:"
df -h
echo

echo "System health check completed."
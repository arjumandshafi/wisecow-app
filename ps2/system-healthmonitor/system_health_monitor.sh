#!/bin/bash

# Log file path (absolute)
LOG_FILE="/home/ubuntu/system-health-monitor/system_health.log"

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
PROC_THRESHOLD=300

# Gather system stats
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
PROC_COUNT=$(ps -e --no-headers | wc -l)

# Write to log with alerts
{
  if (( ${CPU_USAGE%.*} > CPU_THRESHOLD )); then
    echo "$(date) - [ALERT] CPU usage high: $CPU_USAGE%"
  else
    echo "$(date) - CPU usage normal: $CPU_USAGE%"
  fi

  if (( ${MEM_USAGE%.*} > MEM_THRESHOLD )); then
    echo "$(date) - [ALERT] Memory usage high: $MEM_USAGE%"
  else
    echo "$(date) - Memory usage normal: $MEM_USAGE%"
  fi

  if (( DISK_USAGE > DISK_THRESHOLD )); then
    echo "$(date) - [ALERT] Disk usage high: $DISK_USAGE%"
  else
    echo "$(date) - Disk usage normal: $DISK_USAGE%"
  fi

  if (( PROC_COUNT > PROC_THRESHOLD )); then
    echo "$(date) - [ALERT] Process count high: $PROC_COUNT"
  else
    echo "$(date) - Process count normal: $PROC_COUNT"
  fi
} >> "$LOG_FILE"

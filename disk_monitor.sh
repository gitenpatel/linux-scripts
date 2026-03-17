#!/bin/bash
# disk_monitor.sh
# Purpose: Analyse system disk space and warn if any disk is above 80% full
# Usage ./disk_monitor.sh

# Exit immediately if any command fails, if any variable is undefined or if any command in a pipe fails
set -euo pipefail

OUTPUT="disk_space_report.txt"
THRESHOLD=80 # Warn if any disk is above this percentage

# Add title and timestamp
echo "Disk Space Monitor Report - $(date)" > "$OUTPUT"
echo "===============================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Show all disk usage
echo "Current disk usage:" >> "$OUTPUT"
df -h >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Check each mounted filesystem for above average threshold
# df -h gives human readable output, but we need percentages as numbers
# So we use df without -h and parse the output

# Get the usage percentage for the main filesystem (/)
USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

# Check if usage is above threshold
if [ "$USAGE" -gt "$THRESHOLD" ];
then
  echo "WARNING: Root Filesystem (/) is ${USAGE}% full!" >> "$OUTPUT"
  echo "WARNING: Root Filesystem (/) is ${USAGE}% full!"
  exit 1
else
  echo "All disks are below ${THRESHOLD}% usage" >> "$OUTPUT"
  echo "Report saved to $OUTPUT"
  exit 0
fi

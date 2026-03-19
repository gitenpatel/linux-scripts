#!/bin/bash

# process_monitor.sh
# Purpose: Check if critical processes are running and alert if any are down
# Usage: ./process_monitor.sh

# Exit immediately if any command fails, if any variable is undefined or if any command in a pipe fails
set -euo pipefail

OUTPUT="process_monitor_report.txt"

# List of processes to check - add more as needed
PROCESSES=("bash", "systemd", "nginx")

# Add title and timestamp
echo "Process Monitor Report - $(date)" > "$OUTPUT"
echo "================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Flag to track if any process is down
ALERT=0

# Loop through each process in the list
for process in "${PROCESSES[@]}"; do
    # Check if the process is running using pgrep
    # -x means exact match (not partial)
    # The if checks the exit code: 0 = found, 1 = not found
    if pgrep -x "$process" > /dev/null; then
        echo "✓ $process is running" >> "$OUTPUT"
    else
        echo "✗ WARNING: $process is NOT running!" >> "$OUTPUT"
  	echo "WARNING: $process is  NOT running!"
	ALERT=1
    fi
done

echo "" >> "$OUTPUT"

# Report final status based on whether any alerts were found
if [ "$ALERT" -eq 1 ]; then
    echo "ALERT: One or more critical processes are down!" >> "$OUTPUT"
    echo "Report saved to $OUTPUT"
    exit 1
else
    echo "All monitored processes are running normally" >> "$OUTPUT"
    echo "Report saved to $OUTPUT"
    exit 0
fi


#!/bin/bash

# network_monitor.sh
# Purport: Check if hosts are reachable using ping and alert if any are down
# Usage: ./network_monitor.sh

# Exit immediately if any command fails, if any variable is undefined or if any command in a pipe fails
set -euo pipefail

OUTPUT="network_monitor_report.txt"

# List of hosts to check - add more as needed
HOSTS=("8.8.8.8" "1.1.1.1")

# Add title and timestamp
echo "Network Monitor Report - $(date)" > "$OUTPUT"
echo "================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Flag to track if any process is down
ALERT=0

# Loop through each host in the list
for host in "${HOSTS[@]}"; do
    # Check if any host is running using ping
    # -x means exact match (not partial)
    # The if checks the exit code: 0 = found, 1 = not found
    if ping -c 1 -W 2 "$host" > /dev/null; then
        echo "✓ $host is UP" >> "$OUTPUT"
else
	echo "✗ WARNING: $host is NOT reachable!" >> "$OUTPUT"
	echo "WARNING: $host looks to be down!"
	ALERT=1
    fi
done

echo "" >> "$OUTPUT"

# Report final status based on whether any alerts were found
if [ "$ALERT" -eq 1 ]; then
    echo "ALERT: One or more hosts is down!" >> "$OUTPUT"
    echo "Report saved to $OUTPUT"
    exit 1
else
    echo "All monitored hosts are running normally" >> "$OUTPUT"
    echo "Report saved to $OUTPUT"
    exit 0
fi

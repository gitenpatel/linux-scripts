#/bin/bash

# This script is for a log analyser. It will count errors and show recent ones.

LOGFILE="/var/log/syslog"
OUTPUT="log_report.txt"

# Add title and date timestamp for the log file
echo "Log Analysis Report - $(date)" > "$OUTPUT"

# Add underlying to split the script title from contents of the log
echo "================================" >> "$OUTPUT"

# Add a space between the underlining and the next line
echo "" >> "$OUTPUT"

# Add Total Error Count heading
echo "Total ERROR count:" >> "$OUTPUT"

# Add Error counts
grep -c "ERROR" "$LOGFILE" >> "$OUTPUT"

# Add a space between error count number and next line
echo "" >> "$OUTPUT"

# Get the last 10 errors reported in the log
echo "Last 10 errors:" >> "$OUTPUT"

# Print the last ten errors from the log file
grep "ERROR" "$LOGFILE" | tail -10 >> "$OUTPUT"

# Add comment to show report has been saved to the log file
echo "Report saved to $OUTPUT"



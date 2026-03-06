#/bin/bash
# log_analyser.sh
# Purpose: Analyse system logs for errors or warnings with proper error handling
# Usage: ./loganalyser.sh [optional-logfile-path]

# Exit immediately if any command fails, if any variable is undefined or if any command in a pipe fails
set -euo pipefail

# Set the logfile path - use first argument if provided, otherwise default to /var/sys/syslog
LOGFILE="${1:-/var/log/syslog}"
OUTPUT="log_report.txt"

# Check if the log file exists at the specified path
if [ ! -f "$LOGFILE" ];
then
  # Send error message to stderr (>&2) instead of stdout
  echo "Error: Log file not found: $LOGFILE" >&2
  # Exit with error code 1 to indicate failure
  exit 1
fi

# Check if we have permission to read the log file
if [ ! -r "$LOGFILE" ];
then 
  echo "Error: Cannot read $LOGFILE (permission denied)" >&2
  exit 1
fi

# Add title and date timestamp for the log file
echo "Log Analysis Report - $(date)" > "$OUTPUT"

# Add underlying to split the script title from contents of the log
echo "================================" >> "$OUTPUT"

# Show which file was analysed
echo "File analysed: $LOGFILE" >> "$OUTPUT"

# Add a space between the header and the counts
echo "" >> "$OUTPUT"

# Count total errors in log file - if grep does not find anything, default to 0 instead of failing
ERROR_COUNT=$(grep -c "ERROR" "$LOGFILE" || echo 0)

# Add Error count to the report
echo "Total ERROR count: $ERROR_COUNT" >> "$OUTPUT"

# Count total warnings in the log file - look for WARNING or WARN
WARN_COUNT=$(grep -c "WARNING\|WARN" "$LOGFILE" || echo 0)

# Add the warning count to the report
echo "Total WARNING count: $WARN_COUNT" >> "$OUTPUT"

# Add a space between counts and error details
echo "" >> "$OUTPUT"

# Only Show error details if errors were actually found
if [ "$ERROR_COUNT" -gt 0 ];
then
  # Add heading for error details
  echo "Last 10 errors:" >> "$OUTPUT"

  # Print the last ten errors from the log file
  grep "ERROR" "$LOGFILE" | tail -10 >> "$OUTPUT"
else
  # If no errors found, print to confirm this
  echo "No errors found" >> "$OUTPUT"
fi

# Confirm report has been saved
echo "Report saved to $OUTPUT"

# Exit with success code 0
exit 0

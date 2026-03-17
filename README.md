# Linux Shell Scripts

A collection of Bash scripts for system monitoring and log analysis, written as part of a structured Linux learning programme.

## Scripts

### log_analyser.sh
Parses system log files to identify and report errors and warnings.

**Usage:**
```bash
./log_analyser.sh [optional-logfile-path]
```

**Features:**
- Defaults to `/var/log/syslog` if no path is provided
- Validates file existence and read permissions before processing
- Counts total ERROR and WARNING/WARN occurrences
- Outputs the last 10 errors for quick triage
- Generates a timestamped report saved to `log_report.txt`
- Proper error handling with stderr output and exit codes

**Example output:**
```
Log Analysis Report - Mon Mar 17 09:00:00 UTC 2026
================================
File analysed: /var/log/syslog

Total ERROR count: 3
Total WARNING count: 12

Last 10 errors:
...
```

---

### disk_monitor.sh
Monitors disk space usage across mounted filesystems and alerts when usage exceeds a defined threshold.

**Usage:**
```bash
./disk_monitor.sh
```

**Features:**
- Checks all mounted filesystems
- Configurable usage threshold
- Alerts on filesystems exceeding the threshold
- Clean formatted output

---

## Requirements
- Bash 4.0+
- Standard Unix utilities: `grep`, `tail`, `df`
- Read access to target log files (may require `sudo` for system logs)

## Running the scripts
Clone the repo and make scripts executable:
```bash
git clone https://github.com/gitenpatel/linux-scripts.git
cd linux-scripts
chmod +x *.sh
```

## Background
These scripts were written as part of a deliberate upskilling programme alongside Python development, with a focus on production-quality scripting practices — error handling, exit codes, stderr vs stdout, and clear documentation.

#!/usr/bin/env bash

# log-info -- Log informational messages to stdout

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../utils/term-colors.sh"

timestamp=$(date '+%Y-%m-%d %H:%M:%S')

printf "%s[%s] %sINFO%s: %s\n" "$CYAN" "$timestamp" "$BOLD_CYAN" "$RESET" "$*"

if [[ -n "$LOG_FILE" ]]; then
    echo "[$timestamp] INFO: $*" >> "$LOG_FILE"
fi

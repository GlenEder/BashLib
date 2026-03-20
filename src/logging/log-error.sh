#!/usr/bin/env bash

# log-error -- Log error messages to stderr

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../utils/term-colors.sh"

timestamp=$(date '+%Y-%m-%d %H:%M:%S')

printf "%s[%s] %sERROR%s: %s\n" "$RED" "$timestamp" "$BOLD_RED" "$RESET" "$*" >&2

if [[ -n "$LOG_FILE" ]]; then
    echo "[$timestamp] ERROR: $*" >> "$LOG_FILE"
fi

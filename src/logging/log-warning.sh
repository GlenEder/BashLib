#!/usr/bin/env bash

# log-warning -- Log warning messages to stderr

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../utils/term-colors.sh"

timestamp=$(date '+%Y-%m-%d %H:%M:%S')

printf "%s[%s] %sWARN%s: %s\n" "$YELLOW" "$timestamp" "$BOLD_YELLOW" "$RESET" "$*" >&2

if [[ -n "$LOG_FILE" ]]; then
  echo "[$timestamp] WARN: $*" >>"$LOG_FILE"
fi

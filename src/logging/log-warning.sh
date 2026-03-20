#!/usr/bin/env bash

# log-warning -- Log warning messages to stderr

log_warning() {
	local show_timestamp=false

	while [[ "$#" -gt 0 ]]; do
		case $1 in
		-t | --timestamp)
			show_timestamp=true
			shift
			;;
		*)
			break
			;;
		esac
	done

	local message="$*"

	if [[ -z "$message" ]]; then
		return
	fi

	local SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	source "${SCRIPT_DIR}/../utils/term-colors.sh"

	if [[ -n "$LOG_FILE" ]]; then
		local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
		echo "[$timestamp] WARN: $message" >>"$LOG_FILE"
	fi

	if $show_timestamp; then
		local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
		printf "%s[%s] %sWARN%s: %s\n" "$YELLOW" "$timestamp" "$BOLD_YELLOW" "$RESET" "$message" >&2
	else
		printf "%sWARN%s: %s\n" "$BOLD_YELLOW" "$RESET" "$message" >&2
	fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	log_warning "$@"
fi

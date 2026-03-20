#!/usr/bin/env bash

# log-info -- Log informational messages to stdout

log_info() {
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
		echo "[$timestamp] INFO: $message" >>"$LOG_FILE"
	fi

	if $show_timestamp; then
		local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
		printf "%s[%s] %sINFO%s: %s\n" "$CYAN" "$timestamp" "$BOLD_CYAN" "$RESET" "$message"
	else
		printf "%sINFO%s: %s\n" "$BOLD_CYAN" "$RESET" "$message"
	fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	log_info "$@"
fi

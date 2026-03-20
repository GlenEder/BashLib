#!/usr/bin/env bash

# log-error -- Log error messages to stderr

log_error() {
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

	SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	source "${SCRIPT_DIR}/../utils/term-colors.sh"

	if [[ -n "$LOG_FILE" ]]; then
		local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
		echo "[$timestamp] ERROR: $message" >>"$LOG_FILE"
	fi

	if $show_timestamp; then
		local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
		printf "%s[%s] %sERROR%s: %s\n" "$RED" "$timestamp" "$BOLD_RED" "$RESET" "$message" >&2
	else
		printf "%sERROR%s: %s\n" "$BOLD_RED" "$RESET" "$message" >&2
	fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	log_error "$@"
fi

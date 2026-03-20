#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../logging/log-info.sh"
source "${SCRIPT_DIR}/../logging/log-error.sh"

# Help message displayed when -h or --help is passed
HELP_MESSAGE="Usage: gits [-f/--filenames-only] [-h/--help]

Options:
  -f, --filenames-only  (optional) Show only filenames, not status symbols
  -h, --help            Show this help message"

# Default to showing full status output
filename_only=false

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
	-f | --filenames-only)
		filename_only=true
		shift 1
		;;
	-h | --help)
		log_info "$HELP_MESSAGE"
		exit 0
		;;
	*)
		log_error "Unknown param provided: $1"
		log_info "$HELP_MESSAGE"
		exit 1
		;;
	esac
done

# Run git status with or without filename-only output
if $filename_only; then
	git status -s | cut -c 4-
else
	git status -s
fi

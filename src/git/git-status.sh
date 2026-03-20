#!/usr/bin/env bash

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
		echo "$HELP_MESSAGE"
		exit 0
		;;
	*)
		echo "Unknown param provided: $1"
		echo "$HELP_MESSAGE"
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

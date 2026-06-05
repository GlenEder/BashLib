#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../logging/log-info.sh"
source "${SCRIPT_DIR}/../logging/log-error.sh"

length=32

# Help message displayed when -h or --help is passed
HELP_MESSAGE="Usage: pw-gen [-l/--length] [-h/--help]

Options:
  -l, --length (optional) Set the length of the generated password,
              * default length is $length
  -h, --help            Show this help message"


# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
  -l | --length)
		length=$2
		shift 2
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

# generate pw using machines random noise
value=$(b64encode /dev/urandom pw | head -n2 | tail -n1 | tr -d '\n')
pass=$(echo "$value" | cut -c 1-"${length}")

echo "$pass"


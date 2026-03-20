#!/usr/bin/env bash

logFile=""

# Setups logger to define log output file
# $1 -- log file path (must be absolute)
#   If not provided, logs will stream to std out
function setup() {
  if [[ -z "$1" ]]; then
    exit 0
  fi

  # Check if log file exists
  if [[ -f "$1" ]]; then
    logFile=$1
  else
    # File doesn't exist, check if the directory path is valid
    local logDir
    logDir=$(dirname "$1")

    # if dir is writable, create the log file
    if [[ -d "$logDir" && -w "$logDir" ]]; then
      logFile=$1
      touch "$logFile"
    else
      echo "Error: Invalid log file path or directory not writable: $1" >&2
      exit 1
    fi
  fi
}

# Setup log file if presented
setup "$1"

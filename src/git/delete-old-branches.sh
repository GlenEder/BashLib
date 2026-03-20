#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../logging/log-info.sh"

# fetch
git fetch -pt

# grab branches marked as deleted in remote
branches=$(git branch -v | grep "\[gone\]" | awk '{print $1}')

# delete each of those locally
for branch in $branches; do
	log_info "Deleting stale local branch: $branch"
	git branch -D "$branch"
done

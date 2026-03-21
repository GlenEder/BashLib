#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../logging/log-info.sh"

set -e

# Fetch the latest remote state and prune stale tracking branches
git fetch -pt

# Check out the repo's "main" branch
branch_name=$(git symbolic-ref refs/remotes/origin/HEAD | xargs basename)
log_info "Checking out main branch: $branch_name"
git checkout "$branch_name"

# Pull the latest changes from the remote
log_info "Pulling latest changes from remote"
git pull

# Grab latest tages and update local ones
log_info "Fetching tags from remote"
git fetch --tags --force

# Delete old branches
log_info "Running delete-old-branches.sh"
${SCRIPT_DIR}/delete-old-branches.sh

#!/usr/bin/env bash

set -e

# Fetch the latest remote state and prune stale tracking branches
git fetch -pt

# Check out the repo's "main" branch
branch_name=$(git symbolic-ref refs/remotes/origin/HEAD | xargs basename)
git checkout "$branch_name"

# Pull the latest changes from the remote
git pull

# Grab latest tages and update local ones
git fetch --tags --force

# Delete old branches
./delete-old-branches.sh

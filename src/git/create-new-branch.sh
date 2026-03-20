#!/usr/bin/env bash

# Ensure a branch name was provided as an argument
if [ -z "$1" ]; then
	echo "Usage: new-branch.sh <branch-name>"
	exit 1
fi

branch_name="$1"

# Create and checkout the new branch
git checkout -b "$branch_name"

# Push the new branch to remote and set it as the upstream tracking branch
git push -u origin "$branch_name"

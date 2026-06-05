#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../logging/log-info.sh"

# Fetch the latest remote state and prune stale tracking branches
git fetch -pt

# Remove linked worktrees and delete each local branch whose remote has been removed
while IFS= read -r line || [[ -n "$line" ]]; do
	[[ "$line" != *"[gone]"* ]] && continue

	# Strip the *, +, or leading spaces prefix to get the real branch name
	branch=$(sed -E 's/^[*+ ]+//' <<< "$line" | awk '{print $1}')

	# Remove the linked worktree when the branch is checked out in another worktree
	if [[ "$line" == +* ]]; then
		worktree_path=$(git worktree list --porcelain | awk -v ref="refs/heads/$branch" '
			/^worktree / { wt=$2 }
			/^branch / && $2==ref { print wt; exit }
		')
		if [[ -n "$worktree_path" ]]; then
			log_info "Removing worktree for gone branch $branch: $worktree_path"
			git worktree remove --force "$worktree_path"
		fi
	fi

	log_info "Deleting stale local branch: $branch"
	git branch -D "$branch"
done < <(git branch -v)

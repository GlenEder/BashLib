#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../logging/log-info.sh"
source "${SCRIPT_DIR}/../logging/log-error.sh"

# Checkout the given branch if one was provided, then pull and exit
if [ -n "$1" ]; then
	git checkout "$1"
	git pull
	exit 0
fi

# Collect all local branches into an array (compatible with bash 3)
branches=()
while IFS= read -r branch; do
	branches+=("$branch")
done < <(git branch --format='%(refname:short)')

# Track whether we are currently showing remote branches
showing_remote=false

# Present branches ten at a time and prompt the user to pick one
page=0
page_size=10
total=${#branches[@]}
log_info "Found $total local branches"

while true; do
	# Calculate the slice of branches to display on this page
	start=$((page * page_size))
	end=$((start + page_size))
	if [ "$end" -gt "$total" ]; then
		end=$total
	fi

	# Print the numbered list for the current page
	echo ""
	for ((i = start; i < end; i++)); do
		echo "  $((i - start + 1))) ${branches[$i]}"
	done

	# Determine the extra option to show after the branch list
	extra_label=""
	if [ "$end" -lt "$total" ]; then
		# More pages of the current source remain
		extra_label="Show more branches"
	elif ! $showing_remote; then
		# All local branches shown — offer to load remote branches
		extra_label="Show remote branches"
	fi

	# Print the extra option if there is one
	extra_num=$((end - start + 1))
	if [ -n "$extra_label" ]; then
		echo "  ${extra_num}) ${extra_label}"
	fi

	# Prompt the user to enter a number
	echo ""
	read -rp "Enter a number to checkout a branch: " choice

	# Validate that the input is a positive integer
	if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ]; then
		log_error "Invalid selection. Please enter a number from the list."
		continue
	fi

	# Handle the extra option if it was selected
	if [ -n "$extra_label" ] && [ "$choice" -eq "$extra_num" ]; then
		if [ "$extra_label" = "Show more branches" ]; then
			# Advance to the next page of the current branch list
			page=$((page + 1))
			continue
		else
			# Fetch remote state and load all remote branches, stripping the remote prefix
			log_info "Fetching remote branches..."
			git fetch -p
			branches=()
			while IFS= read -r branch; do
				branches+=("$branch")
			done < <(git branch -r --format='%(refname:short)' | grep -v 'HEAD')

			showing_remote=true
			page=0
			total=${#branches[@]}
			continue
		fi
	fi

	# Validate the choice is within the displayed range
	if [ "$choice" -gt $((end - start)) ]; then
		log_error "Invalid selection. Please enter a number from the list."
		continue
	fi

	# Resolve the selected branch name, stripping the remote prefix if needed
	selected="${branches[$((start + choice - 1))]}"
	if $showing_remote; then
		selected="${selected#*/}"
	fi
	break
done

# Checkout the selected branch and pull the latest changes
git checkout "$selected"
git pull

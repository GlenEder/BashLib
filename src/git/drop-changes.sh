#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../logging/log-info.sh"
source "${SCRIPT_DIR}/../logging/log-warning.sh"
source "${SCRIPT_DIR}/../logging/log-error.sh"

original_args=("$@")
set --
(
	source "${SCRIPT_DIR}/git-status.sh"
) >/dev/null 2>&1
set -- "${original_args[@]}"

HELP_MESSAGE="Usage: git-drop-changes [-a/--all-files] [-d/--delete-untracked] [-h/--help]

Drop changes in the current repository by checking out the current path.

Options:
  -a, --all-files       Find all changed files via git status and check them out
  -d, --delete-untracked  Delete untracked files in current directory and below
  -h, --help            Show this help message"

all_files=false
delete_untracked=false

while [[ "$#" -gt 0 ]]; do
	case $1 in
	-a | --all-files)
		all_files=true
		shift 1
		;;
	-d | --delete-untracked)
		delete_untracked=true
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

if $all_files; then
	changed_files=$(git-status.sh -f)
	if [[ -z "$changed_files" ]]; then
		log_info "No changed files found"
		exit 0
	fi
	while IFS= read -r file; do
		git checkout -- "$file"
		log_info "Checked out: $file"
	done <<<"$changed_files"
fi

if $delete_untracked; then
	status_output=$(git-status.sh)
	untracked=$(echo "$status_output" | grep "^??" | cut -c 4-)
	if [[ -z "$untracked" ]]; then
		log_info "No untracked files to delete"
	else
		while IFS= read -r file; do
			if [[ -e "$file" ]]; then
				rm -rf "$file"
				log_info "Deleted: $file"
			fi
		done <<<"$untracked"
	fi
fi

if ! $all_files && ! $delete_untracked; then
	git checkout -- .
fi

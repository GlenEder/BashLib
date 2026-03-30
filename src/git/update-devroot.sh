#!/usr/bin/env bash

# update-devroot -- Update all git repos in the specified directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../logging/log-info.sh"
source "${SCRIPT_DIR}/../logging/log-error.sh"
source "${SCRIPT_DIR}/../logging/log-warning.sh"

HELP_MESSAGE="Usage: $(basename "$0") [-h/--help] [-f/--fetch-only] <directory>

Update all git repositories in the specified directory.

Options:
  -h, --help       Show this help message
  -f, --fetch-only Fetch latest changes only (skip checkout to main branch)"

fetch_only=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h | --help)
            log_info "$HELP_MESSAGE"
            exit 0
            ;;
        -f | --fetch-only)
            fetch_only=true
            shift
            ;;
        -*)
            log_error "Unknown option: $1"
            log_info "$HELP_MESSAGE"
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

if [[ $# -lt 1 ]]; then
    log_warning "Missing directory argument, checking for env DEVROOT"

    if [[ -n $DEVROOT ]]; then
      echo -e "Using $DEVROOT"
      target_dir="$DEVROOT"
    else
      log_error "DEVROOT missing/empty"
      log_info "$HELP_MESSAGE"
      exit 1
    fi
else
    target_dir="$1"
fi

if [[ ! -d "$target_dir" ]]; then
    log_error "Directory does not exist: $target_dir"
    exit 1
fi

mapfile -t repos < <(find "$target_dir" -maxdepth 2 -type d -name '.git' -exec dirname {} \; 2>/dev/null)

if [[ ${#repos[@]} -eq 0 ]]; then
    log_info "No git repositories found in $target_dir"
    exit 0
fi

log_info "Found ${#repos[@]} repository(ies) in $target_dir"

update_repo() {
    local repo="$1"
    local fetch_only="$2"
    local repo_name
    repo_name=$(basename "$repo")

    if $fetch_only; then
        if git -C "$repo" fetch -pt 2>/dev/null; then
            echo "SUCCESS:$repo_name"
            return 0
        else
            echo "FAILED:$repo_name"
            return 1
        fi
    else
        if (cd "$repo" && "${SCRIPT_DIR}/checkout-main.sh"); then
            echo "SUCCESS:$repo_name"
            return 0
        else
            echo "FAILED:$repo_name"
            return 1
        fi
    fi
}

updated_count=0
error_count=0
failed_repos=()

for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo")
    log_info -t "Updating $repo_name..."
    update_repo "$repo" "$fetch_only" &
    pids+=($!)
    pid_to_repo+=([$!]="$repo_name")
done

for pid in "${pids[@]}"; do
    if wait "$pid"; then
        ((updated_count++))
    else
        ((error_count++))
        failed_repos+=("${pid_to_repo[$pid]}")
    fi
done

if [[ $error_count -gt 0 ]]; then
    log_error "Failed repos: ${failed_repos[*]}"
fi

log_info "Update complete: $updated_count succeeded, $error_count failed"

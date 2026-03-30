#!/usr/bin/env bash

# update-devroot -- Update all git repos in the specified directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../logging/log-info.sh"
source "${SCRIPT_DIR}/../logging/log-error.sh"

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
    log_error "Missing directory argument, checking for env DEVROOT"

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

mapfile -t repos < <(find "$target_dir" -maxdepth 1 -type d -name '.git' -printf '%h\n' 2>/dev/null)

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
        else
            echo "FAILED:$repo_name"
        fi
    else
        if (cd "$repo" && "${SCRIPT_DIR}/checkout-main.sh"); then
            echo "SUCCESS:$repo_name"
        else
            echo "FAILED:$repo_name"
        fi
    fi
}

for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo")
    log_info -t "Updating $repo_name..."
    update_repo "$repo" "$fetch_only" &
done

updated_count=0
error_count=0

while IFS= read -r result; do
    case $result in
        SUCCESS:*)
            ((updated_count++))
            ;;
        FAILED:*)
            log_error "Failed to update ${result#FAILED:}"
            ((error_count++))
            ;;
    esac
done < <(wait)

log_info "Update complete: $updated_count succeeded, $error_count failed"

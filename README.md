# BashLib
A Collection of Reusable Bash Scripts

## Setup

Add the following to your `~/.zshrc` to load scripts as functions:
Update the function names to what ever you'd prefer 

```bash
# BashLib setup, adjust to where the repo lives 
SCRIPT_DIR=~/devroot/BashLib/src

# Git scripts
gits() { "$SCRIPT_DIR/git/git-status.sh" "$@"; }
dropChanges() { "$SCRIPT_DIR/git/drop-changes.sh" "$@"; }
main() { "$SCRIPT_DIR/git/checkout-main.sh" "$@"; }
createBranch() { "$SCRIPT_DIR/git/create-new-branch.sh" "$@"; }
deleteOldBranches() { "$SCRIPT_DIR/git/delete-old-branches.sh" "$@"; }
checkout() { "$SCRIPT_DIR/git/checkout-branch.sh" "$@"; }
```

After editing, run `source ~/.zshrc` to apply changes.



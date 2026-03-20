# BashLib

A collection of reusable Bash scripts.

## Bash Script Standards

### Shebang line
- Always use `#!/usr/bin/env bash` as the first line of every script
- Never use `#!/bin/bash` or any other hardcoded interpreter path

### Comments
- Every logical step or block of commands must have a comment explaining what it does
- Comments should appear immediately above the step they describe
- Single-command one-liners that are self-evident are exempt, but prefer to comment anyway when there is any ambiguity

### Example of a well-formed script

```bash
#!/usr/bin/env bash

# Fetch the latest remote state and prune stale tracking branches
git fetch -pt

# Find all local branches whose remote has been deleted
branches=$(git branch -v | grep "\[gone\]" | awk '{print $1}')

# Delete each stale branch locally
for branch in $branches; do
  git branch -D "$branch"
done
```

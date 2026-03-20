#!/usr/bin/env bash

# fetch
git fetch -pt

# grab branches marked as deleted in remote
branches=$(git branch -v | grep "\[gone\]" | awk '{print $1}')

# delete each of those locally
for branch in $branches; do
  git branch -D "$branch"
done

#!/bin/bash

# Color codes
GREEN='\033[0;32m'
RESET='\033[0m'

# Commit and push
git add . &&
git commit -m "dotfiles" &&
git push &&

# Get latest commit hash
latest_commit=$(git rev-parse HEAD)

# Get highest existing tag like 0.0.x
latest_tag=$(git tag -l '0.0.*' --sort=-v:refname | head -n1)

if [[ "$latest_tag" =~ ^0\.0\.([0-9]+)$ ]]; then
  patch=${BASH_REMATCH[1]}
  next_patch=$((patch + 1))
else
  next_patch=1
fi

next_tag="0.0.${next_patch}"

# Create and push the tag
git tag "$next_tag" "$latest_commit"
git push origin "$next_tag"

# Done message
echo
echo -e "${GREEN}Git push and tag ${next_tag} complete.${RESET}"
echo

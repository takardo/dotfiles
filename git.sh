#!/bin/bash

# Color
GREEN='\033[0;32m'
RESET='\033[0m'

# Commit and push
git add . &&
git commit -m "dotfiles" &&
git push &&

# Get latest commit hash
latest_commit=$(git rev-parse HEAD)

# Get highest existing vX.Y tag number
latest_tag=$(git tag -l 'v*' --sort=-v:refname | head -n1)

# Extract version and calculate next
if [[ "$latest_tag" =~ ^v([0-9]+)\.([0-9]+)$ ]]; then
  major=${BASH_REMATCH[1]}
  minor=${BASH_REMATCH[2]}
  next_minor=$((minor + 1))
  next_tag="v$major.$next_minor"
else
  next_tag="v0.1"
fi

# Create and push the tag
git tag "$next_tag" "$latest_commit"
git push origin "$next_tag"

# Done
echo
echo -e "${GREEN}Git push and tag ${next_tag} complete.${RESET}"
echo

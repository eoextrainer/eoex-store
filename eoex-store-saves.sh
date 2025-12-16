#!/bin/bash
# EOEX Store Git Workflow Automation Script
# Author: EOEX | Contributor: Sosthene Grosset-Janin | v1.0.0 | December 2025
# Usage: ./eoex-store-saves.sh "Commit message describing the change"

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 \"Commit message\""
  exit 1
fi

COMMIT_MSG="$1"
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Save all changes

git add .
git stash save "Auto-stash before commit: $COMMIT_MSG"
git stash pop || true

git add .
git commit -m "$COMMIT_MSG"
git pull origin $BRANCH --no-rebase --allow-unrelated-histories || true
git push origin $BRANCH

echo "[EOEX Store] Changes saved, committed, and pushed on branch: $BRANCH"

echo "[EOEX Store] If you want to create a pull/merge request, do so via the GitHub UI or CLI."

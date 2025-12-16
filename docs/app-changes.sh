#!/bin/bash
# EOEX App Store - app-changes.sh
# Workflow: Save, stash, stage, commit, push, PR/MR for all changes
# Usage: bash app-changes.sh

set -e

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

# 1. Show current branch and status
echo "Current branch: $(git branch --show-current)"
git status

echo "Fetching remote branches..."
git fetch --all

echo "Stashing any uncommitted changes..."
git stash save "Auto-stash before workflow run $(date)" || true

echo "Applying latest stash (if any)..."
git stash pop || true

echo "Staging all changes..."
git add .

echo "Committing changes..."
git commit -m "EOEX App Store: Save and push all latest changes [$(date)]" || echo "No changes to commit."

echo "Pushing to remote..."
git push

# 2. Create PR/MR if on feature branch
default_branch="main"
current_branch="$(git branch --show-current)"
if [[ "$current_branch" != "$default_branch" ]]; then
  echo "Creating pull/merge request from $current_branch to $default_branch..."
  if command -v gh &> /dev/null; then
    gh pr create --base "$default_branch" --head "$current_branch" --title "EOEX App Store: PR $current_branch" --body "Automated PR for latest changes." || true
  elif command -v glab &> /dev/null; then
    glab mr create --source "$current_branch" --target "$default_branch" --title "EOEX App Store: MR $current_branch" --description "Automated MR for latest changes." || true
  else
    echo "Install GitHub CLI (gh) or GitLab CLI (glab) for PR/MR automation."
  fi
else
  echo "On $default_branch, skipping PR/MR creation."
fi

echo "Workflow complete."

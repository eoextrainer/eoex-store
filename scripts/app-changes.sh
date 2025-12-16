#!/bin/bash
# Usage: ./app-changes.sh "commit message"
git add .
git commit -m "$1"
git push

#!/bin/bash
 # save-and-push.sh – Save and push all changes for EOEX Store app

git add .
git commit -m "chore: v1.1.0-beta unify splash/home, doc, config, archive"
git push --all

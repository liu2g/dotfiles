#!/bin/bash

DIRECTORY=`dirname $0`
cd $DIRECTORY
git stash # Stash your local changes
git pull # Update the branch to the latest code
git stash apply # Merge your local changes into the latest code

# Then commit and push changes
git add .
git commit -a -m "${1:-Update at $(date +%Y-%m-%dT%H:%M:%S%z)}"
git push
echo ""
echo "---Auto Update Complete---"
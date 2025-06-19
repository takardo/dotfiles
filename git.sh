#!/bin/bash

# Define color codes
GREEN='\033[0;32m'

git add . &&

git commit -m "dotfiles" &&

git push &&

echo &&

echo -e "${GREEN}Git Push Done.${NC}" &&

#echo "git push done" &&

echo

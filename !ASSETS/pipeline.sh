#!/bin/bash

echo "(0) Preparing pipeline";

REPO="https://github.com/Dhrrrrr/linux-config-arch-hyprland.git"
GIT_USER="Dhrrrrr"
GIT_PAT=$(cat ~/Documents/!GIT/key)
DIRECTORY="../"

echo ""
echo "(1) Adding files to repo"

cd $DIRECTORY
git add --all

if [ $? -ne 0 ]; then
  echo "--------------- Pipeline Failure -------------"
  echo "Error on (1) Adding files"
  echo ""
  exit
fi

echo ""
echo "(2) Committing files to repo"

read -r -p "Enter your commit message: " message

git commit -m "$message"

if [ $? -ne 0 ]; then
  echo "--------------- Pipeline Failure -------------"
  echo "Error on (2) Committing to repo"
  echo ""
  exit
fi

echo ""
echo "(3) Pushing to git"
git -c credential.helper='!f() { echo "username=${GIT_USER}"; echo "password=${GIT_PAT}"; }; f' push https://${REPO} main

if [ $? -ne 0 ]; then
  echo "--------------- Pipeline Failure -------------"
  echo "Error on (3) Pushing to git - Make sure username and PAT are correct"
  echo ""
  exit
fi

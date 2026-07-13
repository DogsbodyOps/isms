#!/bin/bash

set -e

# Download isms file
curl -fsSL https://raw.githubusercontent.com/DogsbodyOps/isms/refs/heads/main/isms -o /usr/share/games/fortunes/isms

# Create dat file
strfile /usr/share/games/fortunes/isms

#Amend File permissions
chmod og+r /usr/share/games/fortunes/isms
chmod og+r /usr/share/games/fortunes/isms.dat

# Test
fortune isms | cowsay

read -p "Deploy to bashrc? (y/n)" DEPLOY
if [ $DEPLOY = y ]; then
  echo "Deploying to bashrc"
  grep -qF 'fortune isms | cowsay' ~/.bashrc || echo 'fortune isms | cowsay' >> ~/.bashrc
else
  echo "Not Deploying, add ```fortune isms | cowsay``` to bashrc if desired."
fi

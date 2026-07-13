#!/bin/bash

# Download isms file
curl https://raw.githubusercontent.com/DogsbodyOps/isms/refs/heads/main/ismsfile -o /usr/share/games/fortunes/isms

# Create dat file
sudo strfile /usr/share/games/fortunes/isms

#Amend File permissions
sudo chmod og+r /usr/share/games/fortunes/isms
sudo chmod og+r /usr/share/games/fortunes/isms.dat

# Test
fortune isms | cowsay

read -p "Deploy to bashrc? (y/n)" DEPLOY
if [ $DEPLOY = y ]; then
  echo "Deploying to bashrc"
  echo "fortune isms | cowsay" >> ~/.bashrc
else
  echo "Not Deploying, add ```fortune isms | cowsay``` to bahsrc if desired."
fi

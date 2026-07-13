#!/bin/bash

set -e

# Download isms file
sudo curl -fsSL https://raw.githubusercontent.com/DogsbodyOps/isms/refs/heads/main/isms -o /usr/share/games/fortune/isms

# Create dat file
sudo strfile /usr/share/games/fortune/isms

#Amend File permissions
sudo chmod og+r /usr/share/games/fortune/isms
sudo chmod og+r /usr/share/games/fortune/isms.dat

# Test
fortune isms | cowsay

echo "Deploying to bashrc"
grep -qF 'fortune isms | cowsay' ~/.bashrc || echo 'fortune isms | cowsay' >> ~/.bashrc

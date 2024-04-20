#!/usr/bin/env bash
set -e  # Exit on error

echo "Navigating to dotfiles repository..."
cd ~/dotfiles  # Ensure you are in the right directory

echo "Adding all changes to Git..."
git add .  # Add all changes, including new files and deletions

echo "Committing changes..."
git commit -m "Auto-commit before NixOS rebuild." || echo "No changes to commit."

echo "Starting NixOS rebuild..."
# Perform the rebuild, logging errors to a file
sudo nixos-rebuild switch --flake . &>nixos-switch.log || {
  echo "Rebuild failed, see errors below:"
  cat nixos-switch.log | grep --color=always error
  exit 1
}

echo "Rebuild successful. Pushing changes to remote repository..."
git push  # Push changes to your remote repository

echo "NixOS configuration updated and changes pushed."

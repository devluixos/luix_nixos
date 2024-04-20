#!/usr/bin/env bash
set -e  # Exit on error

# Use absolute path
DOTFILES_DIR="/home/luix/dotfiles/nixos"

echo "Navigating to dotfiles/nixos repository..."
pushd $DOTFILES_DIR  # Change to the correct directory containing flake.nix

echo "Formatting Nix files..."
alejandra . &>> $DOTFILES_DIR/nixos-switch.log

echo "Adding all changes to Git..."
git add -A

echo "Checking for changes..."
if git diff --cached --quiet; then
  echo "No changes detected."
else
  echo "Rebuilding NixOS..."
  if sudo nixos-rebuild switch --flake $DOTFILES_DIR &>> $DOTFILES_DIR/nixos-switch.log; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Rebuild successful." >> $DOTFILES_DIR/nixos-switch.log
    echo "Committing changes..."
    gen=$(nixos-rebuild list-generations | grep current | cut -d' ' -f2-)
    git commit -m "Rebuild at generation: $gen"
    echo "Commit successful. Generation: $gen."
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Rebuild failed. Check $DOTFILES_DIR/nixos-switch.log for details." >> $DOTFILES_DIR/nixos-switch.log
    cat $DOTFILES_DIR/nixos-switch.log | grep --color=always error
    exit 1
  fi
fi

popd

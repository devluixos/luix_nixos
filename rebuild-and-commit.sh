#!/usr/bin/env bash
set -e  # Exit on error

# The directory containing the source .nix files
SOURCE_DIR="/home/luix/dotfiles/nixos"

# The target directory for the symlinks
TARGET_DIR="/etc/nixos"

# For each .nix file in the source directory
for file in $SOURCE_DIR/*.nix; do
  # The name of the symlink in the target directory
  symlink="$TARGET_DIR/$(basename $file)"

  # If the symlink does not exist or points to a non-existent file
  if [ ! -e $symlink ]; then
    # Create the symlink
    ln -s $file $symlink
    echo "Created symlink: $symlink"
  fi
done

# Use absolute path
DOTFILES_DIR="/home/luix/dotfiles/nixos"
GIT_DIR="/home/luix/dotfiles"

# Ensure the current user owns the .git directory
sudo chown -R $(whoami) $GIT_DIR/.git


echo "Navigating to dotfiles/nixos repository..."
pushd $DOTFILES_DIR  # Change to the correct directory containing flake.nix

echo "Formatting Nix files..."
alejandra . &>> $DOTFILES_DIR/nixos-switch.log

echo "Checking for changes..."
if git diff --quiet; then
  echo "No changes detected."
else
  echo "Rebuilding NixOS..."
  # Rebuild using sudo, specifically for nixos-rebuild which needs root privileges
  if sudo nixos-rebuild switch --flake $DOTFILES_DIR | tee -a $DOTFILES_DIR/nixos-switch.log; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Rebuild successful." >> $DOTFILES_DIR/nixos-switch.log
    echo "Committing changes..."
    gen=$(sudo nixos-rebuild list-generations | grep current | cut -d' ' -f2-)
    git add -A
    git commit -m "Rebuild at generation: $gen"
    git push
    echo "Commit successful. Generation: $gen."
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Rebuild failed. Check $DOTFILES_DIR/nixos-switch.log for details." >> $DOTFILES_DIR/nixos-switch.log
    cat $DOTFILES_DIR/nixos-switch.log | grep --color=always error
    exit 1
  fi
fi

popd

#!/usr/bin/env bash
set -e  # Exit on error

# Navigate to your NixOS configuration directory
pushd /etc/nixos/

# Optional: Open your main configuration file with an editor (uncomment to use)
# nvim configuration.nix

# Format the Nix files (using nixpkgs-fmt for formatting, install if needed)
find . -name "*.nix" -exec nixpkgs-fmt {} \;

# Display changes for review
git diff -U0 *.nix

echo "NixOS Rebuilding..."
# Perform the rebuild, log errors to a file
sudo nixos-rebuild switch --flake . &>nixos-switch.log || (
  cat nixos-switch.log | grep --color=always error && false)

# Get current generation description
gen=$(nixos-rebuild list-generations | grep current | cut -d' ' -f2-)

# Commit the changes with the generation number
git commit -am "Rebuild at generation: $gen"

# Return to the original directory
popd

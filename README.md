# Rebuild and Commit Script

This script automates the process of rebuilding NixOS and committing the changes to a Git repository. It is designed to be used with a NixOS configuration managed in a Git repository.

## How it works

1. The script first navigates to the NixOS configuration directory.
2. It then formats the Nix files using the `alejandra` command and logs the output.
3. The script checks for any unstaged changes in the Git repository. If there are no changes, the script exits.
4. If there are changes, the script rebuilds NixOS using the `nixos-rebuild switch` command. The output of the command is both displayed in the terminal and logged to a file.
5. If the rebuild is successful, the script stages all changes, commits them with a message indicating the current NixOS generation, and pushes the commit to the remote repository.
6. If the rebuild fails, the script logs the failure and exits with a non-zero status code.

## Packages

The packages installed by the NixOS configuration are defined in the `flake.nix` and `configuration.nix` files. Here is a list of the packages:

(Replace this text with a list of the packages defined in `flake.nix` and `configuration.nix`)

## Usage

To use this script, simply run it from the terminal:

```bash
/home/luix/dotfiles/rebuild-and-commit.sh
```

Sure, here's the markdown version of the README:

```markdown
# Rebuild and Commit Script

This script automates the process of rebuilding NixOS and committing the changes to a Git repository. It is designed to be used with a NixOS configuration managed in a Git repository.

## How it works

1. The script first navigates to the NixOS configuration directory.
2. It then formats the Nix files using the `alejandra` command and logs the output.
3. The script checks for any unstaged changes in the Git repository. If there are no changes, the script exits.
4. If there are changes, the script rebuilds NixOS using the `nixos-rebuild switch` command. The output of the command is both displayed in the terminal and logged to a file.
5. If the rebuild is successful, the script stages all changes, commits them with a message indicating the current NixOS generation, and pushes the commit to the remote repository.
6. If the rebuild fails, the script logs the failure and exits with a non-zero status code.

## Packages

The packages installed by the NixOS configuration are defined in the `flake.nix` and `configuration.nix` files. Here is a list of the packages:

(Replace this text with a list of the packages defined in `flake.nix` and `configuration.nix`)

## Usage

To use this script, simply run it from the terminal:

```bash
/home/luix/dotfiles/rebuild-and-commit.sh
```

You can also create an alias for the script to run it from anywhere. Add the following line to your shell's configuration file (`.bashrc` or `.zshrc`):

```bash
alias rebuild='/home/luix/dotfiles/rebuild-and-commit.sh'
```

Then, source the configuration file:

```bash
source ~/.bashrc  # or source ~/.zshrc
```


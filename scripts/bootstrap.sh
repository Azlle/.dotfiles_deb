#!/usr/bin/env bash
set -e

echo "- Nix Installation (Step 1/2)"

echo "Installing Nix..."
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

echo "Cloning dotfiles repository..."
git clone https://github.com/Azlle/.dotfiles_deb.git $HOME/.dotfiles_deb

echo ""
echo "- Step 1 Complete!"
echo "Please restart WSL with: wsl.exe --shutdown"
echo "After restart, run: ~/.dotfiles_deb/scripts/install.sh"

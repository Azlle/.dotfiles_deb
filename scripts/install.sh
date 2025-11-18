#!/usr/bin/env bash
set -e

echo "- Home Manager Setup (Step 2/2)"

cd "$(dirname "$0")/.."
sed -i "s/username = \".*\";/username = \"$USER\";/g" home.nix

echo "Applying Home Manager configuration..."
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run home-manager/master -- switch --flake .#sumizomenosakura

echo "Cleaning up apt packages..."
sudo apt purge -y curl xz-utils git && sudo apt autoremove -y

echo "Setting Zsh as default shell..."
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)

echo ""
echo "- Setup Complete!"
echo "Restart WSL with: wsl.exe --shutdown"
echo "After restart, you're all set!"

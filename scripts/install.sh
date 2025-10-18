#!/usr/bin/env bash
set -e

export NIX_CONFIG="experimental-features = nix-command flakes"

cd "$(dirname "$0")"
nix run home-manager/master -- switch --flake .#miyu

sudo apt purge -y curl xz-utils && sudo apt autoremove -y

echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)

echo "Restart WSL with: wsl.exe --shutdown"

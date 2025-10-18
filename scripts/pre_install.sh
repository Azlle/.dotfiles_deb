#!/usr/bin/env bash
set -e

sudo apt update && sudo apt install -y curl xz-utils
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

echo "Restart WSL with: wsl.exe --shutdown"

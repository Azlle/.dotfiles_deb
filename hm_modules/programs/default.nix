# default.nix
{ ... }:

{
  imports = [
    ./eza.nix
    ./fish.nix
    ./gallery-dl.nix
    ./git.nix
    ./helix.nix
    ./nvim.nix
    ./yazi.nix
    ./yt-dlp.nix
    ./zsh.nix
  ];
}

# default.nix
{ ... }:

{
  imports = [
    ./fish.nix
    ./gl-dl.nix
    ./git.nix
    ./helix.nix
    ./nvim.nix
    ./yazi.nix
    ./yt-dlp.nix
    ./zsh.nix
  ];
}

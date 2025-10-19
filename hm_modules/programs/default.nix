# default.nix
{ ... }:

{
  imports = [
    ./fish.nix
    ./gl-dl.nix
    ./git.nix
    ./helix.nix
    ./nvim.nix
    ./yt-dlp.nix
  ];
}

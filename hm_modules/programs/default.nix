# default.nix
{ ... }:

{
  imports = [
    ./fish.nix
    ./gl-dl.nix
    ./git.nix
    ./nvim.nix
    ./yt-dlp.nix
  ];
}

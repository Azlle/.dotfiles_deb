# default.nix
{ ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./nvim.nix
    ./yt-dlp.nix
  ];
}

# default.nix
{ ... }:

{
  imports = [
    ./eza.nix
    ./gallery-dl.nix
    ./git.nix
    ./helix.nix
    ./nvim.nix
    ./yazi.nix
    ./yt-dlp.nix
    ./zatta.nix
    ./zsh.nix
  ];
}

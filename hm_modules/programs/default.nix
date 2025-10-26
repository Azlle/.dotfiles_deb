# default.nix
{ ... }:

{
  imports = [
    ./eza.nix
    ./gl-dl.nix
    ./git.nix
    ./helix.nix
    ./nvim.nix
    ./yazi.nix
    ./yt-dlp.nix
    ./zsh.nix
  ];
}

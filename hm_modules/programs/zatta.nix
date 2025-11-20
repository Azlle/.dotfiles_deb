# zatta.nix
{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    libarchive xz zstd
    gh rsync openssh
    htop curl bat ffmpeg
    tmux zellij
  ];
}

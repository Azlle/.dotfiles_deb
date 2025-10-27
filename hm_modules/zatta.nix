# zatta.nix
{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    unzip unrar xz zstd
    gh htop rsync openssh curl bat ffmpeg
  ];
}

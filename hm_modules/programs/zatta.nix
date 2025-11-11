# zatta.nix
{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    unzip unrar xz zstd
    gh htop rsync openssh curl bat ffmpeg
    deno # zeno.zshで依存していたり, yt-dlpで依存予定らしいのでコチラに
    tmux zellij
  ];
}

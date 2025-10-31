# eza.nix
{ ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = false;

    extraOptions = [
      "--group-directories-first"
      "--color=always"
      "--icons"
      "--git"
    ];
  };
}

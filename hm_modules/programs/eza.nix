# eza.nix
{ ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;

    extraOptions = [
      "--group-directories-first"
      "--icons"
      "--git"
    ];
  };
}

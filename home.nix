# home.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hm_modules
  ];

  programs.home-manager.enable = true;

  home = rec {
    username = "miyu";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}

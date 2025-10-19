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

  # fish.enable = trueにしてもPATHを通すのに失敗しているので手動で
  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
  ];
}

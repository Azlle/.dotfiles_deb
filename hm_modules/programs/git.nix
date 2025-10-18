# git.nix
{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Azlle";
    userEmail = "moxmo2@pm.me";
    
    extraConfig = {
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      merge.ff = false;
      pull.ff = "only";
    };
  };
}

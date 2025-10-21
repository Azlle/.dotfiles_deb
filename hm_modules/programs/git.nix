# git.nix
{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Azlle";
        email = "moxmo2@pm.me";
      };

      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      merge.ff = false;
      pull.ff = "only";
    };
  };
}

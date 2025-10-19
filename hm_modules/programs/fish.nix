# fish.nix
{ pkgs, config, ... }:

{
  programs.keychain = {
    enable = true;
    keys = [ "github_ed25519" ];
    enableFishIntegration = true;
  };
   
  programs.fish = {
    enable = true;
    
    loginShellInit = ''
      fish_add_path --prepend ~/.nix-profile/bin /nix/var/nix/profiles/default/bin
    '';

    shellInit = ''
      set fish_greeting
    '';
    
    shellAbbrs = {
      la = "ls -ahl --group-directories-first";
      rmtrash = "rm -rf ~/.local/share/Trash/files/*";
      nano = "nvim";

      # nix
      hmsf = "home-manager switch --flake ~/.dotfiles_deb/";
      nist = "nix store gc && nix store optimise";

      # git
      gst = "git status";
      gcm = "git commit -m";
      gl = "git log --graph --date=iso --pretty='format:%C(yellow)%h %C(cyan)%ad %C(green)%an%Creset%x09%s %C(red)%d%Creset'";
    };
  };
}

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

    interactiveShellInit = ''
      set fish_greeting

      function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      end
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

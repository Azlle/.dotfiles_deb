# fish.nix
{ pkgs, config, ... }:

{
  programs.keychain = {
    enable = true;
    keys = [ "github_ed25519" "Nix_ed25519" ];
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
      la = "eza -glBa"; # group, long, Bytes, all
      lsnix = "eza -gT $(nix build nixpkgs# --no-link --print-out-paths)";
      rmt = "rm -rf ~/.local/share/Trash/files/*";
      vi = "hx";

      # nix
      hmsf = "home-manager switch --flake ~/.dotfiles_deb/";
      nist = "nix store gc && nix store optimise";
      ydl = "nix run nixpkgs/nixpkgs-unstable#yt-dlp --";
      gdl = "nix run nixpkgs/nixpkgs-unstable#gallery-dl --";

      # git
      gst = "git status";
      ga = "git add .";
      gcm = "git commit -m";
      gp = "git push";
      gl = "git log --graph --date=iso --pretty='format:%C(yellow)%h %C(cyan)%ad %C(green)%an%Creset%x09%s %C(red)%d%Creset'";
    };

    plugins = [
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
    ];
  };
}

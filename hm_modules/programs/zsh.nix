# zsh.nix
{ pkgs, config, lib, ... }: with lib;

{
  programs.keychain = {
    enable = true;
    keys = [ "github_ed25519" ];
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    zsh-abbr = {
      enable = true;
      abbreviations = {
        ls = "eza -Bl";
        la = "eza -aaghl";
        rmtrash = "rm -rf ~/.local/share/Trash/files/*";
        nano = "hx";

        # nix
        hmsf = "home-manager switch --flake ~/.dotfiles_deb/";
        nist = "nix store gc && nix store optimise";

        # git
        gst = "git status";
        gcm = "git commit -m";
        gl = "git log --graph --date=iso --pretty='format:%C(yellow)%h %C(cyan)%ad %C(green)%an%Creset%x09%s %C(red)%d%Creset'";
      };
    };

    history = {
      size = 100000;
      save = 100000;

      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      saveNoDups = true;

      ignoreSpace = true;
      share = true;
    };

    antidote = {
      enable = false;
      plugins = [
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ../.config/p10k-config;
        file = ".p10k.zsh";
      }
    ];

    initContent = mkOrder 1500 ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';

    setOptions = [ "NO_BEEP" ];
  };
}

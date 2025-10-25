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
    setOptions = [
      "AUTO_CD" "NO_BEEP" "LIST_PACKED"
      "EXTENDED_GLOB" "GLOB_DOTS" "NUMERIC_GLOB_SORT" "NULL_GLOB" 
    ];

    zsh-abbr = {
      enable = true;
      abbreviations = {
        # ./eza.nixのextraOptionsで省略している
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
      enable = true;
      plugins = [
        "chisui/zsh-nix-shell"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-history-substring-search"
        "zdharma-continuum/fast-syntax-highlighting"
        "olets/zsh-autosuggestions-abbreviations-strategy"
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

    initContent = mkMerge [
      (mkOrder 500 ''
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|?=** r:|=*'
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '')

      (mkOrder 1500 ''
         ZSH_AUTOSUGGEST_STRATEGY=( abbreviations history completion )
      '')
    ];
  };
}

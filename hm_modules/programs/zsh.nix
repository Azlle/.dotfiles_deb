# zsh.nix
{ pkgs, config, lib, ... }: with lib;

{
  programs.keychain = {
    enable = true;
    keys = [ "github_ed25519" "Nix_ed25519" ];
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    
    setOptions = [
      "AUTO_CD" "NO_BEEP" "MAGIC_EQUAL_SUBST" "LIST_PACKED"
      "EXTENDED_GLOB" "GLOB_DOTS" "NUMERIC_GLOB_SORT" "NULL_GLOB" 
    ];

    zsh-abbr = {
      enable = true;
      abbreviations = {
        # ./eza.nixのextraOptionsで省略している
        la = "eza -glBa"; # group, long, Bytes, all
        lsnix = "eza -gT $(nix build nixpkgs# --no-link --print-out-paths)";
        rmt = "rm -rf ~/.local/share/Trash/files/*";
        vi = "hx";

        # nix
        hmsf = "home-manager switch --flake ~/.dotfiles_deb/";
        nist = "nix store gc && nix store optimise";
        dlp = "nix run nixpkgs/nixpkgs-unstable#yt-dlp --";

        # git
        gst = "git status";
        ga = "git add .";
        gcm = "git commit -m";
        gp = "git push";
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

    # eza -gT $(nix build nixpkgs# --no-link --print-out-paths) で.plugin.zshを探す
    plugins = [
      { name = "powerlevel10k"; src = pkgs.zsh-powerlevel10k; file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; }
      { name = "powerlevel10k-config"; src = ../.config/p10k-config; file = ".p10k.zsh"; }

      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting";
      }
      {
        name = "zsh-autosuggestions-abbreviations-strategy";
        src = "${pkgs.zsh-autosuggestions-abbreviations-strategy}/share/zsh/site-functions";
      }
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];

    initContent = mkMerge [
      (mkOrder 500 ''
        zstyle ':completion:*' menu no
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*:descriptions' format $'\e[22m[ %d ]\e[m'
        zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
        zstyle ':completion:*' matcher-list "" 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
        zstyle ':fzf-tab:*' switch-group '<' '>'

        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path ~/.zsh/cache
      '')

      (mkOrder 1000 ''
        local noglob_cmds=(
          nix git curl wget rsync
          yt-dlp gallery-dl
        )
        for cmd in $noglob_cmds; do
          alias $cmd="noglob $cmd"
        done
      '')

      (mkOrder 1500 ''
        ZSH_AUTOSUGGEST_STRATEGY=( abbreviations history completion )
      '')
    ];
  };
}

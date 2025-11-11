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
    defaultKeymap = "viins";
    enableCompletion = false; # compinitの記述がヘルシーじゃない
    autosuggestion.enable = false; # ロード順の関係でpluginsで記述している
    historySubstringSearch.enable = true;
    
    setOptions = [
      "AUTO_CD" "NO_BEEP" "MAGIC_EQUAL_SUBST" "LIST_PACKED" "PROMPT_SUBST"
      "GLOB_DOTS" "NUMERIC_GLOB_SORT" "NULL_GLOB" # "EXTENDED_GLOB"はinitContentに書いた 
    ];

    shellAliases = {
      # ./eza.nixのextraOptionsで省略している
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
      gp = "git push";
      gl = "git log --graph --date=iso --pretty='format:%C(yellow)%h %C(cyan)%ad %C(green)%an%Creset%x09%s %C(red)%d%Creset'";
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

      { name = "F-Sy-H"; src = "${pkgs.zsh-f-sy-h}/share/zsh/site-functions"; }

      {
        name = "zeno.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "yuki-yano";
          repo = "zeno.zsh";
          rev = "main";
          sha256 = "sha256-dLusSPNeG4U95DfGEspPinxFIhkbJ+Q1Dhvef42uI7Q=";
        };
        file = "zeno.zsh";
      }

      # { name = "zsh-autosuggestions"; src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions"; }
    ];

    initContent = mkMerge [
      (mkOrder 500 ''
        setopt EXTENDED_GLOB

        autoload -Uz compinit
  
        echo "=== Compinit Debug ==="
        if [[ -n ''${ZDOTDIR:-$HOME}/.zcompdump(#qNmh+24) ]]; then
          echo "Running full compinit"
          compinit
        else
          echo "Running compinit -C (cached)"
          compinit -C
        fi

        zstyle ':completion:*' menu no
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*:descriptions' format $'\e[22m[ %d ]\e[m'
        zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
        zstyle ':completion:*' matcher-list "" 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

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
        export KEYTIMEOUT=15
        bindkey -M viins 'jk' vi-cmd-mode       

        export ZENO_HOME=~/.config/zeno
        export ZENO_ENABLE_FZF_TMUX=1
        export ZENO_FZF_TMUX_OPTIONS="--reverse"
        export ZENO_GIT_CAT="bat --color=always"
        export ZENO_GIT_TREE="eza --tree"

        if [[ -n $ZENO_LOADED ]]; then
          bindkey ' '  zeno-auto-snippet

          bindkey '^m' zeno-auto-snippet-and-accept-line

          bindkey '^i' zeno-completion

          bindkey '^x '  zeno-insert-space
          bindkey '^x^m' accept-line
          bindkey '^x^z' zeno-toggle-auto-snippet

          # bindkey '^r' zeno-history-selection
          bindkey '^r' zeno-smart-history-selection
        fi
      '')
    ];
  };

  # zeno.zsh
  # home.packages = with pkgs; [ deno tmux ]; はzatta.nixに書きました

  xdg.configFile."zeno/config.yml".text = ''
    snippets:
      - name: List all files
        keyword: la
        snippet: eza -glBa

      - name: List nixpkgs src
        keyword: lsn
        snippet: eza -gT $(nix build nixpkgs#{{package_name}} --no-link --print-out-paths)

      - name: git commit message
        keyword: gcm
        snippet: git commit -m '{{commit_message}}'

    history:
      defaultScope: global        # "global" | "repository" | "directory" | "session"
      fzfCommand: fzf-tmux        # Override the command that spawns the picker
      fzfOptions:
        - "-p 50%,50%"            # Additional arguments passed to the picker command
      redact: []                  # Strings to hide from the History view
      keymap:
        deleteSoft: ctrl-d        # Soft delete (logical delete)
        deleteHard: alt-d         # Hard delete (edits HISTFILE)
        toggleScope: ctrl-r       # Cycle through scopes within the widget
        togglePreview: ?          # Toggle the preview window
  '';
}

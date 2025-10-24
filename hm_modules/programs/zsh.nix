# zsh.nix
{ pkgs, config, ... }:

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
        la = "ls -ahl --group-directories-first";
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

    setOptions = [ "NO_BEEP" ];
  };
}

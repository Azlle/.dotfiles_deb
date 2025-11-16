# zsh.nix
{ pkgs, config, lib, ... }: with lib;

{
  xdg.configFile."zsh" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles_deb/hm_modules/.config/zsh";
    recursive = true;
  };

  programs = {
    keychain.enableZshIntegration = true;
    sheldon.enableZshIntegration = true;
    fzf.enableZshIntegration = false;
    zoxide.enableZshIntegration = true;
  };

  programs.keychain = {
    enable = true;
    keys = [ "github_ed25519" "Nix_ed25519" ];
  };
  
  home.packages = with pkgs; [ sheldon deno tmux ];
  
  programs.zsh = {
    enable = true;
    enableCompletion = false;

    initContent = mkMerge [
      (mkOrder 500 ''
        export ZSH_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
        export SHELDON_CONFIG_FILE="$ZSH_HOME/sheldon/config.toml"
        # source "$ZSH_HOME/zcompile.zsh"
        source "$ZSH_HOME/setopt.zsh"
      '')

      (mkOrder 1000 ''
        source "$ZSH_HOME/comp.zsh"
        source "$ZSH_HOME/history.zsh"
      '')

      (mkOrder 1500 ''
        source "$ZSH_HOME/sheldon.zsh"
        source "$ZSH_HOME/alias.zsh"
        source "$ZSH_HOME/zeno.zsh"
        source "$ZSH_HOME/bindkey.zsh"
        zsh-defer unfunction source
      '')
    ];
  };
}

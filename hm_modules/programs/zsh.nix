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

  home.packages = with pkgs; [ sheldon deno tmux keychain ];
  
  programs.zsh = {
    enable = true;
    enableCompletion = false;

    initContent = mkMerge [
      (mkOrder 500 ''
        export LANG=en_US.UTF-8
        export ZSH_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
        export SHELDON_CONFIG_FILE="$ZSH_HOME/sheldon/plugins.toml"
        # source "$ZSH_HOME/zcompile.zsh"
        source "$ZSH_HOME/setopt.zsh"
      '')

      (mkOrder 1000 ''
        source "$ZSH_HOME/comp.zsh"
        source "$ZSH_HOME/history.zsh"
        source "$ZSH_HOME/keychain.zsh"
      '')

      (mkOrder 1500 ''
        source "$ZSH_HOME/sheldon.zsh"
        source "$ZSH_HOME/alias.zsh"
        source "$ZSH_HOME/bindkey.zsh"
        # zsh-defer unfunction source
      '')
    ];
  };
}

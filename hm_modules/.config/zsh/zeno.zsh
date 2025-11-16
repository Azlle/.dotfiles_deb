export ZENO_HOME=~/.config/zsh/zeno
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

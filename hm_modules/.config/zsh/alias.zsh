# evade glob
local noglob_cmds=(
  nix home-manager
  git curl wget rsync
  yt-dlp gallery-dl
)
for cmd in $noglob_cmds; do
  alias $cmd="noglob $cmd"
done

# ./eza.nix の extraOptions で省略している
alias rmt='rm -rf ~/.local/share/Trash/files/*'
alias vi='hx'

# nix
alias nist='nix store gc && nix store optimise'
alias gdl='nix run --refresh nixpkgs/nixpkgs-unstable#gallery-dl --'

# git
alias gst='git status'
alias gaa='git add .'
alias gp='git push'
alias gl='git log --graph --date=iso --pretty=format:%C(yellow)%h\ %C(cyan)%ad\ %C(green)%an%Creset%x09%s\ %C(red)%d%Creset'

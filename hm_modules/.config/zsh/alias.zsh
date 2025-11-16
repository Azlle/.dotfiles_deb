# evade glob
local noglob_cmds=(
  nix git curl wget rsync
  yt-dlp gallery-dl
)
for cmd in $noglob_cmds; do
  alias $cmd="noglob $cmd"
done

# ./eza.nix の extraOptions で省略している
alias rmt='rm -rf ~/.local/share/Trash/files/*'
alias vi='hx'

# nix
alias hmsf='home-manager switch --flake ~/.dotfiles_deb/'
alias nist='nix store gc && nix store optimise'
alias ydl='nix run nixpkgs/nixpkgs-unstable#yt-dlp --'
alias gdl='nix run nixpkgs/nixpkgs-unstable#gallery-dl --'

# git
alias gst='git status'
alias ga='git add .'
alias gp='git push'
alias gl='git log --graph --date=iso --pretty=format:%C(yellow)%h\ %C(cyan)%ad\ %C(green)%an%Creset%x09%s\ %C(red)%d%Creset'

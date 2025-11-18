KEYCHAIN_SH="$HOME/.keychain/$(hostname)-sh"

[[ -f "$KEYCHAIN_SH" ]] && source "$KEYCHAIN_SH"

if ! ssh-add -l &>/dev/null; then
    keychain --quiet github_ed25519 Nix_ed25519
    source "$KEYCHAIN_SH"
fi

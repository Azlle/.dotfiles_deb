# .dotfiles_deb
WSL2 Debianで使用しているNixのごった煮。

## セットアップ

### 1. curlがインストールされていることを確認
Debianにはデフォルトでcurlが入っていない ***wow***
```bash
sudo apt update && sudo apt install -y curl xz-utils git
```

### 2. bootstrap.shの実行
```bash
curl -fsSL https://raw.githubusercontent.com/Azlle/.dotfiles_deb/main/scripts/bootstrap.sh | bash
```
実行後、`wsl.exe --shutdown`で再起動する。

### 3. install.shの実行
```bash
~/.dotfiles_deb/scripts/install.sh
```
実行後、`wsl.exe --shutdown`で再起動する。

以上で完了し、Zsh環境で起動する。

以下のようなAbbreviationsが登録されている:

| abbr | 展開後 |
|------|--------|
| `hmsf` | `home-manager switch --flake ~/.dotfiles_deb/` |
| `nist` | `nix store gc && nix store optimise` |

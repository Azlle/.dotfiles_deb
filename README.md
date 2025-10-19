# .dotfiles_deb
WSL2 Debianで使用しているNixのごった煮。

## セットアップ

### 1. curlのインストール
Debianにはデフォルトでcurlが入っていない ***wow***
```bash
sudo apt update && sudo apt install -y curl
```

### 2. bootstrapスクリプトの実行
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Azlle/.dotfiles_deb/main/scripts/bootstrap.sh)"
```

### 3. WSL再起動
```
wsl.exe --shutdown
```

### 4. installスクリプトの実行
```bash
~/.dotfiles_deb/scripts/install.sh
```

### 5. WSL再起動（再び）
```
wsl.exe --shutdown
```

以上で完了し、fish環境で起動する。

以下のようなAbbreviationsが登録されている:

| abbr | 展開後 |
|------|--------|
| `hmsf` | `home-manager switch --flake ~/.dotfiles_deb/` |
| `nsgc` | `nix store gc` |

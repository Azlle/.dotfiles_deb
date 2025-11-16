# ファイル名を変数に入れる
CACHE_DIR=${XDG_CACHE_HOME:-$HOME/.cache}
SHELDON_CACHE="$CACHE_DIR/sheldon_cache.zsh"
# キャッシュがない、またはキャッシュが古い場合にキャッシュを作成
if [[ ! -r "$SHELDON_CACHE" || "$SHELDON_CONFIG_FILE" -nt "$SHELDON_CACHE" ]]; then
  mkdir -p $CACHE_DIR
  sheldon source > $SHELDON_CACHE
fi
source "$SHELDON_CACHE"
# 使い終わった変数を削除
unset CACHE_DIR SHELDON_CACHE

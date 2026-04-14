#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_SHARED="$DOTFILES_DIR/shared/bin"
DEST="$HOME/.local/bin"

echo "[+] Linking shared config: $SRC_SHARED → $DEST"

link_tree() {
  local src_root="$1"
  local rel target

  [[ -d "$src_root" ]] || return 0

  # Create directories first, but skip the root itself
  while IFS= read -r -d '' dir; do
    rel="${dir#"$src_root"}"
    rel="${rel#/}"
    [[ "$rel" == "$dir" ]] && continue
    mkdir -v -p "$DEST/$rel"
  done < <(find "$src_root" -mindepth 1 -type d -print0)

  # Link files
  while IFS= read -r -d '' file; do
    rel="${file#"$src_root"}"
    rel="${rel#/}"
    target="$DEST/$rel"

    if [[ -e "$target" || -L "$target" ]]; then
        echo "[!] $target already exists!"
    else
        ln -snv -- "$file" "$target"
    fi

  done < <(find "$src_root" -mindepth 1 \( -type f -o -type l \) -print0)
}

# Apply shared config
link_tree "$SRC_SHARED"

# Apply profile overlay
PROFILE="${1:-}"
if [[ -n "$PROFILE" ]]; then
  SRC_PROFILE="$DOTFILES_DIR/$PROFILE/bin"

  if [[ -d "$SRC_PROFILE" ]]; then
    echo "[+] Applying profile: $PROFILE"
    link_tree "$SRC_PROFILE"
  else
    echo "[!] Profile '$PROFILE' not found"
  fi
fi

echo "[+] Done"


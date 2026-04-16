#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_SHARED="$DOTFILES_DIR/shared/config"
DEST="$HOME"

transform_path() {
  local input="$1"
  local output=""
  local part
  local -a parts

  IFS='/' read -ra parts <<< "$input"

  for part in "${parts[@]}"; do
    if [[ "$part" == dot-* ]]; then
      part=".${part#dot-}"
    fi
    output+="/$part"
  done

  printf '%s\n' "${output#/}"
}

BACKUP_DIR="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "[+] Linking shared config: $SRC_SHARED → $DEST"
echo "[+] Backup dir: $BACKUP_DIR"

link_tree() {
  local src_root="$1"
  local rel target backup_path

  [[ -d "$src_root" ]] || return 0

  # Create directories first, but skip the root itself
  while IFS= read -r -d '' dir; do
    rel="${dir#"$src_root"}"
    rel="${rel#/}"
    [[ "$rel" == "$dir" ]] && continue
    rel="$(transform_path "$rel")"
    mkdir -v -p "$DEST/$rel"
  done < <(find "$src_root" -mindepth 1 -type d -print0)

  # Link files
  while IFS= read -r -d '' file; do
    rel="${file#"$src_root"}"
    rel="${rel#/}"
    rel="$(transform_path "$rel")"
    target="$DEST/$rel"

    if [[ -e "$target" || -L "$target" ]]; then
      if [[ -L "$target" && "$(readlink -f "$target")" == "$(readlink -f "$file")" ]]; then
        echo "$target already installed"
        continue
      fi

      backup_path="$BACKUP_DIR/$rel"
      mkdir -p "$(dirname "$backup_path")"
      mv -- "$target" "$backup_path"
    fi

    ln -snv -- "$file" "$target"
  done < <(find "$src_root" -mindepth 1 \( -type f -o -type l \) -print0)
}

# Apply shared config
link_tree "$SRC_SHARED"

# Apply profile overlay
PROFILE="${1:-}"
if [[ -n "$PROFILE" ]]; then
  SRC_PROFILE="$DOTFILES_DIR/$PROFILE/config/"

  if [[ -d "$SRC_PROFILE" ]]; then
    echo "[+] Applying profile: $PROFILE"
    link_tree "$SRC_PROFILE"
  else
    echo "[!] Profile '$PROFILE' not found"
  fi
fi

ANTIDOTE_DIR="$HOME/.zsh/antidote"

if [[ ! -d "$ANTIDOTE_DIR" ]]; then
  echo "[+] Installing antidote..."
  git clone --depth=1 https://github.com/mattmc3/antidote "$ANTIDOTE_DIR"
else
  echo "[+] Updating antidote..."
  git -C "$ANTIDOTE_DIR" pull --ff-only
fi

echo "[+] Applying zsh highlight theme..."
zsh -c "source ~/.zshrc && fast-theme ~/.zsh/highlight-theme.ini"

echo "[+] Applying gtk themes"
nwg-look -a

echo "[+] Done"


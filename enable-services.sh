#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE=""
TARGET_USER="${USER:-}"

usage() {
  cat <<'EOF'
Usage:
  enable-services.sh [profile] [--user USER]

Examples:
  enable-services.sh
  enable-services.sh pc
  enable-services.sh laptop --user nickname
EOF
}

# -------- argument parsing --------
while [[ $# -gt 0 ]]; do
  case "$1" in
    --user|-u)
      TARGET_USER="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -z "$PROFILE" ]]; then
        PROFILE="$1"
        shift
      else
        echo "[!] Unexpected extra argument: $1"
        exit 1
      fi
      ;;
  esac
done

# -------- prepare user services --------

if [[ -n "$TARGET_USER" ]]; then
  echo "[+] Ensuring lingering is enabled for $TARGET_USER"
  if [[ $EUID -ne 0 ]]; then
    sudo loginctl enable-linger "$TARGET_USER"
  else
    loginctl enable-linger "$TARGET_USER"
  fi
fi

# -------- helpers --------
trim() {
  local s="$1"
  s="${s#"${s%%[![:space:]]*}"}"
  s="${s%"${s##*[![:space:]]}"}"
  printf '%s' "$s"
}

enable_system() {
  local unit="$1"
  echo "[+] system: $unit"
  sudo systemctl enable --now "$unit"
}

enable_user() {
  local unit="$1"

  echo "[+] user($TARGET_USER): $unit"

  if [[ $EUID -ne 0 ]]; then
    systemctl --user enable --now "$unit"
    return
  fi

  uid="$(id -u "$TARGET_USER")"
  runtime="/run/user/$uid"

  if [[ $EUID -ne 0 ]]; then
    if [[ "$TARGET_USER" != "$USER" ]]; then
      echo "[!] Must run as root to target another user"
      return
    fi
    systemctl --user enable --now "$unit"
    return
  fi
  sudo -u "$TARGET_USER" \
    XDG_RUNTIME_DIR="$runtime" \
    systemctl --user enable --now "$unit"
}

process_file() {
  local scope="$1"
  local file="$2"

  [[ -f "$file" ]] || return 0

  echo "[+] Processing $file"

  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%%#*}"
    line="$(trim "$line")"
    [[ -z "$line" ]] && continue

    if [[ "$scope" == "system" ]]; then
      if ! enable_system "$line"; then
        echo "[!] Failed: $line"
      fi
    else
      enable_user "$line"
    fi
  done < "$file"
}

# -------- run --------

echo "[+] Profile: ${PROFILE:-<none>}"

process_file system "$DOTFILES_DIR/shared/system-services.txt"
process_file user   "$DOTFILES_DIR/shared/user-services.txt"

if [[ -n "$PROFILE" ]]; then
  process_file system "$DOTFILES_DIR/$PROFILE/system-services.txt"
  process_file user   "$DOTFILES_DIR/$PROFILE/user-services.txt"
fi

echo "[+] Done"


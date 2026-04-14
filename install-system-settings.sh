#!/bin/bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$DOTFILES_DIR/shared/etc/"
DEST="/etc"

echo "[+] Installing /etc configuration from $SRC → $DEST"

BACKUP_DIR="$DEST/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "[+] Backup directory: $BACKUP_DIR"

rsync -rvlD \
  --backup \
  --backup-dir="$BACKUP_DIR" \
  --exclude='.gitkeep' \
  "$SRC/" "$DEST/"

PROFILE="${1:-}"
if [ -n "$PROFILE" ]; then
    PROFILE_SRC="$DOTFILES_DIR/$PROFILE/etc/"

    if [ -d "$PROFILE_SRC" ]; then
        echo "[+] Installing profile $PROFILE from $PROFILE_SRC → $DEST"

        rsync -rvlD \
          --backup \
          --backup-dir="$BACKUP_DIR" \
          --exclude='.gitkeep' \
          "$PROFILE_SRC" "$DEST/"
    else
        echo "[!] Profile '$PROFILE' not found at $PROFILE_SRC"
    fi

fi

systemctl daemon-reexec

echo "[+] Regenerating initramfs..."
mkinitcpio -P

echo "[+] Done installing system settings"


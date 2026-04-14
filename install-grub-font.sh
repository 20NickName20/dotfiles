#!/bin/bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[+] Installing /boot/grub/terminus-bold.pf2"

install -Dm644 "$DOTFILES_DIR/shared/boot/grub/terminus-bold.pf2" "/boot/grub/terminus-bold.pf2"

echo "[+] Making grub config..."
grub-mkconfig -o /boot/grub/grub.cfg

echo "[+] Done installing system settings"


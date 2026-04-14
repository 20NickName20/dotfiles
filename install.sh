#!/bin/bash
set -euo pipefail

echo "[+] Confirm sudo..."
sudo -v
( while true; do sudo -v; sleep 60; done ) &
SUDO_KEEPALIVE_PID=$!
echo "[!] Sudo keepalive PID: $SUDO_KEEPALIVE_PID"
trap 'kill "$SUDO_KEEPALIVE_PID" && echo [!] Killed sudo keepalive' EXIT TERM INT

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

PROFILE="${1:-}"
if [ -z "$PROFILE" ]; then
    echo "[!] Provide an installation profile! (pc or laptop)"
    exit 1
fi
if [ ! -d "$PROFILE" ]; then
    echo "$PROFILE does not exist."
    exit 1
fi

echo "[+] Installing packages..."
./install-packages.sh "$PROFILE"

echo "[+] Installing system settings..."
sudo ./install-system-settings.sh "$PROFILE"

echo "[+] Installing grub font..."
sudo ./install-grub-font.sh "$PROFILE"

echo "[+] Installing configs..."
./install-config.sh "$PROFILE"

echo "[+] Installing binaries and scripts..."
./install-bin.sh "$PROFILE"

echo "[+] Enabling services..."
./enable-services.sh "$PROFILE"

echo "[+] Done!"


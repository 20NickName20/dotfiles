#!/bin/bash
set -euo pipefail

echo "[+] Confirm sudo..."
sudo -v
( while true; do sudo -v; sleep 60; done ) &
SUDO_KEEPALIVE_PID=$!
echo "[!] Sudo keepalive PID: $SUDO_KEEPALIVE_PID"
trap 'kill "$SUDO_KEEPALIVE_PID" && echo [!] Killed sudo keepalive' EXIT TERM INT

echo "[+] Removing orphans..."
yay --noconfirm -Yc

echo "[+] Upgrading pacman packages..."
sudo pacman --noconfirm -Syu

echo "[+] Upgrading aur packages..."
yay --noconfirm -Syu

echo "[+] Removing cache..."
yay --noconfirm -Scc

echo "[+] Updating rust"
rustup update

echo "[+] Updating cargo binaries..."
cargo install-update --all

echo "[+] Updating flatpaks..."
flatpak update -y

echo "[+] ----------------- [+]"
echo "[+] All updates done! [+]"
echo "[+] ----------------- [+]"
notify-send "full-upgrade.sh" "System update complete\!"

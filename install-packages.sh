#!/bin/bash
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
   echo "Do NOT run this script as root"
   exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[+] Dotfiles directory: $DOTFILES_DIR"

PROFILE="${1:-}"

sudo pacman -S --needed --noconfirm flatpak base-devel git rustup

# ---- Install yay ----
if ! command -v yay >/dev/null 2>&1; then
    echo "[+] Installing yay..."

    TMP_DIR="/tmp/yay-install-$$"
    rm -rf "$TMP_DIR"
    git clone https://aur.archlinux.org/yay.git "$TMP_DIR"

    pushd "$TMP_DIR" >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null

    rm -rf "$TMP_DIR"

    echo "[+] yay installed"
else
    echo "[+] yay already installed"
fi

echo "[+] Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# ---- Install shared packages ----
SHARED_LIST="$DOTFILES_DIR/shared/package_list.txt"

if [[ -f "$SHARED_LIST" ]]; then
    echo "[+] Installing shared packages from $SHARED_LIST"
    grep -vE '^\s*#|^\s*$' "$SHARED_LIST" | yay -S --needed --noconfirm -
else
    echo "[!] No shared package list found"
fi

# ---- Install profile packages ----
if [[ -n "$PROFILE" ]]; then
    PROFILE_LIST="$DOTFILES_DIR/$PROFILE/package_list.txt"

    if [[ -f "$PROFILE_LIST" ]]; then
        echo "[+] Installing profile packages from $PROFILE_LIST"
        grep -vE '^\s*#|^\s*$' "$PROFILE_LIST" | yay -S --needed --noconfirm -
    else
        echo "[!] Profile package list not found: $PROFILE_LIST"
        exit 1
    fi
fi


# ---- Install Flatpak apps ----
FLATPAK_SHARED_LIST="$DOTFILES_DIR/shared/flatpak_list.txt"

if [[ -f "$FLATPAK_SHARED_LIST" ]]; then
    echo "[+] Installing shared flatpak apps from $FLATPAK_SHARED_LIST"
    grep -vE '^\s*#|^\s*$' "$FLATPAK_SHARED_LIST" | xargs -r flatpak install -y flathub
else
    echo "[!] No shared flatpak list found"
fi

if [[ -n "$PROFILE" ]]; then
    FLATPAK_PROFILE_LIST="$DOTFILES_DIR/$PROFILE/flatpak_list.txt"

    if [[ -f "$FLATPAK_PROFILE_LIST" ]]; then
        echo "[+] Installing profile flatpak apps from $FLATPAK_PROFILE_LIST"
        grep -vE '^\s*#|^\s*$' "$FLATPAK_PROFILE_LIST" | xargs -r flatpak install -y flathub
    else
        echo "[!] No profile flatpak list found (optional)"
    fi
fi

rustup toolchain install stable
rustup default stable
# Install cargo pacakges
cargo install --git https://github.com/20NickName20/clock-tui --branch screensaver-mode clock-tui


echo "[+] Done installing packages"

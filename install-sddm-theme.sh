#!/bin/bash
set -euo pipefail

PROFILE="${1:-}"
if [[ -z "$1" ]]; then
    echo "[!] Specify install profile!"
    exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cat <<EOF > /etc/sddm.conf
[Theme]
    Current=custom-theme
EOF

THEME_DIR="$DOTFILES_DIR/$PROFILE/sddm_theme"
echo $THEME_DIR
if [ -d "$THEME_DIR" ]; then
    rm -r "/usr/share/sddm/themes/custom-theme" || true
    cp -r "$THEME_DIR" "/usr/share/sddm/themes/custom-theme"
else
    echo "[!] Profile $PROFILE doesn't exist!"
    exit 1
fi

echo "[+] Done installing sddm theme"


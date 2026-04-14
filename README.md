# My dotfiles
> [!WARNING]
> This is not meant to be used on distros other than arch.
> Don't expect this to work properly.

This repo has my dotfiles and system configuration.

## Usage:
```bash
# Profile: either "pc" or "laptop"
./insatll.sh <profile>
```

## Scripts
There are several scripts to install different parts of this separately.
- `install.sh`: install everything
- `install-system-settings.sh`: pacman config and other
- `install-grub-font.sh`: install grub font
- `install-packages.sh`: install a lot of packages
- `enable-services.sh`: enable systemd services (both user and system)
- `install-config.sh`: install hyprland config, gtk config and other
- `install-bin.sh`: install custom scripts and binaries to ~/.local/bin


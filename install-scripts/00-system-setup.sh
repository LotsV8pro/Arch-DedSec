#!/bin/bash
# Phase 0: System Setup - enable multilib, keyring, etc.

set -euo pipefail

echo "[00] System Setup..."

# Enable multilib
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    sudo sed -i '/^#\[multilib\]/,+2 s/^#//' /etc/pacman.conf
fi

# Update keyring and system
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm archlinux-keyring

# Install yay if missing
if ! command -v yay &>/dev/null; then
    echo "[00] Installing yay (AUR helper)..."
    cd /tmp
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    cd -
fi

# Enable systemd services
sudo systemctl enable --now NetworkManager 2>/dev/null || true
sudo systemctl enable --now bluetooth 2>/dev/null || true

echo "[00] System setup complete."

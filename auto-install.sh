#!/bin/bash
# DedSec Arch-Hyprland Auto Installer
# Run: bash <(curl -s https://raw.githubusercontent.com/LotsV8pro/Arch-DedSec/main/auto-install.sh)
# Or:  curl -fsSL https://raw.githubusercontent.com/LotsV8pro/Arch-DedSec/main/auto-install.sh | bash

set -euo pipefail

REPO_URL="https://github.com/LotsV8pro/Arch-DedSec"
CLONE_DIR="$HOME/Arch-DedSec"

echo "╔══════════════════════════════════════════════╗"
echo "║  DedSec Arch-Hyprland Auto Installer         ║"
echo "║  Cloning from GitHub...                      ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# Check prerequisites
if ! command -v git &>/dev/null; then
    echo "[!] git is required. Installing..."
    sudo pacman -S --noconfirm git
fi

# Clone repo
if [[ -d "$CLONE_DIR" ]]; then
    echo "[i] Repo already exists at $CLONE_DIR"
    read -p "Pull latest changes? [y/N]: " pull
    if [[ "$pull" == "y" || "$pull" == "Y" ]]; then
        cd "$CLONE_DIR"
        git pull
    fi
else
    git clone "$REPO_URL" "$CLONE_DIR"
fi

cd "$CLONE_DIR"
chmod +x install.sh
./install.sh

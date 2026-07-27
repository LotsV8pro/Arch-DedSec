#!/bin/bash
# Phase 5: SDDM Display Manager

set -euo pipefail

echo "[05] Setting up SDDM..."

sudo pacman -S --needed --noconfirm sddm

# Enable SDDM
sudo systemctl enable sddm

echo "[05] SDDM enabled."
echo "[05] NOTE: DedSec SDDM theme can be installed later with:"
echo "        sudo bash ~/.config/dedsec-apply/sddm-dedsec-install.sh"

#!/bin/bash
# Phase 3: Hyprland core setup and dependencies

set -euo pipefail

echo "[03] Setting up Hyprland..."

# Install Hyprland packages (already in 01-packages.sh, this is for extras)
sudo pacman -S --needed --noconfirm \
    hyprland hyprlock hypridle hyprpolkitagent \
    hyprgraphics hyprlang hyprutils hyprcursor hyprwayland-scanner \
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
    uwsm

# Create essential directories
mkdir -p ~/.config/hypr/{configs,UserConfigs,UserScripts,scripts}
mkdir -p ~/.config/hypr/wallust

# Set up greetd (fallback DM) if SDDM is not chosen
if ! systemctl is-enabled sddm 2>/dev/null; then
    sudo systemctl enable greetd 2>/dev/null || true
fi

echo "[03] Hyprland setup complete."

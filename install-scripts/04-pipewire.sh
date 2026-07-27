#!/bin/bash
# Phase 4: Pipewire Audio Setup

set -euo pipefail

echo "[04] Setting up Pipewire audio..."

sudo pacman -S --needed --noconfirm \
    pipewire pipewire-alsa pipewire-audio pipewire-pulse \
    wireplumber lib32-pipewire

# Remove pulseaudio if present
sudo pacman -Rns --noconfirm pulseaudio pulseaudio-alsa 2>/dev/null || true

# Enable pipewire services
systemctl --user enable --now pipewire.service 2>/dev/null || true
systemctl --user enable --now pipewire-pulse.service 2>/dev/null || true
systemctl --user enable --now wireplumber.service 2>/dev/null || true

echo "[04] Pipewire audio configured."

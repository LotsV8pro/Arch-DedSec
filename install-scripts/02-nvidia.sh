#!/bin/bash
# Phase 2: NVIDIA Driver Setup for RTX 4070

set -euo pipefail

echo "[02] Setting up NVIDIA drivers..."

# Install NVIDIA open drivers
sudo pacman -S --needed --noconfirm \
    nvidia-open-dkms nvidia-utils lib32-nvidia-utils \
    nvidia-settings libva-nvidia-driver egl-wayland

# Blacklist nouveau
if [[ ! -f /etc/modprobe.d/nouveau.conf ]]; then
    echo "blacklist nouveau" | sudo tee /etc/modprobe.d/nouveau.conf
    echo "options nouveau modeset=0" | sudo tee -a /etc/modprobe.d/nouveau.conf
fi

# Regenerate initramfs
sudo mkinitcpio -P

# Environment variables for NVIDIA + Hyprland
cat << 'NVENV' > /tmp/nvidia-env
# NVIDIA + Hyprland environment
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = LIBVA_DRIVER_NAME,nvidia
env = NVD_BACKEND,direct
env = XDG_SESSION_TYPE,wayland
env = WLR_NO_HARDWARE_CURSORS,1
NVENV

echo "[02] NVIDIA drivers configured."
echo "[02] NOTE: Reboot required for NVIDIA drivers to take effect."

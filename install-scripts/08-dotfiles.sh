#!/bin/bash
# Phase 8: Copy DedSec Purple Dotfiles

set -euo pipefail

echo "[08] Installing DedSec purple dotfiles..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/dotfiles"

# Backup existing configs
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

backup_config() {
    local target="$HOME/.config/$1"
    if [[ -e "$target" || -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$1")"
        cp -a "$target" "$BACKUP_DIR/$1"
        rm -rf "$target"
    fi
}

# ── Backup existing configs ──
echo "[08] Backing up existing configs to $BACKUP_DIR"
for dir in hypr kitty ghostty rofi waybar cava swaync wlogout wallust fastfetch fetch; do
    backup_config "$dir"
done
backup_config ".zshrc"

# ── Copy Hyprland configs ──
echo "[08] Copying Hyprland configs..."
cp -a "$DOTFILES_DIR/.config/hypr/." "$HOME/.config/hypr/"

# ── Copy Kitty ──
echo "[08] Copying Kitty configs..."
cp -a "$DOTFILES_DIR/.config/kitty/." "$HOME/.config/kitty/"

# ── Copy Ghostty ──
echo "[08] Copying Ghostty configs..."
cp -a "$DOTFILES_DIR/.config/ghostty/." "$HOME/.config/ghostty/"

# ── Copy Rofi ──
echo "[08] Copying Rofi configs..."
cp -a "$DOTFILES_DIR/.config/rofi/." "$HOME/.config/rofi/"

# ── Copy Waybar ──
echo "[08] Copying Waybar configs..."
cp -a "$DOTFILES_DIR/.config/waybar/." "$HOME/.config/waybar/"

# ── Copy Cava ──
echo "[08] Copying Cava configs..."
cp -a "$DOTFILES_DIR/.config/cava/." "$HOME/.config/cava/"

# ── Copy Swaync ──
echo "[08] Copying Swaync configs..."
cp -a "$DOTFILES_DIR/.config/swaync/." "$HOME/.config/swaync/"

# ── Copy Wlogout ──
echo "[08] Copying Wlogout configs..."
cp -a "$DOTFILES_DIR/.config/wlogout/." "$HOME/.config/wlogout/"

# ── Copy Wallust ──
echo "[08] Copying Wallust configs..."
cp -a "$DOTFILES_DIR/.config/wallust/." "$HOME/.config/wallust/"

# ── Copy Fastfetch ──
echo "[08] Copying Fastfetch configs..."
cp -a "$DOTFILES_DIR/.config/fastfetch/." "$HOME/.config/fastfetch/"

# ── Copy Fetch ──
echo "[08] Copying Fetch configs..."
cp -a "$DOTFILES_DIR/.config/fetch/." "$HOME/.config/fetch/" 2>/dev/null || true

# ── Copy ZSH config ──
echo "[08] Copying ZSH config..."
cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# ── Copy Oh-My-ZSH custom theme ──
echo "[08] Copying DedSec ZSH theme..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM"
cp "$DOTFILES_DIR/.oh-my-zsh/custom/dedsec.zsh-theme" "$ZSH_CUSTOM/dedsec.zsh-theme"

# ── Copy qpwgraph (PipeWire graph) ──
echo "[08] Copying qpwgraph configs..."
mkdir -p "$HOME/.config/rncbc.org"
cp "$DOTFILES_DIR/.config/rncbc.org/qpwgraph.conf" "$HOME/.config/rncbc.org/"

# ── Copy dedsec-apply script ──
echo "[08] Copying dedsec-apply script..."
cp "$DOTFILES_DIR/.config/dedsec-apply.sh" "$HOME/.config/dedsec-apply.sh"
chmod +x "$HOME/.config/dedsec-apply.sh"

# ── Set permissions ──
chmod -R 755 "$HOME/.config/hypr/scripts/" 2>/dev/null || true
chmod -R 755 "$HOME/.config/hypr/UserScripts/" 2>/dev/null || true

echo "[08] DedSec dotfiles installed."
echo "[08] Backup of old configs saved to: $BACKUP_DIR"

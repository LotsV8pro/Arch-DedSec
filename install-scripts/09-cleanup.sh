#!/bin/bash
# Phase 9: Final Cleanup

set -euo pipefail

echo "[09] Running final cleanup..."

# Clean pacman cache (keep last 2 versions)
sudo paccache -rk2 2>/dev/null || true

# Remove orphaned packages
sudo pacman -Rns $(pacman -Qdtq) 2>/dev/null || true

# Clean yay cache
yay -Sc --noconfirm 2>/dev/null || true

# Remove old backups (keep last 5)
BACKUPS=$(ls -dt ~/.config-backup-* 2>/dev/null | tail -n +6)
if [[ -n "$BACKUPS" ]]; then
    echo "$BACKUPS" | xargs rm -rf
fi

# Rebuild font cache
fc-cache -fv 2>/dev/null || true

# Reload Hyprland (if running)
hyprctl reload 2>/dev/null || true

# Restart waybar (if running)
pkill waybar 2>/dev/null || true
nohup waybar &>/dev/null &

echo "[09] Cleanup complete."
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  Installation Complete!                       ║"
echo "║                                               ║"
echo "║  • Reboot to start using Hyprland             ║"
echo "║  • Super+Return opens Kitty terminal          ║"
echo "║  • Super+R opens Rofi                         ║"
echo "║  • Super+E opens Thunar                       ║"
echo "║  • Super+T reloads Hyprland                   ║"
echo "║                                               ║"
echo "║  Post-install:                                ║"
echo "║  • Install SDDM theme:                        ║"
echo "║    sudo bash ~/.config/dedsec-apply.sh        ║"
echo "║  • Set wallpaper:                             ║"
echo "║    hyprctl hyprpaper preload ~/Wallpaper/     ║"
echo "╚══════════════════════════════════════════════╝"

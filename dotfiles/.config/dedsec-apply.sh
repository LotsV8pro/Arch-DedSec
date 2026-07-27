#!/usr/bin/env bash
# D̷E̷D̷S̷E̷C̷ Theme Applier
# Applies all DedSec theme changes

set -euo pipefail

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${GREEN}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║     D̷E̷D̷S̷E̷C̷  T̷H̷E̷M̷E̷  A̷P̷P̷L̷Y̷       ║"
echo "  ║     Watch Dogs / ctOS Style          ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"

# 1. Generate sounds
echo -e "${CYAN}[*]${NC} Generating DedSec sounds..."
bash ~/.config/dedsec-sounds/generate.sh

# 2. Apply Hyprland config
echo -e "${CYAN}[*]${NC} Reloading Hyprland..."
hyprctl reload 2>/dev/null || true

# 3. Restart waybar
echo -e "${CYAN}[*]${NC} Restarting Waybar..."
killall waybar 2>/dev/null || true
sleep 1
waybar &

# 4. Apply swaync
echo -e "${CYAN}[*]${NC} Restarting swaync..."
killall swaync 2>/dev/null || true
sleep 1
swaync &

echo ""
echo -e "${GREEN}[+]${NC} DedSec theme applied!"
echo ""
echo "  Changes applied:"
echo "    - Waybar: purple on dark, rounded modules"
echo "    - Rofi: purple launcher, rounded corners"
echo "    - Cava: purple gradient"
echo "    - Kitty/Ghostty: purple color scheme"
echo "    - Hyprland: purple borders, smooth animations"
echo "    - Hyprlock: purple lock screen"
echo "    - Swaync: purple notification borders"
echo "    - Wallust: forced purple palette"
echo "    - Sounds: terminal beeps"
echo ""
echo "  For SDDM theme, run:"
echo "    sudo ./sddm-dedsec-install.sh"
echo ""

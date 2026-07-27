#!/bin/bash
# ██████╗ ███████╗██╗   ██╗███████╗███╗   ██╗███████╗██████╗
# ██╔══██╗██╔════╝██║   ██║██╔════╝████╗  ██║██╔════╝██╔══██╗
# ██║  ██║█████╗  ██║   ██║█████╗  ██╔██╗ ██║█████╗  ██████╔╝
# ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗
# ██████╔╝███████╗ ╚████╔╝ ███████╗██║ ╚████║███████╗██║  ██║
# ╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
# DedSec Arch-Hyprland Installer
# A fully themed Arch Linux + Hyprland setup with purple DedSec aesthetics
#
# Usage: ./install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

print_banner() {
    echo -e "${MAGENTA}"
    cat << "EOF"

  ██████╗ ███████╗██╗   ██╗███████╗███╗   ██╗███████╗██████╗
  ██╔══██╗██╔════╝██║   ██║██╔════╝████╗  ██║██╔════╝██╔══██╗
  ██║  ██║█████╗  ██║   ██║█████╗  ██╔██╗ ██║█████╗  ██████╔╝
  ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗
  ██████╔╝███████╗ ╚████╔╝ ███████╗██║ ╚████║███████╗██║  ██║
  ╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝

EOF
    echo -e "${NC}"
    echo -e "${CYAN}  Arch Linux + Hyprland | Purple DedSec Theme${NC}"
    echo -e "${CYAN}  For NVIDIA RTX 4070 + i7-13700KF${NC}"
    echo ""
}

print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[i]${NC} $1"
}

check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "Do not run this script as root!"
        echo "  Run as a regular user with sudo privileges."
        exit 1
    fi
}

check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        print_error "This script is for Arch Linux only!"
        exit 1
    fi
}

check_network() {
    if ! ping -c 1 archlinux.org &>/dev/null; then
        print_error "No internet connection detected!"
        exit 1
    fi
    print_status "Internet connection OK"
}

enable_multilib() {
    print_info "Enabling multilib repository..."
    if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
        sudo sed -i '/^#\[multilib\]/,+2 s/^#//' /etc/pacman.conf
        sudo pacman -Sy
    fi
    print_status "Multilib enabled"
}

install_yay() {
    if command -v yay &>/dev/null; then
        print_status "yay is already installed"
    else
        print_info "Installing yay (AUR helper)..."
        cd /tmp
        git clone https://aur.archlinux.org/yay-bin.git
        cd yay-bin
        makepkg -si --noconfirm
        cd "$SCRIPT_DIR"
    fi
}

execute_script() {
    local script="$1"
    print_info "Running: $script"
    if [[ -f "$SCRIPT_DIR/install-scripts/$script" ]]; then
        bash "$SCRIPT_DIR/install-scripts/$script"
    else
        print_error "Script not found: $script"
        exit 1
    fi
}

main() {
    print_banner
    check_root
    check_arch
    check_network

    echo -e "${MAGENTA}The following will be installed:${NC}"
    echo "  • Hyprland (Wayland compositor)"
    echo "  • NVIDIA drivers (open-dkms for RTX 4070)"
    echo "  • Waybar, Rofi, Kitty, Ghostty"
    echo "  • Cava, Swaync, Wlogout"
    echo "  • MangoHud + MangoJuice (gaming overlays)"
    echo "  • Pipewire audio"
    echo "  • SDDM display manager"
    echo "  • ZSH + Oh-My-ZSH with DedSec theme"
    echo "  • All DedSec purple theme dotfiles"
    echo "  • Flatpak support"
    echo ""
    echo -e "${YELLOW}⚠  This will take a while on a fresh install.${NC}"
    echo -e "${YELLOW}⚠  A reboot is required after installation.${NC}"
    echo ""
    read -p "Continue? [y/N]: " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 1: System Preparation${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "00-system-setup.sh"

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 2: Core Packages${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "01-packages.sh"

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 3: Graphics Drivers${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "02-nvidia.sh"

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 4: Hyprland & Desktop${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "03-hyprland.sh"

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 5: Audio${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "04-pipewire.sh"

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 6: Display Manager${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "05-sddm.sh"

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 7: Gaming (MangoHud/Steam/Lutris)${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "06-gaming.sh"

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 8: Shell (ZSH + Oh-My-ZSH)${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "07-zsh.sh"

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 9: DedSec Dotfiles${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "08-dotfiles.sh"

    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  PHASE 10: Final Setup${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════${NC}"
    execute_script "09-cleanup.sh"

    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════${NC}"
    echo -e "${GREEN}  Installation Complete!${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════${NC}"
    echo ""
    echo -e "  ${CYAN}Reboot your system to start using Hyprland.${NC}"
    echo ""
}

main "$@"

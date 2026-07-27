#!/bin/bash
# Phase 6: Gaming - MangoHud, MangoJuice, Steam, Lutris, etc.

set -euo pipefail

echo "[06] Setting up gaming stack..."

# MangoHud + MangoJuice + lib32
sudo pacman -S --needed --noconfirm \
    mangohud lib32-mangohud \
    gamemode lib32-gamemode 2>/dev/null || \
    yay -S --needed --noconfirm mangohud lib32-mangohud gamemode 2>/dev/null || true

yay -S --needed --noconfirm mangojuice 2>/dev/null || true

# Steam + Proton
sudo pacman -S --needed --noconfirm steam steam-devices
yay -S --needed --noconfirm protontricks 2>/dev/null || true

# Lutris
sudo pacman -S --needed --noconfirm lutris
yay -S --needed --noconfirm winetricks 2>/dev/null || true

# Gamescope
sudo pacman -S --needed --noconfirm gamescope

# Vulkan 32-bit
sudo pacman -S --needed --noconfirm \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    vulkan-intel lib32-vulkan-intel

# ProtonPlus (GUI for Proton management)
flatpak install --assumeyes flathub com.vysp3r.ProtonPlus 2>/dev/null || true
flatpak install --assumeyes flathub net.davidotek.pupgui2 2>/dev/null || true

# Wine
yay -S --needed --noconfirm wine winetricks 2>/dev/null || true

# Controller support
sudo pacman -S --needed --noconfirm \
    libratbag piper 2>/dev/null || true

# Create MangoHud config directory
mkdir -p ~/.config/MangoHud

# MangoHud config for DedSec purple theme
cat << 'MANGO' > ~/.config/MangoHud/MangoHud.conf
### DedSec MangoHud Configuration ###

### Display ###
legacy_layout=0
no_display=0
round_corners=10.0
background_alpha=0.6
background_color=0d0a1a

### Position ###
position=top-left
table_columns=4

### Colors ###
text_color=D4A5FF
gpu_color=B44AFF
cpu_color=00D4FF
engine_color=B44AFF
vram_color=FF9F43
ram_color=FF9F43
fsr_color=00E5A0
frametime_color=ff66cc
media_player_color=ff66cc
wine_color=B44AFF
battery_color=00E5A0
io_color=00D4FF
arch_color=B44AFF
swap_color=FF9F43

### Font ###
font_size=24
font_size_text=24
font_size_media_player=24

### FPS ###
fps_color_change=0
fps_color=B44AFF
fps_value=,30,60,90,120,240
fps_color_value=FF9F43,00E5A0,D4A5FF,00D4FF,B44AFF

### GPU ###
gpu_stats
gpu_temp
gpu_power
gpu_name
gpu_mem_temp
gpu_clock

### CPU ###
cpu_stats
cpu_temp
cpu_power
cpu_mhz
core_load
cpu_color=00D4FF

### RAM ###
ram
ram_color=FF9F43
vram
swap

### Disk ###
disk_stats
disk_color=00D4FF

### Network ###
network
network_color=00E5A0

### Other ###
frame_timing
frame_timing_color=ff66cc
engine_version
vulkan_driver
wine

### Media Player ###
media_player
media_player_name=spotify
media_player_color=ff66cc

### IO ###
io_read
io_write
io_color=00D4FF

### Gamepad ###
gamepad_battery_level
MANGO

# DedSec MangoJuice config
mkdir -p ~/.config/MangoJuice 2>/dev/null || true

echo "[06] Gaming stack installed."
echo "[06] MangoHud config: ~/.config/MangoHud/MangoHud.conf"
echo "[06] Use MANGOHUD_CONFIG=1 env var or mangohud command prefix to enable overlay."

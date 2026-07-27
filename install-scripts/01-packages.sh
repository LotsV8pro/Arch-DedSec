#!/bin/bash
# Phase 1: Core Packages - Hyprland ecosystem + essential apps

set -euo pipefail

echo "[01] Installing core packages..."

# ── Hyprland Core ──
HYPR=(
    hyprland hyprlock hypridle hyprpolkitagent
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
    hyprgraphics hyprlang hyprutils hyprcursor
    xdg-user-dirs
)

# ── Graphics / Vulkan ──
GRAPHICS=(
    mesa libva-nvidia-driver vulkan-tools
    vulkan-icd-loader lib32-vulkan-icd-loader
    nvidia-open-dkms nvidia-settings lib32-nvidia-utils
    egl-wayland
)

# ── Waybar / Panels ──
BAR=(
    waybar
)

# ── App Launcher / Menu ──
LAUNCHER=(
    rofi
)

# ── Terminal ──
TERMINAL=(
    kitty
)

# ── File Manager ──
FILEMANAGER=(
    thunar thunar-archive-plugin thunar-volman
    gvfs gvfs-mtp
)

# ── Notification / OSD ──
NOTIFY=(
    swaync
)

# ── Audio ──
AUDIO=(
    pipewire pipewire-alsa pipewire-audio pipewire-pulse
    wireplumber
    pamixer pavucontrol
    playerctl
)

# ── Display Manager ──
DM=(
    sddm
)

# ── Screenshot / Screen Recording ──
SCREENSHOT=(
    grim slurp swappy
    obs-studio obs-studio-plugin-browser obs-pipewire-audio-capture-git
)

# ── Theming / Appearance ──
THEME=(
    kvantum qt5ct qt6ct
    nwg-look nwg-displays
    gtk-engine-murrine
)

# ── Fonts ──
FONTS=(
    noto-fonts noto-fonts-emoji
    ttf-jetbrains-mono ttf-jetbrains-mono-nerd
    ttf-fira-code ttf-fantasque-nerd
    ttf-dejavu ttf-droid ttf-liberation
    ttf-victor-mono otf-font-awesome
    adobe-source-code-pro-fonts
)

# ── System Utils ──
UTILS=(
    fastfetch inxi btop htop
    lsd fzf jq ripgrep
    wget curl git rsync unzip
    brightnessctl
    stow
    base-devel
    pacman-contrib
    sbctl
)

# ── Media ──
MEDIA=(
    mpv mpv-mpris ffmpeg ffmpegthumbnailer
    loupe
    mousepad
)

# ── Misc Desktop ──
MISC=(
    wlogout
    cliphist
    wl-clipboard
    polkit
    power-profiles-daemon
    network-manager-applet
    blueman bluez bluez-utils
    gvfs
    tumbler
    xdg-utils
    catimg
    neovim
)

# ── Gaming Prerequisites ──
GAMING_PRE=(
    gamemode
    lib32-gamemode 2>/dev/null || true
    libratbag
    piper
)

# ── Flatpak ──
FLATPAK=(
    flatpak
)

# Install all package groups
ALL_PACKAGES=("${HYPR[@]}" "${GRAPHICS[@]}" "${BAR[@]}" "${LAUNCHER[@]}" \
    "${TERMINAL[@]}" "${FILEMANAGER[@]}" "${NOTIFY[@]}" "${AUDIO[@]}" \
    "${DM[@]}" "${SCREENSHOT[@]}" "${THEME[@]}" "${FONTS[@]}" \
    "${UTILS[@]}" "${MEDIA[@]}" "${MISC[@]}" "${GAMING_PRE[@]}" "${FLATPAK[@]}")

# Filter out packages that don't exist
VALID_PACKAGES=()
for pkg in "${ALL_PACKAGES[@]}"; do
    if pacman -Si "$pkg" &>/dev/null || yay -Si "$pkg" &>/dev/null; then
        VALID_PACKAGES+=("$pkg")
    fi
done

sudo pacman -S --needed --noconfirm "${VALID_PACKAGES[@]}" 2>/dev/null || true

# Install AUR-only packages via yay
AUR_PACKAGES=(
    zen-browser-bin
    discord
    spotify
    github-cli
    yay-bin
    linux-wallpaperengine-bin
    cava
    deepcool-digital-linux-git
    openrgb
    vial-appimage
    noise-suppression-for-voice
    quickshell
    zram-generator
)

yay -S --needed --noconfirm "${AUR_PACKAGES[@]}" 2>/dev/null || true

# Flatpak setup
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --assumeyes flathub com.vysp3r.ProtonPlus net.davidotek.pupgui2 2>/dev/null || true

echo "[01] Core packages installed."

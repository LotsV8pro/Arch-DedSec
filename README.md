# Arch DedSec

> Arch Linux + Hyprland — Full purple DedSec desktop, from minimal install.

![Hyprland](https://img.shields.io/badge/Hyperland-purple?style=flat-square&logo=hyprland)
![Arch](https://img.shields.io/badge/Arch%20Linux-blue?style=flat-square&logo=archlinux)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

## What you get

One script installs a complete desktop from a minimal Arch server install:

- **Hyprland** — Wayland compositor with animations, blur, shadows
- **Waybar** — 50+ themes (pill, glass, minimal, wallust, catppuccin...)
- **Rofi** — App launcher with custom DedSec theme
- **Kitty** — GPU-accelerated terminal
- **PipeWire** — Full audio stack
- **SDDM** — Display manager
- **Steam + MangoHud** — Gaming ready (no individual games bundled)
- **ZSH + Oh-My-ZSH** — Shell with autosuggestions & syntax highlighting
- **DedSec Purple Theme** — Monochrome light purple palette, custom animations, lock screen
- **50+ Waybar layouts** — TOP, BOT, LEFT, RIGHT, glass, vertical...
- **Wallpaper system** — Folder-based browser with swww transitions, effects, randomizer
- **Preset manager** — Save/load full desktop themes (palette + waybar + wallpaper + decorations)
- **ASUS ROG Raikiri** controller support — Guide button launches Steam Big Picture

## Requirements

- Arch Linux (minimal install, only base + linux + linux-firmware)
- Internet connection
- sudo privileges
- NVIDIA RTX GPU (optimized for 4070, works with others)

## Install

Boot into a minimal Arch install (no desktop, just TTY):

```bash
# 1. Get the essentials
pacman -S --needed git
git clone https://github.com/LotsV8pro/Arch-DedSec.git
cd Arch-DedSec

# 2. Run the installer
chmod +x install.sh
./install.sh

# 3. Reboot
sudo reboot
```

Select **Hyprland** in SDDM and log in.

## What gets installed

<details>
<summary><b>Core Packages (pacman)</b></summary>

| Category | Packages |
|----------|----------|
| **Hyprland** | hyprland, hyprlock, hypridle, hyprpolkitagent, hyprgraphics, hyprlang, hyprutils, hyprcursor, hyprtoolkit, xdg-desktop-portal-hyprland |
| **Graphics** | mesa, nvidia-open-dkms, nvidia-utils, libva-nvidia-driver, vulkan-icd-loader, egl-wayland |
| **Waybar** | waybar |
| **Launcher** | rofi |
| **Terminal** | kitty, kitty-shell-integration |
| **File Manager** | thunar, thunar-archive-plugin, thunar-volman, gvfs |
| **Audio** | pipewire, pipewire-alsa, pipewire-pulse, wireplumber, pamixer, pavucontrol, playerctl |
| **Display** | sddm |
| **Screenshot** | grim, slurp, swappy, obs-studio |
| **Theming** | kvantum, qt5ct, qt6ct, nwg-look, nwg-displays |
| **Fonts** | noto-fonts, noto-fonts-emoji, ttf-jetbrains-mono-nerd, ttf-fira-code, otf-font-awesome |
| **Utils** | fastfetch, btop, lsd, fzf, jq, ripgrep, neovim, stow, unzip |
| **Media** | mpv, ffmpeg, loupe, mousepad |
| **Bluetooth** | blueman, bluez |
| **Network** | networkmanager, network-manager-applet |
| **Desktop** | wlogout, cliphist, wl-clipboard, polkit, swaync |
| **Gaming** | steam, gamemode, gamescope, mangohud, lutris, wine |
| **Dev** | cmake, ninja, meson, python, deno |

</details>

<details>
<summary><b>AUR Packages (yay)</b></summary>

- `zen-browser-bin` — Privacy browser
- `discord` — Chat
- `spotify` — Music
- `github-cli` — GitHub CLI
- `linux-wallpaperengine-bin` — Animated wallpapers
- `cava` — Audio visualizer
- `noise-suppression-for-voice` — RNNoise
- `deepcool-digital-linux-git` — DeepCool controller
- `arctis-sound-manager` — SteelSeries audio
- `quickshell` — Quickshell overview
- `zram-generator` — ZRAM swap

</details>

## Keybinds

| Key | Action |
|-----|--------|
| `SUPER + H` | Keybind hints |
| `SUPER + Return` | Terminal (Kitty) |
| `SUPER + D` | App launcher (Rofi) |
| `SUPER + W` | Wallpaper picker (with folders) |
| `SUPER + P` | Palette color editor |
| `SUPER + CTRL + P` | Preset manager (save/load themes) |
| `SUPER + E` | File manager |
| `SUPER + B` | Browser |
| `SUPER + S` | Web search |
| `SUPER + N` | Night mode (Hyprsunset) |
| `SUPER + T` | Reload config |
| `SUPER + SHIFT + Q` | Kill window |
| `SUPER + A` | Overview |
| `CTRL + ALT + L` | Lock screen |
| `CTRL + ALT + P` | Power menu (Wlogout) |

Full keybind list: press `SUPER + H` after install.

## Theming

### Palette Editor (`SUPER + P`)

Pre-built palettes: Monochrome (light purple), Solarized, Catppuccin Mocha, Tokyo Night, Nord, Dracula, Everforest, Rose Pine, Gruvbox, Obsidian, and more.

### Preset Manager (`SUPER + CTRL + P`)

Save your entire desktop setup (palette + waybar style + layout + wallpaper + decorations) as a named preset. Load it back anytime.

### Waybar Themes (`SUPER + CTRL + B`)

50+ CSS themes including:
- Pill, Glass, Minimal, Catppuccin, Wallust
- Vertical, Horizontal, Top, Bottom, Left, Right
- Dynamic Island inspired, DedSec branded

## Structure

```
~/.config/hypr/
├── hyprland.lua           # Main config (Lua)
├── hyprland.conf          # Main config (legacy .conf)
├── configs/               # Default configs
├── UserConfigs/           # User overrides
├── scripts/               # 57 scripts
├── UserScripts/           # User scripts
├── animations/            # 16 animation presets
└── wallust/               # Wallust colors

~/.config/waybar/
├── config                 # Active layout
├── configs/               # 40+ layout variants
├── style/                 # 50+ CSS themes
└── Modules*/              # Module definitions

~/.config/rofi/
├── config*.rasi           # Rofi configs per use
├── themes/                # DedSec themes
└── wallust/               # Wallust integration

~/.config/dedsec-palette/
├── colors.conf            # Active palette
├── palette-menu.sh        # Palette editor
├── apply-colors.sh        # Apply palette to everything
└── presets/               # Saved presets
```

## NVIDIA Setup

The installer configures:
- `nvidia-open-dkms` with DKMS
- `nvidia-persistenced` service
- `LIBVA_DRIVER_NAME=nvidia` env
- `__GLX_VENDOR_LIBRARY_NAME=nvidia` env
- `NVD_BACKEND=direct` for hardware decoding
- mkinitcpio with nvidia modules

## Updating

```bash
cd ~/Arch-DedSec
git pull
./install.sh
```

Existing configs are backed up to `~/.config/dotfiles-backup/`.

## License

MIT — Do whatever you want.

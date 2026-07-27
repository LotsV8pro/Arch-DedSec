# Arch-DedSec

A fully themed Arch Linux + Hyprland installer with **purple DedSec (ctOS) aesthetics**. Installs everything from a fresh Arch setup — NVIDIA drivers, Hyprland, all desktop apps, and a complete purple-themed configuration.

Based on the original [JaKooLit/Arch-Hyprland](https://github.com/JaKooLit/Arch-Hyprland) — reimagined with a cyberpunk purple theme and optimized for NVIDIA RTX 4070 systems.

## What Gets Installed

| Category | Packages |
|----------|----------|
| **Desktop** | Hyprland, Waybar, Rofi, Kitty, Ghostty, Swaync, Wlogout |
| **Graphics** | NVIDIA open-dkms, Vulkan, EGL, PipeWire |
| **Audio** | PipeWire, WirePlumber, Pamixer, Pavucontrol, Playerctl |
| **File Manager** | Thunar, GVFS, SDDM display manager |
| **Gaming** | Steam, Lutris, MangoHud, MangoJuice, Gamescope, Wine, ProtonPlus |
| **Utilities** | Fastfetch, Btop, FZF, Ripgrep, Neovim, Git, Make, base-devel |
| **Fonts** | JetBrains Mono Nerd, Fantasque Nerd, Noto, Fira Code, Victor Mono |
| **Themes** | Kvantum, Qt5/6ct, nwg-look, GTK |
| **Shell** | ZSH + Oh-My-ZSH with DedSec theme |
| **AUR** | zen-browser, Discord, Spotify, GitHub CLI, OpenRGB, Quickshell |

## Quick Install

```bash
bash <(curl -s https://raw.githubusercontent.com/LotsV8pro/Arch-DedSec/main/auto-install.sh)
```

## Manual Install

```bash
git clone https://github.com/LotsV8pro/Arch-DedSec.git
cd Arch-DedSec
chmod +x install.sh
./install.sh
```

## Keybinds

| Key | Action |
|-----|--------|
| `Super + Return` | Kitty terminal |
| `Super + R` | Rofi launcher |
| `Super + E` | Thunar file manager |
| `Super + T` | Reload Hyprland |
| `Super + Shift + E` | Quick settings |
| `Super + Q` | Close window |
| `Super + L` | Hyprlock |
| `Super + P` | Pseudo tiling |
| `Super + J` | Toggle split |
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |
| `Super + D` | Toggle dwindle |

## Theme

The purple DedSec theme applies to:
- **Waybar** — dark top/bottom bars with purple accents
- **Rofi** — centered launcher with purple borders
- **Kitty / Ghostty** — purple background, colored tabs
- **Cava** — purple gradient audio visualizer
- **Hyprland** — purple borders, smooth animations
- **Swaync** — purple notification cards
- **Hyprlock** — purple lock screen
- **ZSH prompt** — `λ` in mint green, directory in purple

## Repository Structure

```
Arch-DedSec/
├── install.sh              # Main installer
├── auto-install.sh         # curl one-liner
├── README.md
├── LICENSE
├── assets/
│   └── images/             # Screenshots
├── dotfiles/               # All config files
│   ├── .config/
│   │   ├── hypr/           # Hyprland configs
│   │   ├── waybar/         # Waybar + presets
│   │   ├── rofi/           # Rofi themes
│   │   ├── kitty/          # Kitty config
│   │   ├── ghostty/        # Ghostty config
│   │   ├── cava/           # Cava config
│   │   ├── swaync/         # Swaync notifications
│   │   ├── wlogout/        # Logout menu
│   │   ├── wallust/        # Wallust config
│   │   ├── fastfetch/      # Fastfetch config
│   │   ├── fetch/          # Fetch config
│   │   └── dedsec-apply.sh # Theme re-apply script
│   ├── .zshrc
│   └── .oh-my-zsh/
│       └── custom/
│           └── dedsec.zsh-theme
└── install-scripts/
    ├── 00-system-setup.sh  # multilib, yay, keyring
    ├── 01-packages.sh      # all packages
    ├── 02-nvidia.sh        # NVIDIA RTX drivers
    ├── 03-hyprland.sh      # Hyprland core
    ├── 04-pipewire.sh      # Audio
    ├── 05-sddm.sh          # Display manager
    ├── 06-gaming.sh        # MangoHud, Steam, Lutris
    ├── 07-zsh.sh           # ZSH + plugins
    ├── 08-dotfiles.sh      # Copy configs
    └── 09-cleanup.sh       # Final cleanup
```

## Requirements

- Fresh Arch Linux install (no DE/WM)
- Internet connection
- User with sudo privileges
- NVIDIA GPU (RTX 4070 optimized, works with any NVIDIA)

## Post-Install

After reboot:
- Install the SDDM DedSec theme: `sudo bash ~/.config/dedsec-apply.sh`
- Set your wallpaper: `hyprctl hyprpaper preload ~/Wallpaper/name.png`

## License

MIT

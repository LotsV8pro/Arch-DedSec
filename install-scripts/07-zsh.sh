#!/bin/bash
# Phase 7: ZSH + Oh-My-ZSH with DedSec theme

set -euo pipefail

echo "[07] Setting up ZSH..."

# Install ZSH
sudo pacman -S --needed --noconfirm zsh zsh-completions

# Install Oh-My-ZSH
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "[07] Installing Oh-My-ZSH..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install ZSH plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# zsh-autosuggestions
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Change default shell
if [[ "$SHELL" != "$(which zsh)" ]]; then
    echo "[07] Changing default shell to zsh..."
    chsh -s "$(which zsh)"
fi

echo "[07] ZSH setup complete."

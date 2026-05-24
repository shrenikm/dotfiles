#!/bin/bash

# Setup script for mpv.
# Installs mpv via apt and symlinks mpv.conf into ~/.config/mpv/.
# Idempotent: safe to re-run on an already-configured system.
# ------------------------------------------------

set -u

# Defining colors
# ------------------------------------------------
RED='\033[0;31m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

link_if_missing() {
    local source="$1"
    local dest="$2"
    local label="$3"

    if [ -L "$dest" ]; then
        echo "Symlink already exists for $label. Replacement must be done manually."
    elif [ -e "$dest" ]; then
        echo -e "${RED}$dest already exists and is not a symlink. Skipping.${NO_COLOR}"
    else
        echo "Creating symlink for $label ..."
        ln -s "$source" "$dest"
        echo -e "${CYAN}Linked $label -> $dest${NO_COLOR}"
    fi
}

# Install mpv
# ------------------------------------------------
if command -v mpv &> /dev/null; then
    echo "mpv is already installed ($(mpv --version | head -n 1))."
else
    echo "mpv is not installed. Installing ..."
    sudo apt update
    sudo apt install -y mpv
fi

# Symlink mpv.conf
# ------------------------------------------------
MPV_CONFIG_DIR="$HOME/.config/mpv"
mkdir -p "$MPV_CONFIG_DIR"
link_if_missing "$SCRIPT_DIR/mpv.conf" "$MPV_CONFIG_DIR/mpv.conf" "mpv.conf"

echo -e "\nMpv dotfiles setup complete."

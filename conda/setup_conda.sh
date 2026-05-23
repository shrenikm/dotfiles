#!/bin/bash

# Setup script for Miniconda.
# Installs Miniconda to $HOME/miniconda3 (user-local, no sudo, works on WSL).
# Does NOT run `conda init` — the zsh hook block lives in zsh/.zshrc.
# Symlinks .condarc to ~/.condarc (auto_activate_base + changeps1 settings
# that the zsh prompt logic depends on).
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

MINICONDA_PREFIX="$HOME/miniconda3"
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"

# Install miniconda
# ------------------------------------------------
if [ -d "$MINICONDA_PREFIX" ]; then
    echo "Miniconda is already installed at $MINICONDA_PREFIX."
else
    if [ -d "/opt/miniconda3" ]; then
        echo -e "${YELLOW}A legacy Miniconda install exists at /opt/miniconda3.${NO_COLOR}"
        echo -e "${YELLOW}Installing a fresh copy to $MINICONDA_PREFIX. See the README for migration steps.${NO_COLOR}"
    fi
    echo "Downloading Miniconda installer ..."
    TMP_INSTALLER=$(mktemp --suffix=.sh)
    if ! curl -fL "$MINICONDA_URL" -o "$TMP_INSTALLER"; then
        echo -e "${RED}Failed to download Miniconda installer from $MINICONDA_URL${NO_COLOR}"
        rm -f "$TMP_INSTALLER"
        exit 1
    fi
    # -b: batch (no prompts, auto-accept license). -p: install prefix.
    if ! bash "$TMP_INSTALLER" -b -p "$MINICONDA_PREFIX"; then
        echo -e "${RED}Miniconda installer failed.${NO_COLOR}"
        rm -f "$TMP_INSTALLER"
        exit 1
    fi
    rm -f "$TMP_INSTALLER"
    echo -e "${CYAN}Miniconda installed at $MINICONDA_PREFIX.${NO_COLOR}"
fi

# Symlink .condarc
# ------------------------------------------------
link_if_missing "$SCRIPT_DIR/.condarc" "$HOME/.condarc" ".condarc"

echo -e "\nConda dotfiles setup complete."
echo -e "${CYAN}The zsh conda init block in zsh/.zshrc sources $MINICONDA_PREFIX on shell startup.${NO_COLOR}"

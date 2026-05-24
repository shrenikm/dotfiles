#!/bin/bash

# Setup script for uv.
# Installs uv via the official Astral installer into $HOME/.local/bin, which
# zsh/.zshrc already adds to PATH. Avoids the snap package (unavailable/fragile
# on WSL) so a single global uv is usable across all conda envs.
# INSTALLER_NO_MODIFY_PATH keeps the installer from editing the managed .zshrc
# symlink, since PATH is already handled there.
# Idempotent: safe to re-run on an already-configured system.
# ------------------------------------------------

set -u

# Defining colors
# ------------------------------------------------
RED='\033[0;31m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

UV_INSTALL_URL="https://astral.sh/uv/install.sh"

# Install uv
# ------------------------------------------------
if command -v uv &> /dev/null; then
    echo "uv is already installed ($(uv --version))."
else
    echo "uv is not installed. Installing ..."
    if ! curl -LsSf "$UV_INSTALL_URL" | env INSTALLER_NO_MODIFY_PATH=1 sh; then
        echo -e "${RED}Failed to install uv from $UV_INSTALL_URL${NO_COLOR}"
        exit 1
    fi
    echo -e "${CYAN}uv installed to \$HOME/.local/bin.${NO_COLOR}"
fi

echo -e "\nUv dotfiles setup complete."
echo -e "${CYAN}Restart your shell (or 'exec zsh') so uv resolves on PATH.${NO_COLOR}"

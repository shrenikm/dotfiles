#!/bin/bash

# Setup script for Node.js via nvm.
# Installs the pinned nvm into $HOME/.nvm, then installs the latest LTS Node and
# sets it as the default. The nvm shell hook lives in zsh/.zshrc (Node config
# block), so the installer is told to leave shell profiles alone (PROFILE set
# to /dev/null) to avoid editing the managed .zshrc symlink.
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
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Pinned versions live in the root-level `versions` file. Bump NVM_VERSION
# there and re-run this script to upgrade nvm itself.
VERSIONS_FILE="$REPO_ROOT/versions"
if [ ! -f "$VERSIONS_FILE" ]; then
    echo -e "${RED}Missing versions file at $VERSIONS_FILE${NO_COLOR}"
    exit 1
fi
# shellcheck source=../versions
. "$VERSIONS_FILE"
export NVM_DIR="$HOME/.nvm"
NVM_INSTALL_URL="https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh"

# Install nvm
# ------------------------------------------------
if [ -s "$NVM_DIR/nvm.sh" ]; then
    echo "nvm is already installed at $NVM_DIR."
else
    echo "nvm is not installed. Installing v${NVM_VERSION} ..."
    # PROFILE=/dev/null stops the installer from appending its source block to a
    # shell profile; zsh/.zshrc already carries that block.
    if ! curl -fsSL "$NVM_INSTALL_URL" | PROFILE=/dev/null bash; then
        echo -e "${RED}Failed to install nvm from $NVM_INSTALL_URL${NO_COLOR}"
        exit 1
    fi
fi

# Load nvm into this shell so the node install below can run.
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    echo -e "${RED}nvm.sh not found at $NVM_DIR after install.${NO_COLOR}"
    exit 1
fi
# shellcheck source=/dev/null
. "$NVM_DIR/nvm.sh"

# Install the latest LTS Node
# ------------------------------------------------
if nvm ls --no-colors 2>/dev/null | grep -q "lts/"; then
    echo "An LTS Node is already installed ($(node --version 2>/dev/null))."
else
    echo "Installing the latest LTS Node ..."
    nvm install --lts
    nvm alias default 'lts/*'
fi

echo -e "\nNode dotfiles setup complete."
echo -e "${CYAN}Restart your shell (or 'exec zsh') so node/npm resolve via nvm.${NO_COLOR}"

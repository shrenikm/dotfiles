#!/bin/bash

# Setup script for the GitHub CLI (gh).
# Installs gh from GitHub's official apt repository rather than plain apt: the
# default Ubuntu/Debian repos either lack gh or ship a stale version on the
# distros this repo targets (notably WSL). The official repo keeps gh
# apt-managed and auto-updating, so there is no version to pin in `versions`.
# Idempotent: safe to re-run on an already-configured system.
# ------------------------------------------------

set -u

# Defining colors
# ------------------------------------------------
RED='\033[0;31m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

GH_KEYRING="/etc/apt/keyrings/githubcli-archive-keyring.gpg"
GH_SOURCES="/etc/apt/sources.list.d/github-cli.list"
GH_KEY_URL="https://cli.github.com/packages/githubcli-archive-keyring.gpg"

# Install gh
# ------------------------------------------------
if command -v gh &> /dev/null; then
    echo "gh is already installed ($(gh --version | head -n 1))."
else
    echo "gh is not installed. Installing from GitHub's apt repository ..."

    # wget is required to fetch the signing key.
    if ! command -v wget &> /dev/null; then
        echo "wget is required but missing. Installing ..."
        sudo apt update
        sudo apt install -y wget
    fi

    sudo mkdir -p -m 755 /etc/apt/keyrings
    wget -qO- "$GH_KEY_URL" | sudo tee "$GH_KEYRING" > /dev/null
    sudo chmod go+r "$GH_KEYRING"
    echo "deb [arch=$(dpkg --print-architecture) signed-by=$GH_KEYRING] https://cli.github.com/packages stable main" \
        | sudo tee "$GH_SOURCES" > /dev/null

    sudo apt update
    if ! sudo apt install -y gh; then
        echo -e "${RED}Failed to install gh.${NO_COLOR}"
        exit 1
    fi
    echo -e "${CYAN}gh installed.${NO_COLOR}"
fi

echo -e "\nGh dotfiles setup complete."
echo -e "${CYAN}Run 'gh auth login' to authenticate with GitHub.${NO_COLOR}"

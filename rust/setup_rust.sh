#!/bin/bash

# Setup script for the Rust toolchain and cargo-installed CLI tools.
# Installs rustup (rustc + cargo) via the official installer into $HOME/.cargo,
# which zsh/.zshrc already adds to PATH. Removes any apt-managed rustc/cargo
# first, since those live in /usr/bin (earlier on PATH) and would shadow the
# rustup binaries with a stale version. Each cargo package (e.g. grip-grab,
# which provides 'gg' for lvim/pymple) is gated behind its own y/n prompt.
# Idempotent: safe to re-run on an already-configured system.
# ------------------------------------------------

set -u

# Defining colors
# ------------------------------------------------
RED='\033[0;31m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

RUSTUP_INSTALL_URL="https://sh.rustup.rs"

# Prompt for a yes/no answer; re-asks on unrecognized input.
prompt_yes_no() {
    local question="$1"
    local answer
    while true; do
        read -r -p "$(echo -e "${CYAN}${question} (y/n): ${NO_COLOR}")" answer
        case "$answer" in
            [yY]|[yY][eE][sS]) return 0 ;;
            [nN]|[nN][oO]) return 1 ;;
            *) echo "Please answer y or n." ;;
        esac
    done
}

# Install a cargo crate gated on a y/n prompt. Skips when the crate's binary is
# already on PATH so re-runs are no-ops.
cargo_install_if_wanted() {
    local crate="$1"
    local bin="$2"

    echo
    if prompt_yes_no "Install $crate (provides '$bin') via cargo?"; then
        if command -v "$bin" &> /dev/null; then
            echo "$crate is already installed ($("$bin" --version 2>/dev/null | head -1))."
        else
            echo "Installing $crate ..."
            cargo install "$crate"
        fi
    else
        echo "Skipping $crate."
    fi
}

# Remove apt-managed rust
# ------------------------------------------------
if dpkg -s rustc &> /dev/null || dpkg -s cargo &> /dev/null; then
    echo -e "${YELLOW}Removing apt-managed rustc/cargo so they don't shadow rustup.${NO_COLOR}"
    sudo apt remove -y rustc cargo
fi

# Install rustup toolchain
# ------------------------------------------------
if command -v rustup &> /dev/null; then
    echo "rustup is already installed ($(rustup --version))."
else
    echo "rustup is not installed. Installing ..."
    # -y runs the installer non-interactively with stable defaults.
    # --no-modify-path leaves shell profiles alone since zsh/.zshrc owns PATH.
    if ! curl --proto '=https' --tlsv1.2 -sSf "$RUSTUP_INSTALL_URL" | sh -s -- -y --no-modify-path; then
        echo -e "${RED}rustup installation failed.${NO_COLOR}"
        exit 1
    fi
fi

# Make cargo available for the cargo-install steps below within this run.
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Cargo-installed CLI tools
# ------------------------------------------------
cargo_install_if_wanted "grip-grab" "gg"

echo -e "\nRust dotfiles setup complete."
echo -e "${CYAN}Restart your shell (or 'exec zsh') so the toolchain resolves on PATH.${NO_COLOR}"

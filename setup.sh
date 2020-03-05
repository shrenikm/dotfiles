#!/bin/bash

# Initial checks
# ------------------------------------------------

# Checking if this script is run from the repo
VERSION_FILE=details.sh
if ! [ -f "$VERSION_FILE" ]; then
    echo 'This executable must be run from the main repo directory.'
    exit 0
fi

# Neovim setup
# ------------------------------------------------

echo 'Setting up neovim ...'
if ! [ -x "$(command -v nvim)" ]; then
    echo 'Neovim is not installed. Installing ...'
    sudo apt install neovim
    sudo apt install python-neovim
    sudo apt install python3-neovim
else
    echo 'Neovim is installed'
    nvim --version | head  -n 1
fi

# Directory to house the nvim config files
mkdir -p ~/.config/nvim

# Path for vimrc (init.vim) symlink
VIMRC_SYSTEM=~/.config/nvim/init.vim
# Path for the actual vimrc (init.vim) in the repo
VIMRC_REPO=$(pwd)/neovim/init.vim

# Checking if the symlink exists and creating one if it doesn't
if [ -L "$VIMRC_SYSTEM" ]; then
    echo 'Neovim config file symlink already exists. Replacement must be done manually.'
else
    echo 'Neovim config symlink does not exist. Creating one ...'
    ln -s $VIMRC_REPO $VIMRC_SYSTEM
fi

echo -e '\n'

# Tmux setup
# ------------------------------------------------

echo 'Setting up tmux ...'
if ! [ -x "$(command -v tmux)" ]; then
    echo 'Tmux is not installed. Installing ...'
    sudo apt install tmux
else
    echo 'Tmux is installed'
    tmux -V | head -n 1
fi

# Directory to house the tmux config files
mkdir -p ~/.tmux

# Path for the tmux config symlinks
TMUX_SYSTEM_CONF=~/.tmux.conf
TMUX_SYSTEM_CONF_LOCAL=~/.tmux.conf.local
# Path for the actual tmux config files in the repo
TMUX_REPO_CONF=$(pwd)/.tmux/.tmux.conf
TMUX_REPO_CONF_LOCAL=$(pwd)/.tmux/.tmux.conf.local

# Checking if the symlinks exist and creating them if they don't
if [ -L "$TMUX_SYSTEM_CONF" ]; then
    echo 'Tmux main config file symlink already exists. Replacement must be done manually.'
else
    echo 'Tmux main config symlink does not exist. Creating one ...'
    ln -s $TMUX_REPO_CONF $TMUX_SYSTEM_CONF
fi

if [ -L "$TMUX_SYSTEM_CONF_LOCAL" ]; then
    echo 'Tmux main config file symlink already exists. Replacement must be done manually.'
else
    echo 'Tmux main config symlink does not exist. Creating one ...'
    ln -s $TMUX_REPO_CONF_LOCAL $TMUX_SYSTEM_CONF_LOCAL
fi


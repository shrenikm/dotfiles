#!/bin/bash

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
mkdir -p ~/.config/nvim
#ln -s -f init.vim ~/.config/nvim/init.vim

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
mkdir -p ~/.tmux
#ln -s -f .tmux/.tmux.conf ~/.tmux.conf
#ln -s -f .tmux/.tmux.conf.local ~/.tmux.conf.local


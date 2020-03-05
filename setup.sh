#!/bin/bash

# Neovim setup
# ------------------------------------------------

mkdir -p ~/.config/nvim
ln -s -f init.vim ~/.config/nvim/init.vim

# Tmux setup
# ------------------------------------------------
mkdir -p ~/.tmux
ln -s -f .tmux/.tmux.conf ~/.tmux.conf
ln -s -f .tmux/.tmux.conf.local ~/.tmux.conf.local


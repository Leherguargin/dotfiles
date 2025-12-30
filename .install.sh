#!/bin/bash

sudo apt update
sudo apt full-upgrade -y

# utils
sudo apt install man info vim curl wget tar gzip git stow nano tree 

# zsh
sudo apt install -y zsh

# tmux
#TODO sudo apt install byobu -y

# net-tools
#TODO

# neovim
# TODO

# c/cpp development tools
# TODO sudo apt install binutils clang # change test and dokoncz

# sdkman
#TODO


# ts/js
#TODO

# git config if you want (overwritting one from stow dotfiles)
#git config --global user.email "maciejleszczynski1997@gmail.com"
#git config --global user.name "Maciej Leszczynski"
#git config --global init.defaultBranch main

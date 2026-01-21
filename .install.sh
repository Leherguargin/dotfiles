#!/bin/bash

sudo apt update
sudo apt full-upgrade -y

# utils
sudo apt install man info curl wget tar gzip unzip zip git stow nano tree 
#sudo apt install fzf # what is that? 
#sudo apt install tee # what is that?

if [[ ! $(which zsh) ]]; then
	sudo apt install -y zsh # install zsh
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # install oh-my-zsh

#TODO sudo apt install -y byobu # for now I dont use byobu
if [[ ! $(which tmux) ]]; then
	sudo apt install -y tmux
fi

if [[ ! $(which nvim) ]]; then
	sudo apt install -y neovim
fi

# net-tools
#TODO


# c/cpp development tools
# TODO sudo apt install binutils clang # change test and dokoncz

# sdkman
if [[ $(which sdk) ]]; then
	curl -s "https://get.sdkman.io" | bash
fi

# ts/js
#TODO

# git config if you want (overwritting one from stow dotfiles)
if [[ -f ~/.gitconfig ]]; then
	git config --global user.email "maciejleszczynski1997@gmail.com"
	git config --global user.name "Maciej Leszczynski"
	git config --global init.defaultBranch main
fi


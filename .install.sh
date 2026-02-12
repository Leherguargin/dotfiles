#!/bin/bash
set -euo pipefail # stop script when error occured, no undeclared variables, propagate errors in pipes

sudo apt update
sudo apt full-upgrade -y

# utils
sudo apt install -y man info curl wget tar gzip unzip zip git stow nano tree make gcc ripgrep xclip gettext-base
#sudo apt install fzf # what is that? 
#sudo apt install tee # what is that?


if ! command -v zsh >/dev/null 2>&1; then
	sudo apt install -y zsh # install zsh
fi

if [[ ! -d ~/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # install oh-my-zsh
fi


#TODO sudo apt install -y byobu # for now I dont use byobu
if ! command -v tmux >/dev/null 2>&1; then
	sudo apt install -y tmux
fi


if ! command -v nvim >/dev/null 2>&1; then
	cd ~
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim-linux-x86_64
	sudo mkdir -p /opt/nvim-linux-x86_64
	sudo chmod a+rX /opt/nvim-linux-x86_64
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin
	sudo rm -rf nvim-linux-x86_64.tar.gz
fi


if ! command -v vim >/dev/null 2>&1; then
	sudo apt install -y vim
fi

# net-tools
#TODO


# c/cpp development tools
# TODO sudo apt install binutils clang # change test and dokoncz

# avr utils
if ! command -v avr-gcc >/dev/null 2>&1; then
    sudo apt install -y gcc-avr
    sudo apt install -y avr-libc binutils-avr
fi


# sdkman
set +u
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
if ! command -v sdk >/dev/null 2>&1; then
	curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
else
    sdk selfupdate force
    sdk update
fi
set -u


# ts/js
#TODO


# git config if you want (overwritting one from stow dotfiles)
if [[ -f ~/.gitconfig ]]; then
	git config --global user.email "maciejleszczynski1997@gmail.com"
	git config --global user.name "Maciej Leszczynski"
	git config --global init.defaultBranch main
fi

sudo apt autoremove -y


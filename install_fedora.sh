#!/bin/bash

set -euo pipefail # stop script when error occured, no undeclared variables, propagate errors in pipes


echo -e "\e[35m -------------------- update and upgrade -------------------- \e[0m" # print in magenta
sudo dnf upgrade --refresh
sudo dnf clean all


echo -e "\e[35m --------------------  install utils -------------------- \e[0m"
sudo dnf install -y man info curl wget tar gzip unzip zip git stow nano tree make gcc ripgrep xclip ca-certificates
#sudo apt install fzf # what is that?
#sudo apt install tee # what is that?


echo -e "\e[35m -------------------- backup old dotfiles and stow new dotfiles  -------------------- \e[0m"
FILES=(
    "$HOME/.zshrc"
    "$HOME/.vimrc"
    "$HOME/.tmux.conf"
    "$HOME/.bashrc"
    "$HOME/.bash_aliases"
    "$HOME/.gitconfig"
    "$HOME/.config/nvim-astrovim"
    "$HOME/.config/nvim-lazyvim"
    "$HOME/.config/nvim-nvchad"
)

for file in "${FILES[@]}"; do
    if [[ -e "$file" ]]; then
        bak="${file}.bak"

        # If .bak already exists, append timestamp
        if [ -e "$bak" ]; then
            timestamp=$(date +%Y%m%d_%H%M%S)
            bak="${file}.bak_${timestamp}"
        fi

        echo "Backing up $file → $bak"
        mv "$file" "$bak"
    else
        echo "Skipping $file (not found)"
    fi
done

cd ~/dotfiles
stow .


echo -e "\e[35m --------------------  tmux  -------------------- \e[0m"
#TODO sudo apt install -y byobu # for now I dont use byobu
if command -v tmux >/dev/null 2>&1; then
    echo -e "\e[35m tmux is installed \e[0m"
else
    echo -e "\e[35m installing tmux \e[0m"
	sudo dnf install -y tmux
fi


echo -e "\e[35m --------------------  neovim  -------------------- \e[0m"
if command -v nvim >/dev/null 2>&1; then
	echo -e "\e[35m nvim is installed \e[0m"
else
    echo -e "\e[35m installing nvim \e[0m"
	cd ~
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim-linux-x86_64
	sudo mkdir -p /opt/nvim-linux-x86_64
	sudo chmod a+rX /opt/nvim-linux-x86_64
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin
	sudo rm -rf nvim-linux-x86_64.tar.gz
fi


echo -e "\e[35m --------------------  vim  -------------------- \e[0m"
if command -v vim >/dev/null 2>&1; then
	echo -e "\e[35m vim is installed \e[0m"
else
    echo -e "\e[35m installing vim \e[0m"
	sudo dnf install -y vim
fi


echo -e "\e[35m --------------------  sdkman  -------------------- \e[0m"
set +u
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
if command -v sdk >/dev/null 2>&1; then
	echo -e "\e[35m updating sdkman \e[0m"
    sdk selfupdate force
    sdk update
else
	echo -e "\e[35m installing sdkman \e[0m"
	curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
set -u


echo -e "\e[35m --------------------  zsh  -------------------- \e[0m"
if command -v zsh >/dev/null 2>&1; then
	echo -e "\e[35m zsh is installed \e[0m"
else
    echo -e "\e[35m installing zsh \e[0m"
    sudo dnf install -y zsh # install zsh
fi


echo -e "\e[35m --------------------  oh-my-zsh  -------------------- \e[0m"
if [[ -d ~/.oh-my-zsh ]]; then
    echo -e "\e[35m .oh-my-zsh exists \e[0m"
else
    echo -e "\e[35m installing oh-my-zsh \e[0m"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # install oh-my-zsh
fi


echo -e "\e[35m --------------------  deno  -------------------- \e[0m"
if command -v deno >/dev/null 2>&1; then
    echo -e "\e[35m deno is installed \e[0m"
    #TODO update deno???
else
    echo -e "\e[35m installing deno \e[0m"
    curl -fsSL https://deno.land/install.sh | sh
fi


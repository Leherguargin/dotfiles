#!/bin/bash

set -euo pipefail # stop script when error occured, no undeclared variables, propagate errors in pipes

printf "\033[35m -------------------- update, upgrade -------------------- \033[0m\n"
sudo apt update
sudo apt full-upgrade -y


printf "\033[35m -------------------- install utils -------------------- \033[0m\n"
sudo apt install -y man info curl wget tar gzip unzip zip git stow nano tree ripgrep xclip gettext-base ca-certificates


printf "\033[35m -------------------- stow configuration files -------------------- \033[0m\n"
backup_file() {
    local target="$1"

    # target exists and is not a link
    if [[ -e "$target" && ! -L "$target" ]]; then
        local backup="${target}.bak"

        # if backup also exists, add current date
        if [[ -e "$backup" ]]; then
            local timestamp
            timestamp=$(date +"%Y%m%d_%H%M%S")
            backup="${target}.bak.$timestamp"
        fi

        echo "backup old file: $target -> $backup"
        mv "$target" "$backup"
    fi
}

cd "$(dirname "$0")/.." # change directory to dotfiles

printf "\033[35m -------------------- git -------------------- \033[0m\n"
backup_file "$HOME/.gitconfig"
stow -v -t "$HOME" git

printf "\033[35m -------------------- tmux -------------------- \033[0m\n"
sudo apt install -y tmux
backup_file "$HOME/.tmux.conf"
stow -v -t "$HOME" tmux

printf "\033[35m -------------------- vim -------------------- \033[0m\n"
sudo apt install -y vim
backup_file "$HOME/.vimrc"
stow -v -t "$HOME" vim

printf "\033[35m -------------------- bash -------------------- \033[0m\n"
backup_file "$HOME/.bash_aliases"
backup_file "$HOME/.bashrc"
stow -v -t "$HOME" bash

printf "\033[35m -------------------- zsh -------------------- \033[0m\n"
backup_file "$HOME/.zshrc"
stow -v -t "$HOME" zsh


printf "\033[35m -------------------- install zsh -------------------- \033[0m\n"
if command -v zsh >/dev/null 2>&1; then
	echo "zsh is installed"
else
    echo "installing zsh"
    sudo apt install -y zsh
fi


printf "\033[35m -------------------- install oh-my-zsh -------------------- \033[0m\n"
if [[ -d ~/.oh-my-zsh ]]; then
    echo ".oh-my-zsh exists"
else
    echo "installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


# printf "\033[35m -------------------- install sdkman locally -------------------- \033[0m\n"
# set +u
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# if command -v sdk >/dev/null 2>&1; then
#     echo "updating sdkman"
#     sdk selfupdate force
#     sdk update
# else
# 	echo "installing sdkman"
# 	curl -s "https://get.sdkman.io" | bash
#     source "$HOME/.sdkman/bin/sdkman-init.sh"
# fi
# set -u


# printf "\033[35m -------------------- install pyenv locally -------------------- \033[0m\n"
# python_version=3.14
#
# if command -v pyenv >/dev/null 2>&1; then
# 	echo "updating python manager and python version"
# 	pyenv update
# else
# 	echo "installing pyenv, tools and python $python_version"
# 	sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
# 	curl https://pyenv.run | bash
# 	pyenv install $python_version
# 	pyenv global $python_version
# fi


# printf "\033[35m -------------------- install nvim globally -------------------- \033[0m\n"
# if command -v nvim >/dev/null 2>&1; then
# 	echo "nvim is installed"
# else
#     echo "installing nvim in /opt/nvim-linux-x86_64"
# 	cd ~
# 	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz # x86 doesnt work for arm
# 	sudo rm -rf /opt/nvim-linux-x86_64 # remove or backup?
#     sudo mkdir -p /opt/nvim-linux-x86_64 
#     sudo chmod a+rX /opt/nvim-linux-x86_64
# 	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
# 	sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin
# 	sudo rm -rf nvim-linux-x86_64.tar.gz
# fi
	

printf "\033[35m -------------------- autoremove -------------------- \033[0m\n"
sudo apt autoremove -y

echo "run sudo \`./install/global_sdkman.sh\` for global sdkman installation"
echo "run sudo \`./install/global_pyenv.sh\` for global pyenv installation"

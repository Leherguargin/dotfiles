#!/bin/bash

set -euo pipefail # stop script when error occured, no undeclared variables, propagate errors in pipes

printf "\033[35m -------------------- update and upgrade -------------------- \033[0m\n"
sudo dnf upgrade --refresh
sudo dnf clean all


printf "\033[35m --------------------  install utils -------------------- \033[0m\n"
sudo dnf install -y man info curl wget tar gzip unzip zip git stow nano tree make gcc xclip ca-certificates gettext
sudo dnf install -y fzf bat ripgrep


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
sudo dnf install -y tmux
backup_file "$HOME/.tmux.conf"
stow -v -t "$HOME" tmux

printf "\033[35m -------------------- vim -------------------- \033[0m\n"
sudo dnf install -y vim
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
    sudo dnf install -y zsh
fi


printf "\033[35m -------------------- install oh-my-zsh -------------------- \033[0m\n"
if [[ -d ~/.oh-my-zsh ]]; then
    echo ".oh-my-zsh exists"
    if [[ ! -e "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab" ]]; then
        git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
    fi
else
    echo "installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    backup_file "$HOME/.oh-my-zsh/custom/themes/darkblood-venv.zsh-theme
    stow -v -t "$HOME/.oh-my-zsh/custom/themes oh-my-zsh
fi


printf "\033[35m -------------------- autoremove -------------------- \033[0m\n"
sudo dnf autoremove -y

echo "run sudo \`./install/global_sdkman.sh\` for global sdkman installation"
echo "run sudo \`./install/global_pyenv.sh\` for global pyenv installation"

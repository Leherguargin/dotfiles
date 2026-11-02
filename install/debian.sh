set -euo pipefail # stop script when error occured, no undeclared variables, propagate errors in pipes

echo -e "\e[35m ---------- update, upgrade, and install utils ---------- \e[0m" # print in magenta
sudo apt update
sudo apt full-upgrade -y


#################### install utils ####################
sudo apt install -y man info curl wget tar gzip unzip zip \
git stow nano tree ripgrep xclip gettext-base ca-certificates \
tmux vim

echo -e "\e[35m -------------------------------------------------------- \e[0m"


#################### backup and stow dotfiles ####################
cd "$(dirname "$0")/.." # go to dir with files
files=".bash_aliases .bashrc .gitconfig .config .tmux.conf .vimrc .zshrc"
for f in files;; do
	if [[ -f "$f" ]]; then
		mv "$f" "$f.bak"
	fi
done
#stow -v -t ~ "$files" # create symbolic links in user home dir


########## zsh  oh-my-zsh ##########
if command -v zsh >/dev/null 2>&1; then
	echo -e "\e[35m zsh is installed \e[0m"
else
    echo -e "\e[35m installing zsh \e[0m"
    sudo apt install -y zsh # install zsh
fi


if [[ -d ~/.oh-my-zsh ]]; then
    echo -e "\e[35m .oh-my-zsh exists \e[0m"
else
    echo -e "\e[35m installing oh-my-zsh \e[0m"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # install oh-my-zsh
fi


#################### nvim ####################
# if command -v nvim >/dev/null 2>&1; then
# 	echo -e "\e[35m nvim is installed \e[0m"
# else
#     echo -e "\e[35m installing nvim \e[0m"
# 	cd ~
# 	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
# 	sudo rm -rf /opt/nvim-linux-x86_64 sudo mkdir -p /opt/nvim-linux-x86_64 sudo chmod a+rX /opt/nvim-linux-x86_64
# 	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
# 	sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin
# 	sudo rm -rf nvim-linux-x86_64.tar.gz
# fi


################################################# sdkman ##############################################
# set +u
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# if command -v sdk >/dev/null 2>&1; then
# 	echo -e "\e[35m updating sdkman \e[0m"
#     sdk selfupdate force
#     sdk update
# else
# 	echo -e "\e[35m installing sdkman \e[0m"
# 	curl -s "https://get.sdkman.io" | bash
#     source "$HOME/.sdkman/bin/sdkman-init.sh"
# fi
# set -u


############################################# python manager and python #################################
# python_version=3.14

# if command -v pyenv >/dev/null 2>&1; then
# 	echo -e "\e[35m updating python manager and python version \e[0m"
# 	pyenv update
# else
# 	echo -e "\e[35 installing pyenv, tools and python $python_version \e[0m"
# 	sudo apt install -y make build-essential libssl-dev zlib1g-dev \
# libbz2-dev libreadline-dev libsqlite3-dev  \
# libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
# libffi-dev liblzma-dev # install tools needed for compiling python from sources (no wheels(compiled versions) for raspberry)
# 	curl https://pyenv.run | bash
# 	# pyenv install $python_version
# 	# pyenv global $python_version
# fi
	

####################################################  autoremove  ###########################################################
echo -e "\e[35m autoremove \e[0m"
sudo apt autoremove -y

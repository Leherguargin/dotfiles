#!/bin/bash
set -euo pipefail # stop script when error occured, no undeclared variables, propagate errors in pipes

echo -e "\e[35m ---------- update, upgrade, and install utils ---------- \e[0m" # print in magenta
sudo apt update
sudo apt full-upgrade -y

source /etc/os-release
CODENAME="$VERSION_CODENAME"
# Docker supports only stable releases: bullseye (11) and bookworm (12) 
# For testing/unstable we fallback to bookworm
case "$CODENAME" in
    trixie|sid|testing|unstable) 
        echo "Detected Debian $CODENAME — using Docker repo for bookworm"
        CODENAME="bookworm" 
        ;;
esac


sudo apt install -y man info curl wget tar gzip unzip zip git stow nano tree make gcc ripgrep xclip gettext-base ca-certificates
#sudo apt install fzf # what is that? 
#sudo apt install tee # what is that?
echo -e "\e[35m -------------------------------------------------------- \e[0m"


#################################################  zsh  oh-my-zsh ###################################################
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


######################################################   tmux  #########################################################
#TODO sudo apt install -y byobu # for now I dont use byobu
if command -v tmux >/dev/null 2>&1; then
    echo -e "\e[35m tmux is installed \e[0m"
else
    echo -e "\e[35m installing tmux \e[0m"
	sudo apt install -y tmux
fi


#######################################################  vim  ###############################################
if command -v nvim >/dev/null 2>&1; then
	echo -e "\e[35m nvim is installed \e[0m"
else
    echo -e "\e[35m installing nvim \e[0m"
	cd ~
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim-linux-x86_64 sudo mkdir -p /opt/nvim-linux-x86_64 sudo chmod a+rX /opt/nvim-linux-x86_64
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin
	sudo rm -rf nvim-linux-x86_64.tar.gz
fi


if command -v vim >/dev/null 2>&1; then
	echo -e "\e[35m vim is installed \e[0m"
else
    echo -e "\e[35m installing vim \e[0m"
	sudo apt install -y vim
fi


############################################ net tools ###############################################
# net-tools
#TODO


############################################## c / cpp ###############################################
# c/cpp development tools
# TODO sudo apt install binutils clang # change test and dokoncz


############################################## avr utils #############################################
if command -v avr-gcc >/dev/null 2>&1; then
	echo -e "\e[35m avr-gcc is installed \e[0m"
else
    echo -e "\e[35m installing avr-gcc, avr-libc and binutils-avr \e[0m"
    sudo apt install -y gcc-avr avr-libc binutils-avr
fi


################################################# sdkman ##############################################
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


######################################  JavaScript / TypeScript  ######################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
if command -v nvm >/dev/null 2>&1; then
	echo -e "\e[35m nvm is installed \e[0m"
else
    echo -e "\e[35m installing nvm \e[0m"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
fi


if command -v deno >/dev/null 2>&1; then
	echo -e "\e[35m deno is installed \e[0m"
	#TODO update deno???
else
    echo -e "\e[35m installing deno \e[0m"
    curl -fsSL https://deno.land/install.sh | sh
fi

###########################################  Git  #####################################################
if [[ ! -f ~/.gitconfig ]]; then
    echo -e "\e[35m add email, name and default branch to global gitconfig \e[0m"
	git config --global user.email "maciejleszczynski1997@gmail.com"
	git config --global user.name "Maciej Leszczynski"
	git config --global init.defaultBranch main
    git config --global core.editor vim
fi


############################################ Docker ####################################################
if command -v docker >/dev/null 2>&1; then
    echo -e "\e[35m docker is installed \e[0m"
else
    echo -e "\e[35m installing docker \e]0m"
    source /etc/os-release
    CODENAME="$VERSION_CODENAME"

    # Docker supports only stable releases: bullseye (11) and bookworm (12) 
    # For testing/unstable we fallback to bookworm
    case "$CODENAME" in
        trixie|sid|testing|unstable) 
            echo "Detected Debian $CODENAME — using Docker repo for bookworm"
            CODENAME="bookworm" 
            ;;
    esac

    sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1) # uninstall all conflicting packages
    
    # set up docker's apt repository
    sudo install -m 0755 -d /etc/apt/keyrings # copy and set variables
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc # download keys
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # add the repository to apt sources
    {
        echo "Types: deb"
        echo "URIs: https://download.docker.com/linux/debian"
        echo "Suites: $CODENAME"
        echo "Components: stable"
        echo "Signed-By: /etc/apt/keyrings/docker.asc"
    } | sudo tee /etc/apt/sources.list.d/docker.sources
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

#################################################### Kubernetes Minikube Helm ###########################################
#TODO

echo -e "\e[35m autoremove \e[0m"
sudo apt autoremove -y


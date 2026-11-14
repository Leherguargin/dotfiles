alias l='ls -lFh' # todo dodaj podpisy do tych aliasów co robią, szczególnie ls itp, ujednolić bash z zsh
alias ll='ls -AlFh'
alias update='sudo apt update && sudo apt full-upgrade -y'
alias gui='sudo systemctl isolate graphical.target' # for set to boot gui as default: 'sudo systemctl set-default graphical.target'
alias cli='sudo systemctl isolate multi-user.target'
alias unlock='loginctl unlock-session 1' # for bugged KDE plasma
alias rd='rmdir'
alias md='mkdir -p'
alias py='python'
alias clip='clipcopy' #TODO probably do not work in bash, move this aliases to .zshrc or .bashrc and remove this file
#todo ogarnij notatki w konsoli (keenote, dnote???)
# zbacz impolementację take przez 'which take' w zsh/ohmyzsh, sprawdz jak dziala czyste zsh i co dodaje i inne powłoki oraz w czym są napisane
# jak działa ripgrep, fzf, narzędzia pythonowe (na koniec)
# narzędzia find, grep, ls, reszta!
# dokończ konfigurację zsh/ohmyzsh w .zshrc i wywal śmieci i komentarze z pliku tamtego
# 

take () {
    if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
            takeurl "$1"
    elif [[ $1 =~ ^(https?|ftp).*\.(zip)$ ]]
    then
            takezip "$1"
    elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]
    then
            takegit "$1"
    else
            takedir "$@"
    fi
}

mkcd () {
        mkdir -p $@ && cd ${@:$#}
}

if command -v minikube >/dev/null 2>&1; then # look for oh-my-zsh plugins for aliases for minikube etc.
    alias kubectl='minikube kubectl --'
fi

if command -v tmux >/dev/null 2>&1; then # look for oh-my-zsh plugins for aliases for tmux
    alias t='tmux attach -t 0 || tmux new -s 0'
fi

readln() {
    grep "$1" | head -n 1
}


# MUST BE HERE FOR GLOBAL SDKMAN TO WORK
if [[ -f /etc/profile.d/sdkman.sh ]]; then
	source /etc/profile.d/sdkman.sh
else
    if [[ -e "$HOME/.sdkman" ]]; then
        export SDKMAN_DIR="$HOME/.sdkman"
        [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    fi
fi

# MUST BE HERE FOR GLOBAL PYENV TO WORK
if [[ -f /etc/profile.d/pyenv.sh ]]; then
    source /etc/profile.d/pyenv.sh
    pyenv() {
        if [[ "$1" == "install" ]]; then
            local free_tmp_mb
            free_tmp_mb=$(df -Pm /tmp 2>/dev/null | awk 'NR==2 {print $4}')
            local limit=3000

            if [[ -z "$free_tmp_mb" || "$free_tmp_mb" -lt "$limit" ]]; then
                local new_temp="${XDG_CACHE_HOME:-$HOME/.cache}/pyenv-tmp"
                echo "[pyenv-wrapper] Free space in /tmp is ${free_tmp_mb:-0} MB (limit: ${limit} MB). Redirecting to $new_temp"
                mkdir -p "$new_temp"
                TMPDIR="$new_temp" command pyenv "$@"
                local return_code=$?
                rmdir "$new_temp" 2>/dev/null
                return "$return_code"
            fi
        fi

        command pyenv "$@"
    }
fi

# MUST BE HERE FOR GLOBAL NVIM TO WORD
if command -v nvim >/dev/null 2>&1; then
    alias nvim='nvim'

    if [[ -e ~/.config/nvim-astronvim ]]; then
        alias astro='NVIM_APPNAME=nvim-astro nvim'
    fi

    if [[ -e ~/.config/nvim-lazyvim ]]; then
        alias lv='NVIM_APPNAME=nvim-lazyvim nvim'
    fi

    if [[ -e ~/.config/nvim-nvchad ]]; then
        alias nc='NVIM_APPNAME=nvim-nvchad nvim'
    fi
fi

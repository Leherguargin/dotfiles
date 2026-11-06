alias l='ls -lFh'
alias ll='ls -AlFh'
alias tree='tree -l'
alias c='clear'
alias update='sudo apt update && sudo apt full-upgrade -y'
alias gui='sudo systemctl isolate graphical.target' # for set to boot gui as default: 'sudo systemctl set-default graphical.target'
alias cli='sudo systemctl isolate multi-user.target'
alias unlock='loginctl unlock-session 1' # for bugged KDE plasma
alias rd='rmdir'
alias md='mkdir -p'
alias g='git'
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'

take() {
	mkdir -p "$1" && cd "$1"
}

if command -v minikube >/dev/null 2>&1; then
    alias kubectl='minikube kubectl --'
fi

if command -v tmux >/dev/null 2>&1; then
    alias t='tmux attach -t 0 || tmux new -s 0'
fi

# clipboard managmant with klipper, xclip, xsel and wl-copy
clip() {
    local filtered
    if [ -n "$1" ]; then # first argument is pattern for grep
        filtered=$(grep "$1" | head -n 1) # read stdin, grep by first arg and take first match
    else
        filtered=$(cat) # only read stdin
    fi

    # Copy to KDE clipboard if qdbus is available TODO maybe sort it and use if-else and write also paste command with apropiate command (i napisz instrukcje do wszytkich w instrukcji z testami rodzajów buforow)
    if command -v qdbus >/dev/null 2>$1; then
        qdbus org.kde.klipper /klipper setClipboardContents "$filtered"
    fi

    # Copy to xclip if xclip is available
    if command -v xclip >/dev/null 2>&1; then
        echo "$filtered" | xclip -i # working with primary bufffer (selected text)
        echo "$filtered" | xclip -selection clipboard # working with clipboard buffer (copied text)
    fi

    # Copy to Wayland clipboard if wl-copy is available
    if command -v wl-copy >/dev/null 2>&1; then
        echo "$filtered" | wl-copy
    fi

    # Copy to xsel if xclip is available
    if command -v xsel >/dev/null 2>&1; then
        echo "$filtered" | xsel --clipboard --input
    fi
}

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

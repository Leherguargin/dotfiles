alias ll='ls -AlFh'
alias tree='tree -l'
alias c='clear'
alias update='sudo apt update && sudo apt full-upgrade -y'
alias gui='sudo systemctl isolate graphical.target' # for set to boot gui as default: 'sudo systemctl set-default graphical.target'
alias cli='sudo systemctl isolate multi-user.target'
alias unlock='loginctl unlock-session 1' # for bugged KDE plasma

if [[ ! $(which zsh) ]]; then
	take() {
		mkdir $1
		cd $1
	}
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

if [[ $(which tmux) ]]; then
	alias t='tmux attach -t 0 || tmux new -s 0'
fi

if [[ $(which nvim) ]]; then
    alias nvim='nvim'
    alias kvim='NVIM_APPNAME=nvim-kickstart nvim'
    alias lv='NVIM_APPNAME=nvim-lazyvim nvim'
    alias nc='NVIM_APPNAME=nvim-nvchad nvim'
    alias astro='NVIM_APPNAME=nvim-astro nvim'
fi

#
#export PATH=~/dev/zig/zig-linux-x86_64-0.15.0-dev.276+9bbac4288:$PATH # zig-lang
#export PATH=~/dev/go/go1.24.2.linux-amd64/go/bin:$PATH                # go-lang
#. "$HOME/.cargo/env"                                                  # rust tools
#[ -f "/home/oromisek/.ghcup/env" ] && . "/home/oromisek/.ghcup/env"   # ghcup-env (gnu haskel)

#export PATH=~/dev/languages/ocaml:$PATH                               # ocaml
#eval $(opam env)                                                      # ocaml package manager and tools

# nvm sdkman juliaup should add when installing (check) fix scripts to each check if language is installed and then initialize them (like hgcup does)


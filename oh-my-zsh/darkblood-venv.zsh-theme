# --- COLORS ---
RED='%{$fg[red]%}'
WHITE='%{$fg_bold[white]%}'
YELLOW='%{$fg[yellow]%}'
RESET='%{$reset_color%}'

wrap_with_red_brackets() {
    if [[ -n "$1" ]]; then # nie dziala bo moje bloki nie są jescze evaluowane
        echo "${RED}[${WHITE}$1${RESET}${RED}]${RESET}"
    fi
}

if [[ -f /etc/os-release ]]; then
  source /etc/os-release
  DISTRO_NAME=" $ID"
fi

get_distro_name() {
  echo "$DISTRO_NAME"
}

# venv in prompt config
ZSH_THEME_VENV_PREFIX="%{$fg[red]%}[%{$fg_bold[white]%}"
ZSH_THEME_VENV_SUFFIX="%{$fg[red]%}] %{$reset_color%}"

venv_prompt_info() {
  if [[ -n "${VIRTUAL_ENV}" ]]; then
    VENV_INFO="🐍 %{$fg_bold[white]%$(python3 --version | sed 's/Python//')%{$reset_color%}"
    echo "${ZSH_THEME_VENV_PREFIX=[}${VENV_INFO}${ZSH_THEME_VENV_SUFFIX=]}"
  fi
}

get_prompt() {
  USER_HOST_BLOCK="%n${RESET}${RED}@${WHITE}%m${RESET}"
  TTY_BLOCK="${WHITE}/dev/%y$(get_distro_name)${RESET}"
  VENV_BLOCK="$(venv_prompt_info)"
  ERROR_BLOCK="%(?,,${RED}[${WHITE}%?${RESET}${RED}])"

  PROMPT="${RED}┌${RESET}"
  PROMPT+="$(wrap_with_red_brackets $USER_HOST_BLOCK) "
  PROMPT+="$(wrap_with_red_brackets $TTY_BLOCK) "
  PROMPT+='$(venv_prompt_info)'
  PROMPT+='$(git_prompt_info)'
  PROMPT+="$ERROR_BLOCK"
  PROMPT+=$'\n'
  PROMPT+="${RED}└$(wrap_with_red_brackets %~)${RED}>${RESET} "
  return "$PROMPT"
}

# --- MAIN PROMPT ---
PROMPT="$(get_prompt)"

# SECONDARY PROMPT
PS2=$' ${RED}|>${RESET} '

# git in prompt config
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[red]%}] "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡%{$reset_color%}"

# # --- COLORS ---
# RED='%{$fg[red]%}'
# WHITE='%{$fg_bold[white]%}'
# RESET='%{$reset_color%}'

# wrap_with_red_brackets() {
#     if [[ -n "$1" ]]; then # nie dziala bo moje bloki nie są jescze evaluowane
#         echo "${RED}[${WHITE}$1${RESET}${RED}]${RESET}"
#     fi
# }

# # --- PYTHON VENV ---
# prompt_python_env() {
#   if [[ -n "$VIRTUAL_ENV" ]]; then
#     local venv_name=$(basename "$VIRTUAL_ENV")
#     local py_version=$("$VIRTUAL_ENV/bin/python" --version 2>/dev/null | awk '{print $2}')
#     echo "${RED}[${WHITE}${venv_name} ${py_version}${RESET}${RED}]${RESET}"
#   fi
# }

# USER_HOST_BLOCK="%n${RESET}${RED}@${WHITE}%m${RESET}"
# TTY_BLOCK="${WHITE}/dev/%y${RESET}"
# VENV_BLOCK="$(prompt_python_env)"
# GIT_BLOCK="%{$(git_prompt_info)%}"
# # ERROR_BLOCK="%(?,,${RED}[${WHITE}%?${RESET}${RED}])"

# # --- SKŁADANIE GŁÓWNEGO PROMPTU ---
# PROMPT="${RED}┌${RESET}"
# PROMPT+="$(wrap_with_red_brackets $USER_HOST_BLOCK) "
# PROMPT+="$(wrap_with_red_brackets $TTY_BLOCK) "
# PROMPT+="$(wrap_with_red_brackets $VENV_BLOCK) "
# PROMPT+="$(wrap_with_red_brackets $GIT_BLOCK) "
# # PROMPT+="$(wrap_with_red_brackets $ERROR_BLOCK)"
# PROMPT+=$'\n'
# PROMPT+="${RED}└$(wrap_with_red_brackets %~)${RED}>${RESET} "

# # SECONDARY PROMPT
# PS2=$' ${RED}|>${RESET} '

# # --- GIT PART CONFIGURATION ---
# ZSH_THEME_GIT_PROMPT_PREFIX="${RED}[${WHITE}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="${RESET}${RED}] "
# ZSH_THEME_GIT_PROMPT_DIRTY=" ${RED}⚡${RESET}"




###################################
# meh. Dark Blood Rewind, a new beginning.

PROMPT=$'%{$fg[red]%}┌[%{$fg_bold[white]%}%n%{$reset_color%}%{$fg[red]%}@%{$fg_bold[white]%}%m%{$reset_color%}%{$fg[red]%}] [%{$fg_bold[white]%}/dev/%y%{$reset_color%}%{$fg[red]%}] %{$(git_prompt_info)%}%(?,,%{$fg[red]%}[%{$fg_bold[white]%}%?%{$reset_color%}%{$fg[red]%}])
%{$fg[red]%}└[%{$fg_bold[white]%}%~%{$reset_color%}%{$fg[red]%}]>%{$reset_color%} '
PS2=$' %{$fg[red]%}|>%{$reset_color%}hahaha '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[red]%}] "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡%{$reset_color%}"

RESET='%{$reset_color%}'
RED='%{$reset_color%}%{$fg[red]%}'
WHITE='%{$reset_color%}%{$fg_bold[white]%}'

if [[ -f /etc/os-release ]]; then
  source /etc/os-release
  DISTRO_NAME=" $ID"
fi

get_distro_name() {
  echo "${DISTRO_NAME}"
}

venv_prompt_info() {
  if [[ -n "${VIRTUAL_ENV}" ]]; then
    local py_ver=""
    if [[ -x "${VIRTUAL_ENV}/bin/python" ]]; then
      py_ver=$("${VIRTUAL_ENV}/bin/python" --version 2>/dev/null | awk '{print $2}')
    fi
    echo "${prefix}🐍 ${py_ver:-venv}${suffix}"
  fi
}

git_prompt_info() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    return # not in git repo
  fi

  local branch_name
  branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || echo "detached")

  local dirty_flag=""
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    dirty_flag="⚡"
  fi

  local push_flag=""
  if git rev-parse @{u} >/dev/null 2>&1; then
    local ahead_count
    ahead_count=$(git rev-list @{u}..HEAD --count 2>/dev/null)
    if [[ "$ahead_count" -gt 0 ]]; then
      push_flag=" ${ahead_count}⬆"
    fi
  fi

  echo "${prefix}${branch_name}${dirty_flag}${push_flag}${suffix}"
}

set_prompt() {
    local prefix="${RED}[${WHITE}"
    local suffix="${RED}] ${RESET}"

    local user_host="${WHITE}%n${RED}@${WHITE}%m"
    local tty_info="/dev/%y$(get_distro_name)"
    local current_dir="%~"
    local error_block="%(?,,${prefix}%?${suffix})"

    PROMPT="${RED}┌[${RESET}"
    PROMPT+="${user_host}${suffix}"
    PROMPT+="${prefix}${tty_info}${suffix}"
    PROMPT+="$(venv_prompt_info)"
    PROMPT+="$(git_prompt_info)"
    PROMPT+="${error_block}"
    PROMPT+=$'\n'
    PROMPT+="${RED}└[${WHITE}${current_dir}${RED}]>${RESET} "

    local expanded_dir=$(print -P "%~")
    local len=${#expanded_dir}
    local spaces="${(l:$len:: :)}"
    PS2="  ${spaces}${RED}|>${RESET} "
}

# timer plugin config
TIMER_PRECISION=3
TIMER_FORMAT='%d'

# add hook for reload prompt each time
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_prompt

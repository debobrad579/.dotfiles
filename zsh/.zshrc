# Prompt
autoload -U colors && colors
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'

preexec() {
  timer_start=$EPOCHREALTIME
}

precmd() {
  if [[ -n "$timer_start" ]]; then
    timer_show=$(printf "%.2f" $(($EPOCHREALTIME - $timer_start)))
    unset timer_start
  fi
  vcs_info
  
  PROMPT=$_prompt_full
  RPROMPT='$(right_prompt_text)'
}

# Left Prompt
venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "%F{yellow}(${VIRTUAL_ENV:t})%f "
  fi
}

git_prompt() {
  if [[ -n "$vcs_info_msg_0_" ]]; then
    echo "%F{magenta}$vcs_info_msg_0_%f "
  fi
}

_prompt_full='$(venv_prompt)%F{green}%n@%m%f %F{blue}%~%f $(git_prompt)
%F{cyan}❯%f '
_prompt_transient='%F{cyan}❯%f '

PROMPT=$_prompt_full

# Right Prompt
right_prompt_text() {
  local exitcode=$?
  if [[ $exitcode -eq 130 ]]; then
    return
  fi

  if [[ $exitcode -eq 0 ]]; then
    local sec=${timer_show%.*}
    (( sec >= 1 )) && echo "%F{yellow}⏱ ${timer_show}s%f"
  elif [[ -n "$timer_show" ]]; then
    echo "%F{red}✖ $exitcode%f"
  fi
}

RPROMPT='$(right_prompt_text)'

# Transient Prompt
zle-line-init() {
  emulate -L zsh
  [[ $CONTEXT == start ]] || return 0
  PROMPT=$_prompt_full
  RPROMPT='$(cmd_time)'
  zle reset-prompt
}

zle-line-finish() {
  emulate -L zsh
  PROMPT=$_prompt_transient
  RPROMPT=''
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish

# Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light jeffreytse/zsh-vi-mode
zinit light Aloxaf/fzf-tab

autoload -U compinit && compinit

zinit cdreplay -q

# Remaps
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
zvm_after_init() {
  zvm_bindkey viins '^Y' autosuggest-accept
  zvm_bindkey viins '^P' history-beginning-search-backward
  zvm_bindkey viins '^N' history-beginning-search-forward

  zvm_bindkey vicmd 'p' zvm_vi_put_after
  zvm_bindkey vicmd 'P' zvm_vi_put_before

  if command -v tmux-sessionizer &>/dev/null; then
    bindkey -s '^f' "tmux-sessionizer\n"
    bindkey -s '\eh' "tmux-sessionizer -s 0\n"
    bindkey -s '\ej' "tmux-sessionizer -s 1\n"
    bindkey -s '\ek' "tmux-sessionizer -s 2\n"
    bindkey -s '\el' "tmux-sessionizer -s 3\n"
  fi

  _paste_after() {
    local clip=$(xclip -o -selection clipboard 2>/dev/null)
    LBUFFER="${LBUFFER}${RBUFFER:0:1}${clip}"
    RBUFFER="${RBUFFER:1}"
  }
  _paste_before() {
    local clip=$(xclip -o -selection clipboard 2>/dev/null)
    LBUFFER="${LBUFFER}${clip}"
  }
  zle -N _paste_after
  zle -N _paste_before
  zvm_bindkey vicmd 'p' _paste_after
  zvm_bindkey vicmd 'P' _paste_before
}

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Tab Completion
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Aliases
alias ls="ls --color"

# Exports
export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Auto activate virtual evironment
auto_venv() {
  [[ -n "$VIRTUAL_ENV" ]] && return

  for d in .venv venv env; do
    if [[ -f "$PWD/$d/bin/activate" ]]; then
      source "$PWD/$d/bin/activate"
      return
    fi
  done
}

autoload -U add-zsh-hook
add-zsh-hook chpwd auto_venv

auto_venv

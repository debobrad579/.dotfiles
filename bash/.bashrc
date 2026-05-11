[[ $- != *i* ]] && return

set -o vi

HISTSIZE=5000
HISTFILESIZE=5000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a; history -n"

PS1="\[\e[1;32m\]\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \$ "

alias ls="ls --color=auto"
alias grep="grep --color=auto"

export EDITOR="vim"
export VISUAL="$EDITOR"
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$HOME/go/bin:$HOME/.cargo/bin:$PATH"

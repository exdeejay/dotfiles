#!/bin/bash

alias grep='grep --color=auto'
alias egrep='grep -E'
alias diff='diff --color=auto'
alias ip='ip -c'
alias gdb='gdb -q'
alias tmux='tmux -2'
# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

alias ..='cd ..'
alias cd..='cd ..'

alias la='ls -A'
alias l='ls'

# Use lsa script if it exists
if command -v lsa >/dev/null 2>&1; then
    alias ls='lsa'
fi

# Default gdb to pwndbg (or fallback to gef)
if [ -d "$HOME/.pwndbg" ]; then
    alias gdb='gdb-pwndbg'
elif [ -d "$HOME/.gdbinit-gef.py" ]; then
    alias gdb='gdb-gef'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat'
elif command -v batcat >/dev/null 2>&1; then
    alias cat='batcat'
fi

#!/bin/bash

alias grep='grep --color=auto'
alias egrep='grep -E'
alias diff='diff --color=auto'
alias ip='ip -c'
alias gdb='gdb -q'

alias ..='cd ..'
alias cd..='cd ..'

alias la='ls -A'
alias ls='lsa'
alias l='ls'

[ -x "$HOME/.pwndbg" ] && alias gdb='gdb-pwndbg'
[ -n "$(which bat)" ] && alias cat='bat'



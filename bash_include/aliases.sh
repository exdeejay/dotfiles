#!/bin/bash

# enable color support of various commands
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
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



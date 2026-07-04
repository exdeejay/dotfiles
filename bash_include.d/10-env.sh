#!/bin/bash
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export EDITOR=vim
export VISUAL=vim

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="&:ls:[bf]g:exit"

export LESSHISTFILE="-"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS -m --reverse"

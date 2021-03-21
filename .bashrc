# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

DOTFILES_DIR="$(dirname "$(realpath ".bashrc")")"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="&:ls:[bf]g:exit"
# append to the history file, don't overwrite it
shopt -s histappend
# combine multiline commands into one in history
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


if [ -d "$HOME/.bash_include" ]; then
	for f in $(find "$HOME/.bash_include" -type f); do
		source "$f"
	done
fi



# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

alias ..='cd ..'
alias cd..='cd ..'

if [ -z "$TMUX" ] && [ -n "$SSH_TTY" ] && [[ $- =~ i ]]; then
	tmux attach-session -t ssh || tmux new-session -s ssh
	exit
fi


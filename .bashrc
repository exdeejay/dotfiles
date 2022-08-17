# If not running interactively, don't do anything
[[ $- =~ i ]] || return

DOTFILES_DIR="$(dirname "$(realpath ".bashrc")")"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
	export PATH="$HOME/.local/bin:$PATH"
fi
export PATH="$DOTFILES_DIR/bin:$PATH"


# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="&:ls:[bf]g:exit"

## SHOPTS ##
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
# Automatically cd without prepending cd
shopt -s autocd
# Turn on extended glob patterns
shopt -s extglob
# Prevent shell redirection from overwriting files (use >| to override)
set -o noclobber

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

# More formatted `ls` command, specifically to separate dotfiles and regular files
lsa() {
	LS='ls --color=auto'

	if [[ ! -t 1 ]]; then
		\ls "$@"
		return 0
	fi

	args=()
	mainfiles=()
	hiddenfiles=()

	# separate args into dash commands and actual files
	for arg in "$@"; do
		if egrep -q '^-' <<< "$arg"; then
			args+=("$arg")
		else
			# split files into hidden and non-hidden
			if egrep -q '^\.' <<< "$arg"; then
				hiddenfiles+=("$arg")
			else
				mainfiles+=("$arg")
			fi
		fi
	done

	files=( "${mainfiles[@]}" "${hiddenfiles[@]}" )
	# if files are specified, list only those files
	if [[ ${#files[@]} != 0 ]]; then
		# if only one file is specified, act like normal, but just in that directory
		if [[ ${#files[@]} == 1 ]]; then
			pushd "${files[0]}" &> /dev/null
			lsa "${args[@]}"
			popd &> /dev/null
		else
			if [[ ${#hiddenfiles[@]} != 0 ]]; then
				echo '---  dotfiles  ---'
				$LS -A "${args[@]}" "${hiddenfiles[@]}"
				[[ ${#mainfiles[@]} != 0 ]] && echo -e '\n--- main files ---'
			fi
			if [[ ${#mainfiles[@]} != 0 ]]; then
				$LS -A "${args[@]}" "${mainfiles[@]}"
			fi
		fi
	else
		# no files specified, list and categorize files in current directory
		hiddenfiles=( $( $LS -A | egrep '^\.([^\.]|.{2,})$' ) )
		mainfiles=( $( $LS | egrep '^[^.]' ) )
		if [[ ${#hiddenfiles[@]} != 0 ]]; then
			echo '---  dotfiles  ---'
			$LS -d "${args[@]}" "${hiddenfiles[@]}"
			[[ ${mainfiles[@]} != 0 ]] && echo -e '\n--- main files ---'
		fi
		if [[ ${#mainfiles[@]} != 0 ]]; then
			$LS "${args[@]}"
		fi
	fi
}

[ -n "$(which bat)" ] && alias cat='bat'

if [ -d "$HOME/.bash_include" ]; then
	for f in $(find "$HOME/.bash_include" -type f); do
		source "$f"
	done
fi

alias detach="tmux detach -E 'DETACH=yes $SHELL -li'"

attach() {
	if [ -z "$TMUX" ] && [[ $- =~ i ]]; then
		tmux has && exec tmux attach || exec tmux
	fi
}

[[ -z "$DETACH" && -n "$(which tmux)" ]] && attach || unset DETACH


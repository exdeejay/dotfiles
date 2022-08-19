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
[[ -z "$RECORD" && -n "$(which asciinema)" ]] && RECORD="yes"

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
# Error when glob doesn't match any files
shopt -s failglob
# Match dotfiles when expanding globs
shopt -s dotglob
# Fix small spelling mistakes on cd
shopt -s cdspell
# Fix small spelling mistakes on tab completion
shopt -s dirspell
# Prevent shell redirection from overwriting files (use >| to override)
set -o noclobber
# Turn on vi keybinds
set -o vi

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
		if [[ ${#files[@]} == 1 && -d "${files[0]}" ]]; then
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

makereal() {
	if [[ $# != 1 ]]; then
		echo 'Usage: makereal <symlink>'
		return 1
	fi
	if [[ ! -h "$1" ]]; then
		echo "Error: $1 is not a symlink"
		return 1
	fi
	REAL="$(readlink -f "$1")"
	rm "$1"
	cp -r "$REAL" "$1"
	echo "$1"
}

[ -n "$(which bat)" ] && alias cat='bat'

if [ -d "$HOME/.bash_include" ]; then
	for f in $(find "$HOME/.bash_include" -type f); do
		source "$f"
	done
fi

alias detach="tmux detach -E 'DETACH=yes RECORD=no $SHELL -li'"

record_command() {
	[[ ! -d "$HOME/.casts" ]] && mkdir "$HOME/.casts"
	if [[ ! -d "$HOME/.casts/$(date -I)" ]]; then
		for dir in "$(find "$HOME/.casts" -mindepth 1 -maxdepth 1 ! -iname '*.tar.gz')"; do
			for unzipped in "$dir"/*.cast; do
				gzip "$unzipped"
			done
			tar -C "$(dirname "$dir")" -czf "$dir.tar.gz" "$(basename "$dir")"
			rm -r "$dir"
		done
		mkdir -p "$HOME/.casts/$(date -I)"
	fi
	CAST_OUTPUT="$HOME/.casts/$(date -I)/$(date -u +%T).cast"
	asciinema rec -q -i 5 -c "$*" "$CAST_OUTPUT"
	gzip "$CAST_OUTPUT"
}

attach() {
	if [[ -z "$TMUX" && "$-" =~ i ]]; then
		if [[ "$RECORD" == "yes" ]]; then
			record_command tmux new-session -t session-group
			exit
		else
			tmux new-session -t session-group
		fi
	fi
}

[[ -z "$DETACH" && -n "$(which tmux)" ]] && attach || unset DETACH


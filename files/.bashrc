#!/bin/bash
# .bashrc gets sourced if shell is interactive but not login
# (like a subshell or tmux session)

# If not running interactively, don't do anything
[[ $- =~ i ]] || return

# Since this script isn't guaranteed to be in $PWD, get accurate ROOT_DIR
DOTFILES_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
ROOT_DIR="$(realpath "$DOTFILES_DIR/..")"

# Source default bash scripts
for f in $(find "$ROOT_DIR/bash_include.d/" -maxdepth 1 -type f); do
    source "$f"
done

# Source local include files
if [[ -r "$HOME/.bash_include" ]]; then
    source "$HOME/.bash_include"
fi
if [[ -d "$HOME/.bash_include.d/" ]]; then
	for f in $(find "$HOME/.bash_include.d/" -maxdepth 1 -type f); do
		source "$f"
	done
fi

# Enter tmux if not already inside
[[ -z "$DETACH" ]] && attach || unset DETACH


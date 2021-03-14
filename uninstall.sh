#!/usr/bin/env bash

cd "$(dirname $0)"

DOTFILES_DIR="$(pwd)"

echo "Removing dotfiles..."

for link in $(find "$HOME" -maxdepth 1 -type l); do
	if [ "$(dirname $(realpath "$link"))" == "$DOTFILES_DIR" ]; then
		rm -rf "$link"
		echo "Removed $(basename "$link")"
	fi
done

unset DOTFILES_DIR
unset DOTFILES

echo "done"


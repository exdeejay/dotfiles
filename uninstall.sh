#!/usr/bin/env bash

cd "$(dirname $0)"
DOTFILES_DIR="$(pwd)"

if [ "$OSTYPE" == "msys" ]; then
	echo "!!! VERY DANGER !!!"
	echo "Not implemented yet! May remove stuff you need!"
	echo "Exiting..."
	return
fi


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

